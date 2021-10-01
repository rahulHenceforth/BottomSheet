//
//  AddBankVM.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 15/09/21.
//

import Foundation

//class AddBankVM {
//
//    var controller: AddBankVC?
//
//    // Initialization
//    init(controller: AddBankVC) {
//        self.controller = controller
//    }
//}
//
//extension AddBankVM{
//    func chckValidation(){
//        guard let controller = controller else {return}
//
//        if controller.tfName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
//            CommmonUI.errorTF(tf: controller.tfName, img: nil, placeHolder: L10n.Name_On_Card.description)
//            CommonFunctions.toster(k.ErrorMsgs.PleaseEnterName)
//        }else if controller.tfCardNumber.text == ""{
//            CommmonUI.errorTF(tf: controller.tfCardNumber, img: nil, placeHolder: L10n.Card_Number.description)
//            CommonFunctions.toster(k.ErrorMsgs.PleaseEnterCardNumber)
//        }else if controller.tfCardNumber.text?.count ?? 0 < 16{
//            CommmonUI.errorTF(tf: controller.tfCardNumber, img: nil, placeHolder: L10n.Card_Number.description)
//            CommonFunctions.toster(k.ErrorMsgs.PleaseEnterValidCardNumber)
//        }else if controller.tfExpiry.text == ""{
//            CommmonUI.errorTF(tf: controller.tfExpiry, img: nil, placeHolder: L10n.Expiry.description)
//            CommonFunctions.toster(k.ErrorMsgs.PleaseEnterExpiryDate)
//        }else if controller.tfExpiry.text?.count ?? 0 < 5{
//            CommmonUI.errorTF(tf: controller.tfExpiry, img: nil, placeHolder: L10n.Expiry.description)
//            CommonFunctions.toster(k.ErrorMsgs.PleaseEnterValidExpiryDate)
//        }else if controller.tfCvv.text == ""{
//            CommmonUI.errorTF(tf: controller.tfCvv, img: nil, placeHolder: L10n.CVV.description)
//            CommonFunctions.toster(k.ErrorMsgs.PleaseEnterCVV)
//        }else if controller.tfCvv.text?.count ?? 0 < 3{
//            CommmonUI.errorTF(tf: controller.tfCvv, img: nil, placeHolder: L10n.CVV.description)
//            CommonFunctions.toster(k.ErrorMsgs.PleaseEnterValidCVV)
//        }else{
////            if controller.isFromEditProfile{
//                self.controller?.navigationController?.popViewController(animated: true)
////            }else{
////                let vc = ProfileVerificationVC.instantiateFromAppStoryboard(appStoryboard: .Main)
////                vc.screenType = .Welcome
////                self.controller?.navigationController?.pushViewController(vc, animated: true)
////            }
//        }
//    }
//}


class AddBankVM {

    // MARK:- VALIDATIONS
    func Validate(with request: AddBankRequest) -> ValidationResult<AddBankErrorType> {
        if request.name.trimmed.isEmpty {
            return ValidationResult(success: false, errorMsg: k.ErrorMsgs.PleaseEnterName, errorOnField: .name)
        }else if request.cardNum.isEmpty {
            return ValidationResult(success: false, errorMsg: k.ErrorMsgs.PleaseEnterCardNumber, errorOnField: .cardNum)
        }else if request.cardNum.count < 16 {
            return ValidationResult(success: false, errorMsg: k.ErrorMsgs.PleaseEnterValidCardNumber, errorOnField: .cardNum)
        }else if request.expiry.isEmpty {
            return ValidationResult(success: false, errorMsg: k.ErrorMsgs.PleaseEnterExpiryDate, errorOnField: .expiry)
        }else if request.expiry.count < 5 {
            return ValidationResult(success: false, errorMsg: k.ErrorMsgs.PleaseEnterValidExpiryDate, errorOnField: .expiry)
        }else if request.cvv.isEmpty {
            return ValidationResult(success: false, errorMsg: k.ErrorMsgs.PleaseEnterCVV, errorOnField: .cvv)
        }else if request.cvv.count < 3 {
            return ValidationResult(success: false, errorMsg: k.ErrorMsgs.PleaseEnterValidCVV, errorOnField: .cvv)
        }
        return ValidationResult(success: true, errorMsg: nil)
    }
}
