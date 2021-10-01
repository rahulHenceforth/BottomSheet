//
//  PersonalInfoVC.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 07/09/21.
//

import UIKit
import SkyFloatingLabelTextField
import FlagPhoneNumber

class PersonalInfoVC: UIViewController {
    
    //MARK:- IB OUTLETS
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var tfFullName: SkyFloatingLabelTextField!
    @IBOutlet weak var tfCitizenShip: SkyFloatingLabelTextField!
    @IBOutlet weak var tfCity: SkyFloatingLabelTextField!
    @IBOutlet weak var tfZip: SkyFloatingLabelTextField!
    @IBOutlet weak var tfDOB: SkyFloatingLabelTextField!
    @IBOutlet weak var btnNxtStep: AppBlueButton!
    
    var tf = FPNTextField()
    var personalInfoVM = PersonalInfoVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetUp()
    }
}

//MARK:- INITIAL SET UP
extension PersonalInfoVC{
    func initialSetUp(){
        CommmonUI.initialLbl(lbl: lblHeader, text: L10n.Personal_Information.description, textColor: .primaryTextColor, font: .MontserratBold(Size.XXXLarge.sizeValue()))
        CommmonUI.normalTF(tf: tfFullName, img: nil, placeHolder: L10n.Full_Name.description)
        CommmonUI.normalTF(tf: tfCitizenShip, img: nil, placeHolder: L10n.Citizenship.description)
        CommmonUI.normalTF(tf: tfCity, img: nil, placeHolder: L10n.City.description)
        CommmonUI.normalTF(tf: tfZip, img: nil, placeHolder: L10n.ZIP_Area_code.description)
        CommmonUI.normalTF(tf: tfDOB, img: nil, placeHolder: L10n.Date_of_Birth.description, rytImage: Asset.calender.image())
        
//        imgVwTick.image = Asset.tick.image()
//        imgVwCalender.image = Asset.calender.image()
////        tfFullName.openView(false, img: imgVwTick)
//        tfDOB.openView(false, img: imgVwCalender)
        
        DispatchQueue.main.async {
            self.viewMain.roundCorners([.topLeft, .topRight], radius: 36)
        }
        
        btnNxtStep.setTitle(L10n.Next_Step.description, for: .normal)
        
        btnNxtStep.addTarget(self, action: #selector(btnNxtStepTapped), for: .touchUpInside)
        btnBack.addTarget(self, action: #selector(btnBackTapped), for: .touchUpInside)
    }
}

//MARK: TEXTFLD DELEGATE
extension PersonalInfoVC: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case tfFullName:
            self.view.endEditing(true)
            tfCitizenShip.becomeFirstResponder()
        case tfCitizenShip:
            tfCity.becomeFirstResponder()
        case tfCity:
            tfZip.becomeFirstResponder()
        case tfZip:
            tfDOB.becomeFirstResponder()
        case tfDOB:
            tfDOB.resignFirstResponder()
        default:
            break
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == tfDOB{
            self.view.endEditing(true)
            let popOverVC = DatePickerVC()
            self.addChild(popOverVC)
            popOverVC.view.frame = self.view.frame
            self.view.addSubview(popOverVC.view)
            popOverVC.didMove(toParent: self)
            popOverVC.sendValue = { (date) in
//                self.date = date
                textField.text = date
                CommmonUI.normalTF(tf: self.tfDOB, img: nil, placeHolder: L10n.Date_of_Birth.description)
            }
        }else if textField == tfCitizenShip{
            self.view.endEditing(true)
            fpnDisplayCountryList()
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentString: NSString = textField.text! as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        var maxLength = 120
        
        switch textField {
        case tfFullName:
            maxLength = 15
            CommmonUI.normalTF(tf: tfFullName, img: nil, placeHolder: L10n.Full_Name.description)
        case tfCitizenShip:
            maxLength = 15
            CommmonUI.normalTF(tf: tfCitizenShip, img: nil, placeHolder: L10n.Citizenship.description)
        case tfCity:
            maxLength = 18
            CommmonUI.normalTF(tf: tfCity, img: nil, placeHolder: L10n.City.description)
        case tfZip:
            maxLength = 6
            CommmonUI.normalTF(tf: tfZip, img: nil, placeHolder: L10n.ZIP_Area_code.description)
        case tfDOB:
            maxLength = 15
            CommmonUI.normalTF(tf: tfDOB, img: nil, placeHolder: L10n.Date_of_Birth.description)
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
}

// MARK:- BUTTON ACTIONS
extension PersonalInfoVC{
    
    @objc func btnNxtStepTapped(sender: UIButton){
        let request = personalInfoVM.validate(with: PersonalInfoRequest(fullName: tfFullName.text, citizenship: tfCitizenShip.text, city: tfCity.text, zipCode: tfZip.text, dob: tfDOB.text))
        
        if let error = request.errorMsg{
            CommonFunctions.toster(error)
            
            switch request.errorOnField {
            case .fullName:
                CommmonUI.errorTF(tf: tfFullName, img: nil, placeHolder: L10n.Full_Name.description)
            case .citizenship:
                CommmonUI.errorTF(tf: tfCitizenShip, img: nil, placeHolder: L10n.Citizenship.description)
            case .city:
                CommmonUI.errorTF(tf: tfCity, img: nil, placeHolder: L10n.City.description)
            case .zipCode:
                CommmonUI.errorTF(tf: tfZip, img: nil, placeHolder: L10n.ZIP_Area_code.description)
            case .dob:
                CommmonUI.errorTF(tf: tfDOB, img: nil, placeHolder: L10n.Date_of_Birth.description, rytImage: Asset.calender.image())
            default:
                return
            }
        }else{
            let vc = InvestmentExperienceVC.instantiateFromAppStoryboard(appStoryboard: .Kyc)
            self.navigationController?.pushViewController(vc, animated: true)
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
            self?.tfCitizenShip.text = country.name
            CommmonUI.normalTF(tf: self?.tfCitizenShip ?? SkyFloatingLabelTextField(), img: nil, placeHolder: L10n.Citizenship.description)
            //            self?.countryCode = country.phoneCode
            //            //            self?.lblCountryName.text = "\(country.name) (\(country.phoneCode))"
            //            self?.tfPhnNum.setFlag(countryCode: country.code)
            //            self?.btnCountryPicker.setTitle(self?.countryCode, for: .normal)
        }
    }
}


