//
//  ScanDocumentVC.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 07/09/21.
//

import UIKit
import AVKit

class ScanDocumentVC: UIViewController {
    
    //MARK:- IB OUTLETS
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var imgFrontBack: UIImageView!
    @IBOutlet weak var btnScanNow: AppBlueButton!
    @IBOutlet weak var vwCamera: UIView!
    @IBOutlet weak var btnRetake: UIButton!
    @IBOutlet weak var btnTakePic: UIButton!
    @IBOutlet weak var stackBtn: UIStackView!
    
    //    var isFrontSide = true
    var scannedImages = [UIImage]()
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
        
        guard let frontCamera = AVCaptureDevice.default(AVCaptureDevice.DeviceType.builtInWideAngleCamera, for: .video, position: .back) else {
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
            vwCamera.layer.masksToBounds = true
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            vwCamera.layer.cornerRadius = 20
            videoPreviewLayer.videoGravity = .resizeAspectFill
            videoPreviewLayer.connection?.videoOrientation = .portrait
            videoPreviewLayer?.frame = vwCamera.layer.bounds
            vwCamera.layer.addSublayer(videoPreviewLayer)
            
            //Step12
        }
        
        DispatchQueue.global(qos: .userInitiated).async { //[weak self] in
            self.captureSession.startRunning()
        }
        
        DispatchQueue.main.async {
            self.videoPreviewLayer.frame = self.vwCamera.bounds
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.captureSession.stopRunning()
    }
    
}

//MARK:- INITIAL SET UP
extension ScanDocumentVC{
    func initialSetUp(){
        
        CommmonUI.initialLbl(lbl: lblHeader, text: L10n.Front_card_photo.description, textColor: .appWhiteColor, font: .MontserratBold(Size.XXXLarge.sizeValue()))
        CommmonUI.initialLbl(lbl: lblDesc, text: L10n.Scan_Desc.description, textColor: .appWhiteColor, font: .MontserratMedium(Size.Large.sizeValue()))
        btnScanNow.setTitle(L10n.Next.description, for: .normal)
        
        btnScanNow.addTarget(self, action: #selector(btnScanNowTapped), for: .touchUpInside)
        btnRetake.addTarget(self, action: #selector(btnRetakeTapped), for: .touchUpInside)
        btnTakePic.addTarget(self, action: #selector(btnTakePicTapped), for: .touchUpInside)
        btnBack.addTarget(self, action: #selector(btnBackTapped), for: .touchUpInside)
        
        imgFrontBack.layer.cornerRadius = 20
        CommmonUI.borderdBtn(btn: btnRetake, title: L10n.RETAKE.description, titlecolor: .appWhiteColor, bgColor: .appWhiteColor.withAlphaComponent(0.24), borderColor: .clear, borderWidth: 0, font: .MontserratBold(Size.Medium.sizeValue()), cornerRadius: 20)
        
        self.imgFrontBack.isHidden = true
        self.stackBtn.isHidden = true
        
        //        let vc = CustomScannerVC.instantiateFromAppStoryboard(appStoryboard: .Kyc)
        //        vc.headerText = self.lblHeader.text ?? ""
        //        self.navigationController?.pushViewController(vc, animated: false)
        
    }
}


// MARK:- BUTTON ACTIONS
extension ScanDocumentVC{
    
    @objc func btnScanNowTapped(sender: UIButton){
        self.scannedImages.append(imgFrontBack.image ?? UIImage())
        self.imgFrontBack.isHidden = true
        self.stackBtn.isHidden = true
        self.btnTakePic.isHidden = false
        self.lblHeader.text = L10n.Back_card_photo.description
        
        if self.scannedImages.count > 1{
            let vc = UploadSelfieVC.instantiateFromAppStoryboard(appStoryboard: .Kyc)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func btnRetakeTapped(sender: UIButton){
        self.imgFrontBack.isHidden = true
        self.stackBtn.isHidden = true
        self.btnTakePic.isHidden = false
    }
    
    @objc func btnTakePicTapped(sender: UIButton){
        let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
        stillImageOutput.capturePhoto(with: settings, delegate: self)
    }
    
    @objc func btnBackTapped(sender: UIButton){
        self.navigationController?.popViewController(animated: true)
        self.scannedImages.removeAll()
    }
    
}

// MARK:- IMAGE PICKER DELEGATE
extension ScanDocumentVC: AVCapturePhotoCaptureDelegate{
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        guard let imageData = photo.fileDataRepresentation() else { return }
        
        guard let image = UIImage(data: imageData) else { return }
        self.imgFrontBack.isHidden = false
        self.imgFrontBack.image = image
        self.stackBtn.isHidden = false
        self.btnTakePic.isHidden = true
        
        if self.scannedImages.count >= 1{
            self.btnScanNow.setTitle(L10n.DONE.description, for: .normal)
        }
    }
}
