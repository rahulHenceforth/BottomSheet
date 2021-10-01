//
//  LogInVC.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 01/09/21.
//

import UIKit
import SkyFloatingLabelTextField
import ActiveLabel
import IQKeyboardManagerSwift

class LogInVC: UIViewController {
    
    //MARK:- IB OUTLETS
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var tfEmail: SkyFloatingLabelTextField!
    @IBOutlet weak var tfPass: SkyFloatingLabelTextField!
    @IBOutlet weak var btnForgotPass: UIButton!
    @IBOutlet weak var btnLogIn: AppBlueButton!
    @IBOutlet weak var lblDontHaveAccnt: ActiveLabel!
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var vwMainTopCons: NSLayoutConstraint!
    @IBOutlet weak var scrlvw: UIScrollView!
    
    var btneye: UIButton!
//    lazy var logInVm = {
//        LogInVM(controller: self)
//    }()
    var logInVm = LogInVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        setViewModal()
        initialSetUp()
    }
}

//MARK:- INITIAL SET UP
extension LogInVC{
    func initialSetUp(){
        
        btneye = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        
        CommmonUI.initialLbl(lbl: lblHeader, text: L10n.Welcome_Back.description, textColor: .primaryTextColor, font: .MontserratBold(Size.XXXLarge.sizeValue()))
        CommmonUI.normalTF(tf: tfEmail, img: nil, placeHolder: L10n.Email_address.description)
        CommmonUI.normalTFBtn(tf: tfPass, btn: btneye, placeHolder: L10n.Password.description)
        CommmonUI.unBorderdBtn(btn: btnForgotPass, title: L10n.Forgot_your_password.description, titlecolor: .themeColor, font: .MontserratMedium(Size.Medium.sizeValue()))
        
        DispatchQueue.main.async {
            self.viewMain.roundCorners([.topLeft, .topRight], radius: 36)
        }
        
        self.btnLogIn.setTitle(L10n.LOGIN.description, for: .normal)
        
        btneye.addTarget(self, action: #selector(btnEyeTapped(_:)) , for: .touchUpInside)
        btnForgotPass.addTarget(self, action: #selector(btnForgotPassTapped(_:)) , for: .touchUpInside)
        btnLogIn.addTarget(self, action: #selector(btnLogInTapped(_:)) , for: .touchUpInside)
        tfEmail.addDoneOnKeyboardWithTarget(self, action:  #selector(doneButtonClicked))
        tfPass.addDoneOnKeyboardWithTarget(self, action: #selector(doneButtonClicked))
        
        CommmonUI.attributedLbl(lbl: self.lblDontHaveAccnt, txt: L10n.Dont_have_an_account.description, font: .MontserratMedium(Size.Medium.sizeValue()), clickAbleTxt: L10n.Sign_Up.description, clickAbleTxtFont: .MontserratBold(Size.Medium.sizeValue()), txtColor: .primaryTextColor, clickAbleTxtColor: .themeColor) {
            print("Custom Type Tapped")
            if let vc = self.navigationController?.hasViewController(ofKind: SignUpVC.self){
                self.navigationController?.popToViewController(vc, animated: true)
            }else{
                let vc = SignUpVC.instantiateFromAppStoryboard(appStoryboard: .Main)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
//    func setViewModal(){
//        self.logInVm = LogInVM(controller: self)
//    }
}

//MARK: TEXTFLD DELEGATE
extension LogInVC: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case tfEmail:
            tfPass.becomeFirstResponder()
        case tfPass:
            self.closeView()
        default:
            break
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentString: NSString = textField.text! as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        var maxLength = 120
        
        switch textField {
        case tfPass:
            maxLength = 18
            CommmonUI.normalTFBtn(tf: tfPass, btn: btneye, placeHolder: L10n.Password.description)
        case tfEmail:
            maxLength = 70
            CommmonUI.normalTF(tf: tfEmail, img: nil, placeHolder: L10n.Email_address.description)
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if self.vwMainTopCons.constant != 0{
            self.scrlvw.isScrollEnabled = false
            self.vwMainTopCons.constant = 0
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
}


// MARK:- BUTTON ACTIONS
extension LogInVC{
    
    @objc func btnForgotPassTapped(_ sender: UIButton){
        let vc = ForgotPassVC.instantiateFromAppStoryboard(appStoryboard: .Main)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func btnLogInTapped(_ sender: UIButton){
        let result = logInVm.Validate(with: LoginRequest(email: tfEmail.text, password: tfPass.text))
        
        if let error = result.errorMsg{
            CommonFunctions.toster(error)
            
            switch result.errorOnField {
            case .email:
                CommmonUI.errorTF(tf: tfEmail, img: nil, placeHolder: L10n.Email_address.description)
            case .password:
                CommmonUI.errorTFBtn(tf: tfPass, btn: btneye, placeHolder: L10n.Password.description)
            default:
                return
            }
        }else{
            let vc = PassCodeverificationVC.instantiateFromAppStoryboard(appStoryboard: .Main)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func btnEyeTapped(_ sender: UIButton){
        tfPass!.isSecureTextEntry = !tfPass!.isSecureTextEntry
        let img1 = Asset.visibility_off.image().imageWithInsets(insets: UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 20))?.withRenderingMode(.alwaysTemplate)
        let img2 = Asset.visibility.image().imageWithInsets(insets: UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 20))?.withRenderingMode(.alwaysTemplate)
        sender.setImage( tfPass!.isSecureTextEntry ? img1 : img2, for: .normal)
    }
    
    @objc func doneButtonClicked(_ sender: Any) {
        self.closeView()
    }
    
}


//MARK:- EXTERNAL FUNCTIONS
extension LogInVC{
    func closeView(){
        self.scrlvw.isScrollEnabled = true
        self.vwMainTopCons.constant = 217
        self.view.endEditing(true)
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }

    }
}
