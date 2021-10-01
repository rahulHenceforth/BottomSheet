//
//  PersonalInfoVM.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 15/09/21.
//

import Foundation

//class PersonalInfoVM {
//
//    var controller: PersonalInfoVC?
//
//    // Initialization
//    init(controller: PersonalInfoVC) {
//        self.controller = controller
//    }
//}
//
//extension PersonalInfoVM{
//    func chckValidation(){
//        guard let controller = controller else {return}
//
//        if controller.tfFullName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
//            CommmonUI.errorTF(tf: controller.tfFullName, img: nil, placeHolder: L10n.Full_Name.description)
//            CommonFunctions.toster(k.ErrorMsgs.PleaseEnterFullName)
//        }else if !(controller.tfFullName.text?.isValidName() ?? false){
//            CommmonUI.errorTF(tf: controller.tfFullName, img: nil, placeHolder: L10n.Full_Name.description)
//            CommonFunctions.toster(k.ErrorMsgs.PleaseEnterValidName)
//        }else if controller.tfCitizenShip.text == ""{
//            CommmonUI.errorTF(tf: controller.tfCitizenShip, img: nil, placeHolder: L10n.Citizenship.description)
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
//        }else if controller.tfDOB.text == ""{
//            CommmonUI.errorTF(tf: controller.tfDOB, img: nil, placeHolder: L10n.Date_of_Birth.description, rytImage: Asset.calender.image())
//            CommonFunctions.toster(k.ErrorMsgs.PleaseeSelectDOB)
//        }else{
//            let vc = InvestmentExperienceVC.instantiateFromAppStoryboard(appStoryboard: .Kyc)
//            self.controller?.navigationController?.pushViewController(vc, animated: true)
//        }
//    }
//}

class PersonalInfoVM {
 
    // MARK:- Validations
    func validate(with request: PersonalInfoRequest) -> ValidationResult<PersonalInfoErrorType>{
        if request.fullName.trimmed.isEmpty
        {
            return ValidationResult(success: false, errorMsg: k.ErrorMsgs.PleaseEnterFullName, errorOnField: .fullName)
        }
        else if !request.fullName.isValidName()
        {
            return ValidationResult(success: false, errorMsg: k.ErrorMsgs.PleaseEnterValidName, errorOnField: .fullName)
        }
        else if request.citizenship.isEmpty
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
        else if request.zipCode.isEmpty
        {
            return ValidationResult(success: false, errorMsg: k.ErrorMsgs.PleaseEnterZip, errorOnField: .zipCode)
        }
        else if request.zipCode.count < 6
        {
            return ValidationResult(success: false, errorMsg: k.ErrorMsgs.PleaseEnterValidZip, errorOnField: .zipCode)
        }
        else if request.dob.isEmpty
        {
            return ValidationResult(success: false, errorMsg: k.ErrorMsgs.PleaseeSelectDOB, errorOnField: .dob)
        }
        
        return ValidationResult(success: true, errorMsg: nil)
    }
}
