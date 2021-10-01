//
//  EditProfileVM.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 15/09/21.
//

import Foundation

//class EditProfileVM {
//
//    var controller: EditProfileVC?
//
//    // Initialization
//    init(controller: EditProfileVC) {
//        self.controller = controller
//    }
//}
//
//// MARK:- CHECK VALIDATIONS
//extension EditProfileVM{
//    func chckValidation(){
//        guard let controller = controller else {return}
//
//        if controller.tfName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
//            CommmonUI.errorTF(tf: controller.tfName, img: nil, placeHolder: L10n.Full_Name.description)
//            CommonFunctions.toster(k.ErrorMsgs.PleaseEnterFullName)
//        }else if !(controller.tfName.text?.isValidName() ?? false){
//            CommmonUI.errorTF(tf: controller.tfName, img: nil, placeHolder: L10n.Full_Name.description)
//            CommonFunctions.toster(k.ErrorMsgs.PleaseEnterValidFullName)
//        }else{
//            self.controller?.navigationController?.popViewController(animated: true)
//        }
//    }
//}

class EditProfileVM {
    
    // MARK:- VALIDATIONS
    func validate(with request: EditProfileRequest) -> ValidationResult<EditProfileErrorType>{
        if request.name.trimmed.isEmpty
        {
            return ValidationResult(success: false, errorMsg: k.ErrorMsgs.PleaseEnterFullName, errorOnField: .name)
        }
        else if !request.name.isValidName()
        {
            return ValidationResult(success: false, errorMsg: k.ErrorMsgs.PleaseEnterValidFullName, errorOnField: .name)
        }
        else
        {
            return ValidationResult(success: true, errorMsg: nil)
        }
    }

}
