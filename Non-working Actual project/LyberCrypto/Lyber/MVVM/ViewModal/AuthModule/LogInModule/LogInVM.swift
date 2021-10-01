//
//  LogInVM.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 15/09/21.
//

import Foundation


//class LogInVM {
//    //    static let sharedInstance = LogInVM()
//
//    var controller: LogInVC?
//
//    // Initialization
//    init(controller: LogInVC) {
//        self.controller = controller
//    }
//}
//
//extension LogInVM{
//
//    func chckValidation(){
//        guard let controller = controller else {return}
//
//        if controller.tfEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
//            CommmonUI.errorTF(tf: controller.tfEmail, img: nil, placeHolder: L10n.Email_address.description)
//            CommonFunctions.toster(k.ErrorMsgs.PleaseEnterEmail)
//        }else if controller.tfPass.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
//            CommmonUI.errorTFBtn(tf: controller.tfPass, btn: controller.btneye, placeHolder: L10n.Password.description)
//            CommonFunctions.toster(k.ErrorMsgs.PleaseEnterPassword)
//        }else{
//            let vc = PassCodeverificationVC.instantiateFromAppStoryboard(appStoryboard: .Main)
//            self.controller?.navigationController?.pushViewController(vc, animated: true)
//        }
//    }
//}

class LogInVM {
    
    func Validate(with request: LoginRequest) -> ValidationResult<LogInErrorType> {
        if request.email?.trimmed.isEmpty ?? false{
            return ValidationResult(success: false, errorMsg: k.ErrorMsgs.PleaseEnterEmail, errorOnField: .email)
        }else if request.password?.trimmed.isEmpty ?? false{
            return ValidationResult(success: false, errorMsg: k.ErrorMsgs.PleaseEnterPassword, errorOnField: .password)
        }
        return ValidationResult(success: true, errorMsg: nil)
    }
    
}
