//
//  SignUpVC.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 01/09/21.
//

import UIKit
import SkyFloatingLabelTextField
import ActiveLabel

class SignUpVC: UIViewController {

    //MARK:- IB OUTLETS
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var tfFrstName: SkyFloatingLabelTextField!
    @IBOutlet weak var tfLastName: SkyFloatingLabelTextField!
    @IBOutlet weak var tfEmail: SkyFloatingLabelTextField!
    @IBOutlet weak var tfPass: SkyFloatingLabelTextField!
    @IBOutlet weak var tfPromoCode: SkyFloatingLabelTextField!
    @IBOutlet weak var btnSignUp: AppBlueButton!
    @IBOutlet weak var lblAlreadyHaveAccnt: ActiveLabel!
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var vwMainTopCons: NSLayoutConstraint!
    @IBOutlet weak var scrlvw: UIScrollView!
    
    var btneye: UIButton!
    var signUpVM = SignUpVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialSetUp()
    }
}

//MARK:- INITIAL SET UP
extension SignUpVC{
    func initialSetUp(){
        
        btneye = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        
        CommmonUI.initialLbl(lbl: lblHeader, text: L10n.Create_Account.description, textColor: .primaryTextColor, font: .MontserratBold(Size.XXXLarge.sizeValue()))
        CommmonUI.normalTF(tf: tfFrstName, img: nil, placeHolder: L10n.First_Name.description)
        CommmonUI.normalTF(tf: tfLastName, img: nil, placeHolder: L10n.Last_Name.description)
        CommmonUI.normalTF(tf: tfEmail, img: nil, placeHolder: L10n.Email_address.description)
        CommmonUI.normalTFBtn(tf: tfPass, btn: btneye, placeHolder: L10n.Password.description)
        CommmonUI.normalTF(tf: tfPromoCode, img: nil, placeHolder: L10n.Promo_Code.description)
        
        DispatchQueue.main.async {
            self.viewMain.roundCorners([.topLeft, .topRight], radius: 36)
        }
        
        self.btnSignUp.setTitle(L10n.Lets_Get_Started.description, for: .normal)
        
        btneye.addTarget(self, action: #selector(btnEyeTapped(_:)) , for: .touchUpInside)
        btnSignUp.addTarget(self, action: #selector(btnSignUpTapped(_:)) , for: .touchUpInside)
        
        tfLastName.addDoneOnKeyboardWithTarget(self, action:  #selector(doneButtonClicked))
        tfFrstName.addDoneOnKeyboardWithTarget(self, action:  #selector(doneButtonClicked))
        tfEmail.addDoneOnKeyboardWithTarget(self, action:  #selector(doneButtonClicked))
        tfPass.addDoneOnKeyboardWithTarget(self, action: #selector(doneButtonClicked))
        
        CommmonUI.attributedLbl(lbl: self.lblAlreadyHaveAccnt, txt: L10n.Already_have_an_account.description, font: .MontserratMedium(Size.Medium.sizeValue()), clickAbleTxt: L10n.Login.description, clickAbleTxtFont: .MontserratBold(Size.Medium.sizeValue()), txtColor: .primaryTextColor, clickAbleTxtColor: .themeColor) {
            print("Custom Type Tapped")
            if let vc = self.navigationController?.hasViewController(ofKind: LogInVC.self){
                self.navigationController?.popToViewController(vc, animated: true)
            }else{
                let vc = LogInVC.instantiateFromAppStoryboard(appStoryboard: .Main)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}

//MARK: TEXTFLD DELEGATE
extension SignUpVC: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case tfFrstName:
            tfLastName.becomeFirstResponder()
        case tfLastName:
            tfEmail.becomeFirstResponder()
        case tfEmail:
            tfPass.becomeFirstResponder()
        case tfPass:
            tfPromoCode.becomeFirstResponder()
        case tfPromoCode:
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
        case tfFrstName:
            maxLength = 15
            CommmonUI.normalTF(tf: tfFrstName, img: nil, placeHolder: L10n.First_Name.description)
        case tfLastName:
            maxLength = 15
            CommmonUI.normalTF(tf: tfLastName, img: nil, placeHolder: L10n.Last_Name.description)
        case tfPass:
            maxLength = 18
            CommmonUI.normalTFBtn(tf: tfPass, btn: btneye, placeHolder: L10n.Password.description)
        case tfEmail:
            maxLength = 70
            CommmonUI.normalTF(tf: tfEmail, img: nil, placeHolder: L10n.Email_address.description)
        case tfPromoCode:
            maxLength = 15
            CommmonUI.normalTF(tf: tfPromoCode, img: nil, placeHolder: L10n.Promo_Code.description)
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
extension SignUpVC{
    
    @objc func btnSignUpTapped(_ sender: UIButton){
        let result = signUpVM.Validate(with: SignUpRequest(firstName: tfFrstName.text, lastName: tfLastName.text,email: tfEmail.text, password: tfPass.text))
        
        if let error = result.errorMsg{
            CommonFunctions.toster(error)
            
            switch result.errorOnField {
            case .firstName:
                CommmonUI.errorTF(tf: tfFrstName, img: nil, placeHolder: L10n.First_Name.description)
            case .lastName:
                CommmonUI.errorTF(tf: tfLastName, img: nil, placeHolder: L10n.Last_Name.description)
            case .email:
                CommmonUI.errorTF(tf: tfEmail, img: nil, placeHolder: L10n.Email_address.description)
            case .password:
                CommmonUI.errorTFBtn(tf: tfPass, btn: btneye, placeHolder: L10n.Password.description)
            default:
                return
            }
        }else{
            let vc = CheckYourEmailVC.instantiateFromAppStoryboard(appStoryboard: .Main)
            vc.isFromCreateAccountScreen = true
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
extension SignUpVC{
    func closeView(){
        self.scrlvw.isScrollEnabled = true
        self.vwMainTopCons.constant = 217
        self.view.endEditing(true)
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }

    }
}
