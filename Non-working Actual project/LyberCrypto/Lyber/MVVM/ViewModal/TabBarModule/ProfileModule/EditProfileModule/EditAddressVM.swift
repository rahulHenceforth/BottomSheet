//
//  EditAddressVM.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 15/09/21.
//

import Foundation

//class EditAddressVM {
//
//    var controller: EditAddressVC?
//
//    // Initialization
//    init(controller: EditAddressVC) {
//        self.controller = controller
//    }
//}
//
//extension EditAddressVM{
//    func chckValidation(){
//        guard let controller = controller else {return}
//
//        if controller.tfCountry.text == ""{
//            CommmonUI.errorTF(tf: controller.tfCountry, img: nil, placeHolder: L10n.Citizenship.description)
//            CommonFunctions.toster(k.ErrorMsgs.PleaseSelectCitizenship)
//        }else if controller.tfCity.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
//            CommmonUI.errorTF(tf: controller.tfCity, img: nil, placeHolder: L10n.City.description)
//            CommonFunctions.toster(k.ErrorMsgs.PleaseEnterCity)
//        }else if !(controller.tfCity.text?.isValidName() ?? false){
//            CommmonUI.errorTF(tf: controller.tfCity, img: nil, placeHolder: L10n.City.description)
//            CommonFunctions.toster(k.ErrorMsgs.PleaseEnterValidCity)
//        }else if controller.tfZip.text == ""{
//            CommmonUI.errorTF(tf: controller.tfZip, img: nil, placeHolder: L10n.ZIP_Area_code.description)
//            CommonFunctions.toster(k.ErrorMsgs.PleaseEnterZip)
//        }else if controller.tfZip.text?.count ?? 0 < 6{
//            CommmonUI.errorTF(tf: controller.tfZip, img: nil, placeHolder: L10n.ZIP_Area_code.description)
//            CommonFunctions.toster(k.ErrorMsgs.PleaseEnterValidZip)
//        }else{
//            self.controller?.navigationController?.popViewController(animated: true)
//        }
//    }
//}

class EditAddressVM {
    
    // MARK:- VALIDATIONS
    func validate(with request: EditAddressRequest) -> ValidationResult<EditAddressErrorType>{
        
        if request.citizenship.isEmpty
        {
           return ValidationResult(success: false, errorMsg: k.ErrorMsgs.PleaseSelectCitizenship, errorOnField: .citizenship)
        }
        else if request.city.trimmed.isEmpty
        {
            return ValidationResult(success: false, errorMsg: k.ErrorMsgs.PleaseEnterCity, errorOnField: .city)
        }
        else if !request.city.trimmed.isValidName()
        {
            return ValidationResult(success: false, errorMsg: k.ErrorMsgs.PleaseEnterValidCity, errorOnField: .city)
        }
        else if request.zip.isEmpty
        {
            return ValidationResult(success: false, errorMsg: k.ErrorMsgs.PleaseEnterZip, errorOnField: .zip)
        }
        else if request.zip.count < 6
        {
            return ValidationResult(success: false, errorMsg: k.ErrorMsgs.PleaseEnterValidZip, errorOnField: .zip)
        }
        return ValidationResult(success: true, errorMsg: nil)
    }
    
}
