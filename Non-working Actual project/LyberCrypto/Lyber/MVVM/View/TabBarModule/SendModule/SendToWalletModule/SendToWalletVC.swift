//
//  SendToWalletVC.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 13/09/21.
//

import UIKit
import SkyFloatingLabelTextField

class SendToWalletVC: UIViewController {
    
    //MARK:- IB OUTLETS
    @IBOutlet weak var vwTopLine: UIView!
    @IBOutlet weak var lblWalletAddress: UILabel!
    @IBOutlet weak var vwCoin: UIView!
    @IBOutlet weak var lblCoinNmae: UILabel!
    @IBOutlet weak var btnSend: AppBlueButton!
    @IBOutlet weak var btnScanCode: UIButton!
    @IBOutlet weak var tfEnterCode: SkyFloatingLabelTextField!
    @IBOutlet weak var lblOr: UILabel!
    
    var pointOrigin: CGPoint?
    var hasSetPointOrigin = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetUp()
        setupViews()
    }
    
    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
        }
    }
}

//MARK:- INITIAL SET UP
extension SendToWalletVC{
    func initialSetUp(){
        CommmonUI.initialLbl(lbl: lblWalletAddress, text: L10n.Wallet_Address.description, textColor: .primaryTextColor, font: .MontserratRegular(Size.XXXLarge.sizeValue()))
        vwCoin.layer.cornerRadius = vwCoin.bounds.height / 2
        vwCoin.backgroundColor = .WalkthroughBgColor.withAlphaComponent(0.64)
        vwTopLine.layer.cornerRadius = vwTopLine.bounds.height / 2
        CommmonUI.initialLbl(lbl: lblCoinNmae, text: "Ethereum", textColor: .primaryTextColor, font: .MontserratBold(Size.Large.sizeValue()))
        CommmonUI.unBorderdBtn(btn: btnScanCode, title: L10n.SCAN_QR_Code.description, titlecolor: .themeColor, font: .MontserratMedium(Size.Large.sizeValue()))
        CommmonUI.initialLbl(lbl: lblOr, text: L10n.or.description, textColor: .DescTextColor, font: .MontserratMedium(Size.Medium.sizeValue()))
        CommmonUI.normalTF(tf: tfEnterCode, img: nil, placeHolder: L10n.Enter_wallet_address.description)
        
        btnSend.setTitle(L10n.Send.description, for: .normal)
        
        btnSend.addTarget(self, action: #selector(btnSendTapped), for: .touchUpInside)
        btnScanCode.addTarget(self, action: #selector(btnScanCodeTapped), for: .touchUpInside)
    }
}

// MARK:- SET UP PAN GESTURE
extension SendToWalletVC{
    func setupViews() {
        // 2.
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        self.view.addGestureRecognizer(panGesture)
    }
    
    // 3.
    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        // Not allowing the user to drag the view upward
        guard translation.y >= 0 else { return }
        
        // setting x as 0 because we don't want users to move the frame side ways!! Only want straight up or down
        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
        
        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: view)
            if dragVelocity.y >= 1300 {
                // Velocity fast enough to dismiss the uiview
                self.dismiss(animated: true, completion: nil)
            } else {
                // Set back to original position of the view controller
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
        }
    }
    
//    func showQrCode(){
//        //        let showAlert = UIAlertController(title: L10n.SCAN_QR_Code.description, message: nil, preferredStyle: .alert)
//        //        let imageView = UIImageView(frame: CGRect(x: 10, y: 50, width: 250, height: 230))
//        //        imageView.image = CommonFunctions.generateQRCode(from: btnCopy.titleLabel?.text ?? "")?.imageWithInsets(insets: UIEdgeInsets(top: 0, left: 0, bottom: 60, right: 0))
//        //        showAlert.view.addSubview(imageView)
//        //        let height = NSLayoutConstraint(item: showAlert.view!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 320)
//        //        let width = NSLayoutConstraint(item: showAlert.view!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 250)
//        //        showAlert.view.addConstraint(height)
//        //        showAlert.view.addConstraint(width)
//        //        showAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
//        //            // your actions here...
//        //        }))
//        //        self.present(showAlert, animated: true, completion: nil)
//        let alert = UIAlertController(title: L10n.SCAN_QR_Code.description, message: "", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: L10n.DONE.description, style: .default, handler: nil))
//        let image = UIImageView(image: CommonFunctions.generateQRCode(from: ""))
//        alert.view.addSubview(image)
//        image.translatesAutoresizingMaskIntoConstraints = false
//        alert.view.addConstraint(NSLayoutConstraint(item: image, attribute: .top, relatedBy: .equal, toItem: alert.view, attribute: .top, multiplier: 1, constant: 52))
//        alert.view.addConstraint(NSLayoutConstraint(item: image, attribute: .bottom, relatedBy: .equal, toItem: alert.view, attribute: .bottom, multiplier: 1, constant: -60))
//        alert.view.addConstraint(NSLayoutConstraint(item: image, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 240.0))
//        alert.view.addConstraint(NSLayoutConstraint(item: image, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 240.0))
//        alert.view.addConstraint(NSLayoutConstraint(item: image, attribute: .centerX, relatedBy: .equal, toItem: alert.view, attribute: .centerX, multiplier: 1, constant: 0))
//        self.present(alert, animated: true, completion: nil)
//    }
}

// MARK:- TEXT FIELD DELEGATE
extension SendToWalletVC: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentString: NSString = textField.text! as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        var maxLength = 120
        
        switch textField {
        case tfEnterCode:
            CommmonUI.normalTF(tf: tfEnterCode, img: nil, placeHolder: L10n.Wallet_Address.description)
            maxLength = 16
        default:
            break
        }
        
        if let char = string.cString(using: String.Encoding.utf8) {                         //TO ENABLE BCKSPACE EVEN IF NUMBERS ARE MORE THAN fixed CHAR LIMIT
            let isBackSpace = strcmp(char, "\\b")
            if (isBackSpace == -92) {
                return true
            }
        }
        
        return newString.length <= maxLength
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
}

// MARK:- BUTTON ACTIONS
extension SendToWalletVC{
    
    @objc func btnScanCodeTapped(sender: UIButton){
        let vc = ScannerViewController.instantiateFromAppStoryboard(appStoryboard: .Send)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
        vc.sendScannedText = { (txt) in
            self.tfEnterCode.text = txt
        }
    }
    
    @objc func btnSendTapped(sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
}



