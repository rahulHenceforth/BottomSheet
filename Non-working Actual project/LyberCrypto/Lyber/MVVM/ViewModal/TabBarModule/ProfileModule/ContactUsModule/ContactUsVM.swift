//
//  ContactUsVM.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 15/09/21.
//

import Foundation

//class ContactUsVM {
//
//    var controller: ContactUS?
//
//    // Initialization
//    init(controller: ContactUS) {
//        self.controller = controller
//    }
//}
//
//extension ContactUsVM{
//    func chckValidation(){
//        guard let controller = controller else {return}
//
//        if controller.tfSubject.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
//            CommmonUI.errorTF(tf: controller.tfSubject, img: nil, placeHolder: L10n.Subject.description)
//            CommonFunctions.toster(k.ErrorMsgs.PleaseEnterSubject)
//        }else if controller.txtVw.text.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
//            controller.txtVw.tintColor = .red
//            controller.vwLineBelowTxt.backgroundColor = .red
//            controller.lblTxtVw.textColor = .red
//            controller.txtVw.shake()
//            controller.vwLineBelowTxt.shake()
//            controller.lblTxtVw.shake()
//            controller.isError = true
//            CommonFunctions.toster(k.ErrorMsgs.PleaseEnterMessage)
//        }else{
//            self.controller?.navigationController?.popViewController(animated: true)
//        }
//    }
//}

class ContactUsVM {
 
    // MARK:- VALIDATIONS
    func validate(with request: ContactUsRequest) -> ValidationResult<ContactUsErrorType>{
        
        if request.subject.trimmed.isEmpty
        {
            return ValidationResult(success: false, errorMsg: k.ErrorMsgs.PleaseEnterSubject, errorOnField: .subject)
        }
        else if request.msg.trimmed.isEmpty
        {
            return ValidationResult(success: false, errorMsg: k.ErrorMsgs.PleaseEnterMessage, errorOnField: .msg)
        }
        
        return ValidationResult(success: true, errorMsg: nil)
    }

}
