//
//  SignUpVM.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 15/09/21.
//

import Foundation

//class SignUpVM {
//
//    var controller: SignUpVC?
//
//    // Initialization
//    init(controller: SignUpVC) {
//        self.controller = controller
//    }
//}
//
//extension SignUpVM{
//
//    func chckValidation(){
//        guard let controller = controller else {return}
//
//        if controller.tfFrstName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
//            CommmonUI.errorTF(tf: controller.tfFrstName, img: nil, placeHolder: L10n.First_Name.description)
//            CommonFunctions.toster(k.ErrorMsgs.PleaseEnterFirstName)
//        }else if !(controller.tfFrstName.text?.isValidName() ?? false){
//            CommmonUI.errorTF(tf: controller.tfFrstName, img: nil, placeHolder: L10n.First_Name.description)
//            CommonFunctions.toster(k.ErrorMsgs.PleaseEnterValidFirstName)
//        }else if controller.tfLastName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
//            CommmonUI.errorTF(tf: controller.tfLastName, img: nil, placeHolder: L10n.Last_Name.description)
//            CommonFunctions.toster(k.ErrorMsgs.PleaseEnterLastName)
//        }else if !(controller.tfLastName.text?.isValidName() ?? false){
//            CommmonUI.errorTF(tf: controller.tfLastName, img: nil, placeHolder: L10n.Last_Name.description)
//            CommonFunctions.toster(k.ErrorMsgs.PleaseEnterValidLastName)
//        }else if controller.tfEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
//            CommmonUI.errorTF(tf: controller.tfEmail, img: nil, placeHolder: L10n.Email_address.description)
//            CommonFunctions.toster(k.ErrorMsgs.PleaseEnterEmail)
//        }else if !(controller.tfEmail.text?.isValidEmailId() ?? false){
//            CommmonUI.errorTF(tf: controller.tfEmail, img: nil, placeHolder: L10n.Email_address.description)
//            CommonFunctions.toster(k.ErrorMsgs.PleaseEnterValidEmail)
//        }else if controller.tfPass.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
//            CommmonUI.errorTFBtn(tf: controller.tfPass, btn: controller.btneye, placeHolder: L10n.Password.description)
//            CommonFunctions.toster(k.ErrorMsgs.PleaseEnterPassword)
//        }else if !(controller.tfPass.text?.isValidPassword() ?? false){
//            CommmonUI.errorTFBtn(tf: controller.tfPass, btn: controller.btneye, placeHolder: L10n.Password.description)
//            CommonFunctions.toster(k.ErrorMsgs.PleaseEnterValidPassword)
//        }else{
//            let vc = CheckYourEmailVC.instantiateFromAppStoryboard(appStoryboard: .Main)
//            vc.isFromCreateAccountScreen = true
//            self.controller?.navigationController?.pushViewController(vc, animated: true)
//        }
//    }
//}

class SignUpVM {
    
    func Validate(with request: SignUpRequest) -> ValidationResult<SignUpErrorType> {
        if request.firstName?.trimmed.isEmpty ?? false{
            return ValidationResult(success: false, errorMsg: k.ErrorMsgs.PleaseEnterEmail, errorOnField: .firstName)
        }else if request.lastName?.trimmed.isEmpty ?? false{
            return ValidationResult(success: false, errorMsg: k.ErrorMsgs.PleaseEnterEmail, errorOnField: .lastName)
        }else if request.email?.trimmed.isEmpty ?? false{
            return ValidationResult(success: false, errorMsg: k.ErrorMsgs.PleaseEnterEmail, errorOnField: .email)
        }else if !(request.email?.isValidEmailId() ?? false){
            return ValidationResult(success: false, errorMsg: k.ErrorMsgs.PleaseEnterValidEmail, errorOnField: .email)
        }else if request.password?.trimmed.isEmpty ?? false{
            return ValidationResult(success: false, errorMsg: k.ErrorMsgs.PleaseEnterPassword, errorOnField: .password)
        }else if !(request.password?.isValidPassword() ?? false){
            return ValidationResult(success: false, errorMsg: k.ErrorMsgs.PleaseEnterValidPassword, errorOnField: .password)
        }
        return ValidationResult(success: true, errorMsg: nil)
    }
    
}
