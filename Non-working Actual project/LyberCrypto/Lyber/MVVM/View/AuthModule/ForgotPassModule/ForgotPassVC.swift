//
//  ForgotPassVC.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 01/09/21.
//

import UIKit
import SkyFloatingLabelTextField

class ForgotPassVC: UIViewController {
    
    //MARK:- IB OUTLETS
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var lblHeaderDesc: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var vwMain: UIView!
    @IBOutlet weak var tfEmail: SkyFloatingLabelTextField!
    @IBOutlet weak var btnResetPass: AppBlueButton!
    
    var forgotPassVM = ForgotPassVM()

    override func viewDidLoad() {
        super.viewDidLoad()

        initialSetUp()
    }
}

//MARK:- INITIAL SET UP
extension ForgotPassVC{
    func initialSetUp(){
        
        CommmonUI.initialLbl(lbl: lblHeader, text: L10n.Forgot_Password.description, textColor: .primaryTextColor, font: .MontserratBold(Size.XXXLarge.sizeValue()))
        CommmonUI.initialLbl(lbl: lblHeaderDesc, text: L10n.Forgot_Password_Desc.description, textColor: .DescTextColor, font: .MontserratMedium(Size.Medium.sizeValue()))
        CommmonUI.normalTF(tf: tfEmail, img: nil, placeHolder: L10n.Email_address.description)
        
        DispatchQueue.main.async {
            self.vwMain.roundCorners([.topLeft, .topRight], radius: 36)
        }
        
        self.btnResetPass.setTitle(L10n.Reset_Password.description, for: .normal)
        
        btnResetPass.addTarget(self, action: #selector(btnResetPassTapped) , for: .touchUpInside)
        btnBack.addTarget(self, action: #selector(btnBackTapped) , for: .touchUpInside)
        
    }
}

//MARK: TEXTFLD DELEGATE
extension ForgotPassVC: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case tfEmail:
            tfEmail.resignFirstResponder()
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
}


// MARK:- BUTTON ACTIONS
extension ForgotPassVC{
    
    @objc func btnResetPassTapped(_ sender: UIButton){
        let result = forgotPassVM.Validate(with: LoginRequest(email: tfEmail.text))
        
        if let error = result.errorMsg{
            CommonFunctions.toster(error)
            CommmonUI.errorTF(tf: tfEmail, img: nil, placeHolder: L10n.Email_address.description)
        }else{
            self.tfEmail.text?.removeAll()
            self.view.endEditing(true)
            let vc = CheckYourEmailVC.instantiateFromAppStoryboard(appStoryboard: .Main)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func btnBackTapped(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}
