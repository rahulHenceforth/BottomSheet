//
//  ChangePassVM.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 15/09/21.
//

import Foundation

//class ChangePassVM {
//
//    var controller: ChangePassVC?
//
//    // Initialization
//    init(controller: ChangePassVC) {
//        self.controller = controller
//    }
//}
//
//extension ChangePassVM{
//    func chckValidation(){
//        guard let controller = controller else {return}
//
//        if controller.tfCurrentPass.text == ""{
//            CommmonUI.errorTFBtn(tf: controller.tfCurrentPass, btn: controller.btneye, placeHolder: L10n.Current_password.description)
//            CommonFunctions.toster(k.ErrorMsgs.PleaseEnterCurrentPass)
//        }else if controller.tfNewPass.text == ""{
//            CommmonUI.errorTFBtn(tf: controller.tfNewPass, btn: controller.btneye1, placeHolder: L10n.New_password.description)
//            CommonFunctions.toster(k.ErrorMsgs.PleaseEnterNewPassword)
//        }else if !(controller.tfNewPass.text?.isValidPassword() ?? false){
//            CommmonUI.errorTFBtn(tf: controller.tfNewPass, btn: controller.btneye1, placeHolder: L10n.New_password.description)
//            CommonFunctions.toster(k.ErrorMsgs.PleaseEnterValidNewPassword)
//        }else{
//            let vc = PassCodeverificationVC.instantiateFromAppStoryboard(appStoryboard: .Main)
//            vc.isFromProfile = true
//            self.controller?.navigationController?.pushViewController(vc, animated: true)
//        }
//    }
//}

class ChangePassVM {
 
    // MARK:- VALIDATIONS
    func validate(with request: ChangePassRequest) -> ValidationResult<ChangePassErrorType>{
        
        if request.oldPass.trimmed.isEmpty
        {
            return ValidationResult(success: false, errorMsg: k.ErrorMsgs.PleaseEnterCurrentPass, errorOnField: .oldPass)
        }
        else if request.newPass.trimmed.isEmpty
        {
            return ValidationResult(success: false, errorMsg: k.ErrorMsgs.PleaseEnterNewPassword, errorOnField: .newPass)
        }
        else if !request.newPass.isValidPassword()
        {
            return ValidationResult(success: false, errorMsg: k.ErrorMsgs.PleaseEnterValidNewPassword, errorOnField: .newPass)
        }
        
        return ValidationResult(success: true, errorMsg: nil)
    }

}
