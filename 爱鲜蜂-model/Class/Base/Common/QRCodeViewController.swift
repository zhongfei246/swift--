//
//  QRCodeViewController.swift
//  爱鲜蜂-model
//
//  Created by lizhongfei on 11/5/16.
//  Copyright © 2016年 lizhongfei. All rights reserved.
//

import UIKit
import AVFoundation

class QRCodeViewController: BaseViewController,AVCaptureMetadataOutputObjectsDelegate {

    var qrCodeFrameView: UIView?
    let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
    let session = AVCaptureSession()  // 二维码生成的绘画
    var layer: AVCaptureVideoPreviewLayer? // 二维码生成的图层
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.title = "二维码扫描"
        self.view.backgroundColor = UIColor.grayColor()
        let labIntroudction = UILabel(frame:CGRectMake(15, 10, ScreenWidth-30, 50))
        labIntroudction.backgroundColor = UIColor.clearColor()
        labIntroudction.numberOfLines = 2
        labIntroudction.textColor = UIColor.whiteColor()
        labIntroudction.text = "请将二维码图像置于摄像头视野范围内，离手机摄像头10CM左右，系统会自动识别。"
        self.view.addSubview(labIntroudction)
        
        //扫描二维码之后在二维码周围搞一个绿色的框（view）
        qrCodeFrameView = UIView()
        qrCodeFrameView?.layer.borderColor = UIColor.greenColor().CGColor
        qrCodeFrameView?.layer.borderWidth = 2
        view.addSubview(qrCodeFrameView!)
        view.bringSubviewToFront(qrCodeFrameView!)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        qrCodeFrameView?.frame = CGRectZero
        self.setupCamera()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.session.running {
            self.session.stopRunning()
        }
    }
    
    func setupCamera(){
        self.session.sessionPreset = AVCaptureSessionPresetHigh
        var error : NSError?
        let input: AVCaptureDeviceInput!
        do {
            input = try AVCaptureDeviceInput(device: device)
        } catch var error1 as NSError {
            error = error1
            input = nil
        }
        if (error != nil && input == nil) {
            var errorAlert = UIAlertView(title: "提醒", message: "请在iPhone的\"设置-隐私-相机\"选项中,允许本程序访问您的相机或者请在真机测试！", delegate: self, cancelButtonTitle: "确定")
            errorAlert.show()
            return
        }
        if session.canAddInput(input) {
            session.addInput(input)
        }
        layer = AVCaptureVideoPreviewLayer(session: session)
        //AVLayerVideoGravityResizeAspect 保持视频的宽高比并使播放内容自动适应播放窗口的大小
        //AVLayerVideoGravityResizeAspectFill 它是以播放内容填充而不是适应播放窗口的大小
        //AVLayerVideoGravityResize最后一个值会拉伸播放内容以适应播放窗口
        layer!.videoGravity = AVLayerVideoGravityResizeAspectFill
        //可以看到的镜头区域
        layer!.frame = CGRectMake(0, 0,ScreenWidth,ScreenHeight)
        self.view.layer.insertSublayer(self.layer!, atIndex: 0)
        
        let output = AVCaptureMetadataOutput()
        //设置响应区域
        //        output.rectOfInterest = CGRectMake(0, 0, 0, 0)
        output.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue()) //代理
        if session.canAddOutput(output) {
            session.addOutput(output)
            output.metadataObjectTypes = [AVMetadataObjectTypeQRCode];
        }
        
        session.startRunning()
    }
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        
        /**
         *
         print(metadataObjects):
         
         [<AVMetadataMachineReadableCodeObject: 0x17022bc60, type="org.iso.QRCode", bounds={ 0.3,0.1 0.2x0.3 }>corners { 0.3,0.4 0.5,0.4 0.5,0.1 0.3,0.1 }, time 203709097258625, stringValue "http://weixin.qq.com/r/vkz07PTES6k0rbCP9xms"]
         
         这是我随便拿个抽纸扫出来的结果，我只是取了里面的stringValue并进行了跳转，大家可根据业务需求进行相应的处理，这里把代理接口留给大家
         */
        
        var stringValue:String?
        if metadataObjects.count > 0 {
            
            let metadataObject = metadataObjects[0] as!AVMetadataMachineReadableCodeObject
            // 通过这行代码可以获取映入手机屏幕的二维码的边界进而把边界赋值给一个绿色方块view的frame，这样这个view就刚好照在了二维码的上面，不过刚开始没有扫到二维码时frame的size为0，所以这个绿色的view不会出现
                let barCodeObject = layer?.transformedMetadataObjectForMetadataObject(metadataObject as AVMetadataMachineReadableCodeObject) as! AVMetadataMachineReadableCodeObject
                qrCodeFrameView!.frame = barCodeObject.bounds
            
            stringValue = metadataObject.stringValue
            
            if stringValue != nil {
            
                self.session.stopRunning()
                weak var tempSelf = self
                let time = dispatch_time(DISPATCH_TIME_NOW, Int64(0.5 * Double(NSEC_PER_SEC)))
                dispatch_after(time, dispatch_get_main_queue(), { () -> Void in
                    
                    let webVC = WebViewController(navigationTitle: "扫描结果", urlStr: stringValue!)
                    tempSelf!.navigationController?.pushViewController(webVC, animated: true)
                })
            }
            
        } else { //No QR code is detected
        
            qrCodeFrameView?.frame = CGRectZero
            return
        }
        
    }
    
}
