//
//  EnterPhoneVM.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 15/09/21.
//

import Foundation
import FlagPhoneNumber

//class EnterPhoneVM {
//
//    var controller: EnterPhoneVC?
//
//    // Initialization
//    init(controller: EnterPhoneVC) {
//        self.controller = controller
//    }
//}
//
//extension EnterPhoneVM{
//
//    func chckValidation(){
//        guard let controller = controller else {return}
//
//        if controller.tfPhnNum.text == ""{
//            self.showError()
//            CommonFunctions.toster(k.ErrorMsgs.PleaseEnterMobileNum)
//        }else if !controller.isValid{
//            self.showError()
//            CommonFunctions.toster(k.ErrorMsgs.PleaseEnterValidMobileNum)
//        }else{

//        }
//    }
//}
//


// MARK:- VALIDATIONS
class EnterPhoneVM {
    
    func Validate(with request: EnterPhoneRequest) -> ValidationResult<SignUpErrorType> {
        if request.phoneNum.isEmpty {
            return ValidationResult(success: false, errorMsg: k.ErrorMsgs.PleaseEnterMobileNum)
        }else if !request.isValid {
            return ValidationResult(success: false, errorMsg: k.ErrorMsgs.PleaseEnterValidMobileNum)
        }
        return ValidationResult(success: true, errorMsg: nil)
    }
}

// MARK:- UI ERROR FUNCTIONS
extension EnterPhoneVM{
    func showError(on tfPhnNum: FPNTextField, viewTf: UIView, btnCountryPicker: UIButton, vwSmallLine: UIView, lblMobileNum: UILabel, vwMobileNum: UIView){
        tfPhnNum.textColor = UIColor.red
        tfPhnNum.tintColor = UIColor.red
        tfPhnNum.attributedPlaceholder = NSAttributedString(string: L10n.Mobile_no.description,attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
        viewTf.layer.borderColor = UIColor.red.cgColor
        btnCountryPicker.setTitleColor(.red, for: .normal)
        vwSmallLine.backgroundColor = .red
        btnCountryPicker.tintColor = .red
        lblMobileNum.textColor = .red
        vwMobileNum.shake()
        tfPhnNum.shake()
        viewTf.shake()
        vwSmallLine.shake()
        btnCountryPicker.shake()
    }
    
    func removeError(from tfPhnNum: FPNTextField, viewTf: UIView, btnCountryPicker: UIButton, vwSmallLine: UIView, lblMobileNum: UILabel, vwMobileNum: UIView){
        tfPhnNum.textColor = UIColor.primaryTextColor
        tfPhnNum.tintColor = UIColor.primaryTextColor
        lblMobileNum.textColor = UIColor.primaryTextColor
        tfPhnNum.attributedPlaceholder = NSAttributedString(string: L10n.Mobile_no.description,attributes: [NSAttributedString.Key.foregroundColor: UIColor.secondaryTextColor])
        viewTf.layer.borderColor = UIColor.borderColor.cgColor
        btnCountryPicker.setTitleColor(.primaryTextColor, for: .normal)
        btnCountryPicker.tintColor = .primaryTextColor
        vwSmallLine.backgroundColor = UIColor(netHex: 0xD9E1E5FF)
    }
}
