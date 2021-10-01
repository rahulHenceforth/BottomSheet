//
//  LinkBankVM.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 16/09/21.
//

import Foundation


//class LinkBankVM {
//
//    var controller: LinkBankVC?
//
//    // Initialization
//    init(controller: LinkBankVC) {
//        self.controller = controller
//    }
//}
//
//extension LinkBankVM{
//    func chckValidation(){
//        guard let controller = controller else {return}
//
//        if controller.tfName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
//            CommmonUI.errorTF(tf: controller.tfName, img: nil, placeHolder: L10n.Full_Name.description)
//            CommonFunctions.toster(k.ErrorMsgs.PleaseEnterFullName)
//        }else if controller.tfAccountNum.text == ""{
//            CommmonUI.errorTF(tf: controller.tfAccountNum, img: nil, placeHolder: L10n.AccountNum.description)
//            CommonFunctions.toster(k.ErrorMsgs.PleaseEnterAccountNum)
//        }else if controller.tfRoutingNum.text == ""{
//            CommmonUI.errorTF(tf: controller.tfRoutingNum, img: nil, placeHolder: L10n.RoutingNum.description)
//            CommonFunctions.toster(k.ErrorMsgs.PleaseEnterRoutingNum)
//        }else if controller.tfAddress.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
//            CommmonUI.errorTF(tf: controller.tfAddress, img: nil, placeHolder: L10n.Address.description)
//            CommonFunctions.toster(k.ErrorMsgs.PleaseEnterAddress)
//        }else if controller.tfPostalCode.text == ""{
//            CommmonUI.errorTF(tf: controller.tfPostalCode, img: nil, placeHolder: L10n.PostalCode.description)
//            CommonFunctions.toster(k.ErrorMsgs.PleaseEnterPostalCode)
//        }else{
//            if controller.isFromEditProfile{
//                self.controller?.navigationController?.popViewController(animated: true)
//            }else{
//                let vc = ProfileVerificationVC.instantiateFromAppStoryboard(appStoryboard: .Main)
//                vc.screenType = .Welcome
//                self.controller?.navigationController?.pushViewController(vc, animated: true)
//            }
//        }
//    }
//}

// MARK:- VALIDATIONS
class LinkBankVM {
    
    func Validate(with request: LinkBankRequest) -> ValidationResult<LinkBankErrorType> {
        if request.name.trimmed.isEmpty {
            return ValidationResult(success: false, errorMsg: k.ErrorMsgs.PleaseEnterFullName, errorOnField: .name)
        }else if request.accountNum.isEmpty {
            return ValidationResult(success: false, errorMsg: k.ErrorMsgs.PleaseEnterAccountNum, errorOnField: .accountNum)
        }else if request.routingNum.isEmpty {
            return ValidationResult(success: false, errorMsg: k.ErrorMsgs.PleaseEnterRoutingNum, errorOnField: .routingNum)
        }else if request.address.trimmed.isEmpty {
            return ValidationResult(success: false, errorMsg: k.ErrorMsgs.PleaseEnterAddress, errorOnField: .address)
        }else if request.postalCode.isEmpty {
            return ValidationResult(success: false, errorMsg: k.ErrorMsgs.PleaseEnterPostalCode, errorOnField: .postalCode)
        }
        return ValidationResult(success: true, errorMsg: nil)
    }
}
