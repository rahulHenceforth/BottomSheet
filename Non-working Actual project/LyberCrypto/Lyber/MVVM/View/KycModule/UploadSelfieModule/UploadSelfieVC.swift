//
//  UploadSelfieVC.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 08/09/21.
//

import UIKit
import AVFoundation

class UploadSelfieVC: UIViewController {
    
    //MARK:- IB OUTLETS
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var btnTakePhoto: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblDesc: UILabel!
    
    
    var captureSession: AVCaptureSession!
    var stillImageOutput: AVCapturePhotoOutput!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetUp()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .medium
        
        guard let frontCamera = AVCaptureDevice.default(AVCaptureDevice.DeviceType.builtInWideAngleCamera, for: .video, position: .front) else {
            print("Unable to access back camera!")
            return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: frontCamera)
            stillImageOutput = AVCapturePhotoOutput()
            
            if captureSession.canAddInput(input) && captureSession.canAddOutput(stillImageOutput) {
                captureSession.addInput(input)
                captureSession.addOutput(stillImageOutput)
                setupLivePreview()
            }
            
        }
        catch let error  {
            print("Error Unable to initialize back camera:  \(error.localizedDescription)")
        }
        
        func setupLivePreview() {
            previewView.layer.masksToBounds = true
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            
            videoPreviewLayer.videoGravity = .resizeAspectFill
            videoPreviewLayer.connection?.videoOrientation = .portrait
            videoPreviewLayer?.frame = previewView.layer.bounds
            previewView.layer.addSublayer(videoPreviewLayer)
            
            //Step12
        }
        
        DispatchQueue.global(qos: .userInitiated).async { //[weak self] in
            self.captureSession.startRunning()
        }
        
        DispatchQueue.main.async {
            self.videoPreviewLayer.frame = self.previewView.bounds
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.captureSession.stopRunning()
    }
    
}

//MARK:- INITIAL SET UP
extension UploadSelfieVC{
    func initialSetUp(){
        
        CommmonUI.initialLbl(lbl: lblHeader, text: L10n.Take_Selfie.description, textColor: .appWhiteColor, font: .MontserratBold(Size.XXXLarge.sizeValue()))
        CommmonUI.initialLbl(lbl: lblDesc, text: L10n.Take_Selfie_Desc.description, textColor: .appWhiteColor, font: .MontserratMedium(Size.Large.sizeValue()))
        
        DispatchQueue.main.async {
            CommonFunctions.headerShadow(view: self.previewView, color: UIColor(netHex: 0x009EE1DB), opacity: 0.86, radius: 4, viewRadii: 120)
            self.previewView.layer.borderWidth = 2
            self.previewView.layer.borderColor = UIColor.GradientSecondColor.cgColor
        }
        
//        let screenWidth = (CGFloat(view.frame.width)/2)
//        let roundView  = self.createOverlay(frame: view.frame, xOffset: view.frame.midX, yOffset: view.frame.midY + 28, radius: (screenWidth - 20))
//        view.addSubview(roundView)
//        view.bringSubviewToFront(roundView)
//        view.bringSubviewToFront(btnTakePhoto)
        
        btnTakePhoto.addTarget(self, action: #selector(btnTakePhotoTapped), for: .touchUpInside)
    }
    
//    func createOverlay(frame: CGRect, xOffset: CGFloat, yOffset: CGFloat, radius: CGFloat) -> UIView {
//        let overlayView = UIView(frame: frame)
//        CommonFunctions.headerShadow(view: overlayView, color: UIColor(netHex: 0x009EE1DB), opacity: 0.86, radius: 4)
//        overlayView.layer.borderWidth = 2
//        overlayView.layer.borderColor = UIColor.GradientSecondColor.cgColor
//        overlayView.backgroundColor = UIColor(netHex: 0x13455BFF).withAlphaComponent(0.8)
//        let path = CGMutablePath()
//        path.addArc(center: CGPoint(x: xOffset, y: yOffset),radius: radius, startAngle: 0.0, endAngle: 2.0 * .pi, clockwise: false)
//        path.addRect(CGRect(origin: CGPoint(x: 0, y: previewView.frame.origin.y), size: overlayView.frame.size))
////        path.addRect(CGRect(origin: .zero, size: CGSize(width: overlayView.frame.size.width, height: overlayView.frame.size.height / 2)))
//        let maskLayer = CAShapeLayer()
//
//        maskLayer.backgroundColor = UIColor.black.cgColor
//        maskLayer.path = path
//        maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
//        maskLayer.fillRule = .evenOdd
//        overlayView.layer.mask = maskLayer
//        overlayView.clipsToBounds = true
//        return overlayView
//    }
}

// MARK:- BUTTON ACTIONS
extension UploadSelfieVC{
    
    @objc func btnTakePhotoTapped(sender: UIButton){
        let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
        stillImageOutput.capturePhoto(with: settings, delegate: self)
    }
}

// MARK:- IMAGE PICKER DELEGATE
extension UploadSelfieVC: AVCapturePhotoCaptureDelegate{
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        guard let imageData = photo.fileDataRepresentation()
        else { return }
        
        let image = UIImage(data: imageData)
        //        captureImageView.image = image
        
        let vc = ProfileVerificationVC.instantiateFromAppStoryboard(appStoryboard: .Main)
        vc.screenType = .Verification
        self.navigationController?.pushViewController(vc, animated: true)
    }
}



//class CustomCameraVC: UIViewController {
//
//    //    MARK:- Outlets
//    @IBOutlet weak var ClickBtn: UIButton!
//    @IBOutlet weak var cameraView: UIView!
//
//    //MARK:- Variables
//    var captureSession: AVCaptureSession!
//    var stillImageOutput: AVCapturePhotoOutput!
//    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
//
//    //    MARK:- Life Cycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        self.setupUI()
//    }
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        self.captureSession.stopRunning()
//    }
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//    }
//
//    //    MARk:- Button Action
//    @available(iOS 11.0, *)
//    @IBAction func clickAtn(_ sender: Any) {
//        let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
//        stillImageOutput.capturePhoto(with: settings, delegate: self)
//    }
//}


//extension CustomCameraVC: AVCapturePhotoCaptureDelegate{
//    func setupUI() {
//        self.ClickBtn.layer.cornerRadius = self.ClickBtn.frame.width/2
//        self.ClickBtn.layer.borderColor = UIColor.red.cgColor
//        self.ClickBtn.layer.borderWidth = 2
//        self.ClickBtn.clipsToBounds = true
//        
//        let screenWidth = (CGFloat(view.frame.width)/2)
//        let roundView  = self.createOverlay(frame: view.frame, xOffset: view.frame.midX, yOffset: view.frame.midY, radius: (screenWidth - 20))
//        view.addSubview(roundView)
//        view.bringSubviewToFront(roundView)
//        
//        captureSession = AVCaptureSession()
//        captureSession.sessionPreset = .medium
//        guard let backCamera = AVCaptureDevice.default(for: AVMediaType.video)
//        else {
//            print("Unable to access back camera!")
//            return
//        }
//        do {
//            let input = try AVCaptureDeviceInput(device: backCamera)
//            stillImageOutput = AVCapturePhotoOutput()
//            stillImageOutput = AVCapturePhotoOutput()
//            if captureSession.canAddInput(input) && captureSession.canAddOutput(stillImageOutput) {
//                captureSession.addInput(input)
//                captureSession.addOutput(stillImageOutput)
//                setupLivePreview()
//            }
//        }
//        catch let error  {
//            print("Error Unable to initialize back camera:  \(error.localizedDescription)")
//        }
//    }
//    
//    func setupLivePreview() {
//        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
//        videoPreviewLayer.videoGravity = .resizeAspect
//        videoPreviewLayer.connection?.videoOrientation = .portrait
//        self.cameraView.layer.addSublayer(videoPreviewLayer)
//        
//        DispatchQueue.global(qos: .userInitiated).async { //[weak self] in
//            self.captureSession.startRunning()
//        }
//        DispatchQueue.main.async {
//            self.videoPreviewLayer.frame = self.cameraView.bounds
//        }
//    }
//    
//    func createOverlay(frame: CGRect,xOffset: CGFloat, yOffset: CGFloat, radius: CGFloat) -> UIView {
//        let overlayView = UIView(frame: frame)
//        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
//        let path = CGMutablePath()
//        path.addArc(center: CGPoint(x: xOffset, y: yOffset),radius: radius, startAngle: 0.0, endAngle: 2.0 * .pi, clockwise: false)
//        path.addRect(CGRect(origin: .zero, size: overlayView.frame.size))
//        let maskLayer = CAShapeLayer()
//        maskLayer.backgroundColor = UIColor.black.cgColor
//        maskLayer.path = path
//        maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
//        maskLayer.fillRule = .evenOdd
//        overlayView.layer.mask = maskLayer
//        overlayView.clipsToBounds = true
//        return overlayView
//    }
//    
//    @available(iOS 11.0, *)
//    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
//        guard let imageData = photo.fileDataRepresentation()
//            else { return }
//        let image = UIImage(data: imageData)
//        print(image)
//        //captureImageView.image = image
//    }
//}
