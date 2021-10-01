//
//  ForgotPassVM.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 15/09/21.
//

import Foundation

//class ForgotPassVM {
//    
//    var controller: ForgotPassVC?
//    
//    // Initialization
//    init(controller: ForgotPassVC) {
//        self.controller = controller
//    }
//}
//
//extension ForgotPassVM{
//    
//    func chckValidation(){
//        guard let controller = controller else {return}
//        
//        if controller.tfEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
//            CommmonUI.errorTF(tf: controller.tfEmail, img: nil, placeHolder: L10n.Email_address.description)
//            CommonFunctions.toster(k.ErrorMsgs.PleaseEnterEmail)
//        }else if !(controller.tfEmail.text?.isValidEmailId() ?? false){
//            CommmonUI.errorTF(tf: controller.tfEmail, img: nil, placeHolder: L10n.Email_address.description)
//            CommonFunctions.toster(k.ErrorMsgs.PleaseEnterValidEmail)
//        }else{
//            let vc = CheckYourEmailVC.instantiateFromAppStoryboard(appStoryboard: .Main)
//            self.controller?.navigationController?.pushViewController(vc, animated: true)
//            controller.tfEmail.text?.removeAll()
//            self.controller?.view.endEditing(true)
//        }
//    }
//}

class ForgotPassVM {
    
    func Validate(with request: LoginRequest) -> ValidationResult<LogInErrorType> {
        if request.email?.trimmed.isEmpty ?? false{
            return ValidationResult(success: false, errorMsg: k.ErrorMsgs.PleaseEnterEmail, errorOnField: .email)
        }else if !(request.email?.isValidEmailId() ?? false){
            return ValidationResult(success: false, errorMsg: k.ErrorMsgs.PleaseEnterValidEmail, errorOnField: .email)
        }
        return ValidationResult(success: true, errorMsg: nil)
    }
    
}
