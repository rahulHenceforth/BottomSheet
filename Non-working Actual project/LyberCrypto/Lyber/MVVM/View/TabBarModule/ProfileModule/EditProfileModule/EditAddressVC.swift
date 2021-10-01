//
//  EditAddressVC.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 13/09/21.
//

import UIKit
import SkyFloatingLabelTextField
import FlagPhoneNumber

class EditAddressVC: UIViewController {
    
    //MARK:- IB OUTLETS
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var tfCountry: SkyFloatingLabelTextField!
    @IBOutlet weak var tfCity: SkyFloatingLabelTextField!
    @IBOutlet weak var tfZip: SkyFloatingLabelTextField!
    @IBOutlet weak var btnSave: AppBlueButton!
    @IBOutlet weak var vwMain: UIView!
    
    var tf = FPNTextField()
    var editAddressVM = EditAddressVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetUp()
    }
    
}

//MARK:- INITIAL SET UP
extension EditAddressVC{
    func initialSetUp(){
        CommmonUI.initialLbl(lbl: lblHeader, text: L10n.Update_Address.description, textColor: .primaryTextColor, font: .MontserratBold(Size.XXXLarge.sizeValue()))
        
        CommmonUI.normalTF(tf: tfCountry, img: nil, placeHolder: L10n.Citizenship.description)
        CommmonUI.normalTF(tf: tfCity, img: nil, placeHolder: L10n.City.description)
        CommmonUI.normalTF(tf: tfZip, img: nil, placeHolder: L10n.ZIP_Area_code.description)
        
        DispatchQueue.main.async {
            self.vwMain.roundCorners([.topLeft, .topRight], radius: 36)
        }
        
        self.btnSave.setTitle(L10n.SAVE_CHANGES.description, for: .normal)
        
        btnSave.addTarget(self, action: #selector(btnSaveTapped) , for: .touchUpInside)
        btnBack.addTarget(self, action: #selector(btnBackTapped) , for: .touchUpInside)
        
    }
}


//MARK: TEXTFLD DELEGATE
extension EditAddressVC: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case tfCity:
            tfZip.becomeFirstResponder()
        case tfZip:
            tfZip.resignFirstResponder()
        default:
            break
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentString: NSString = textField.text! as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        var maxLength = 120
        
        switch textField {
        case tfCity:
            maxLength = 15
            CommmonUI.normalTF(tf: tfCity, img: nil, placeHolder: L10n.City.description)
        case tfZip:
            maxLength = 6
            CommmonUI.normalTF(tf: tfZip, img: nil, placeHolder: L10n.ZIP_Area_code.description)
        case tfCountry:
            return false
        default:
            break
        }
        
        if let char = string.cString(using: String.Encoding.utf8) {                         //TO ENABLE BCKSPACE EVEN IF NUMBERS ARE MORE THAN fixed CHAR LIMIT
            let isBackSpace = strcmp(char, "\\b")
            if (isBackSpace == -92) {
                return true
            }
        }
        
        return newString.length <= maxLength
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == tfCountry{
            self.view.endEditing(true)
            fpnDisplayCountryList()
        }
    }
}

// MARK:- BUTTON ACTIONS
extension EditAddressVC{
    
    @objc func btnSaveTapped(sender: UIButton){
        let request = editAddressVM.validate(with: EditAddressRequest(citizenship: tfCountry.text, city: tfCity.text, zip: tfZip.text))
        
        if let error = request.errorMsg{
            CommonFunctions.toster(error)
            
            switch request.errorOnField {
            case .citizenship:
                CommmonUI.errorTF(tf: tfCountry, img: nil, placeHolder: L10n.Citizenship.description)
            case .city:
                CommmonUI.errorTF(tf: tfCity, img: nil, placeHolder: L10n.City.description)
            case .zip:
                CommmonUI.errorTF(tf: tfZip, img: nil, placeHolder: L10n.ZIP_Area_code.description)
            default:
                return
            }
            
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func btnBackTapped(sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:- open country code
    func fpnDisplayCountryList() {
        let listController: FPNCountryListViewController = FPNCountryListViewController(style: .grouped)
        listController.setup(repository: tf.countryRepository)
        listController.title = L10n.Countries.description
        
        let navigationViewController = UINavigationController(rootViewController: listController)
        self.present(navigationViewController, animated: true, completion: nil)
        listController.didSelect = {[weak self] country in
            self?.tfCountry.text = country.name
            CommmonUI.normalTF(tf: self?.tfCountry ?? SkyFloatingLabelTextField(), img: nil, placeHolder: L10n.Citizenship.description)
            //            self?.countryCode = country.phoneCode
            //            //            self?.lblCountryName.text = "\(country.name) (\(country.phoneCode))"
            //            self?.tfPhnNum.setFlag(countryCode: country.code)
            //            self?.btnCountryPicker.setTitle(self?.countryCode, for: .normal)
        }
    }
}


