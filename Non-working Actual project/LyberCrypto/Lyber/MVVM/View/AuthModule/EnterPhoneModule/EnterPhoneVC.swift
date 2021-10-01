//
//  EnterPhoneVC.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 01/09/21.
//

import UIKit
import FlagPhoneNumber
import SkyFloatingLabelTextField

class EnterPhoneVC: UIViewController {

    //MARK:- IB OUTLETS
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var lblHeaderVCV: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnSubmit: AppBlueButton!
    @IBOutlet weak var tfPhnNum: FPNTextField!
    @IBOutlet weak var viewTf: UIView!
    @IBOutlet weak var btnCountryPicker: UIButton!
    @IBOutlet weak var lblMobileNum: UILabel!
    @IBOutlet weak var vwMobileNum: UIView!
    @IBOutlet weak var vwSmallLine: UIView!
    @IBOutlet weak var vwCurrentPhnNum: UIView!
    @IBOutlet weak var tfCurrentPhn: SkyFloatingLabelTextField!
    
    //MARK: - VARIABLES
    var countryCode = "+91"
    var countryName = "United States"
    var phone = ""
    var isValid = false
    var isError = false
    var isFromEditProfile = false
    var imgVw = UIImageView()
    
    var enterPhoneVM = EnterPhoneVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialSetUp()
    }
}


//MARK:- INITIAL SET UP
extension EnterPhoneVC{
    func initialSetUp(){
        
//        enterPhoneVM.controller = self
        
        self.btnSubmit.setTitle(L10n.SUBMIT_CAPS.description, for: .normal)
        CommmonUI.initialLbl(lbl: lblMobileNum, text: L10n.Phone_no.description, textColor: .secondaryTextColor, font: .MontserratMedium(Size.Medium.sizeValue()))
        CommmonUI.initialLbl(lbl: lblHeader, text: isFromEditProfile ? L10n.Phone_Number.description : L10n.Enter_Phone_No.description, textColor: .primaryTextColor, font: .MontserratBold(Size.XXXLarge.sizeValue()))
        CommmonUI.initialLbl(lbl: lblHeaderVCV, text: isFromEditProfile ? L10n.Profile_phone_desc.description : L10n.Enter_Phone_Desc.description, textColor: .DescTextColor, font: .MontserratMedium(Size.Medium.sizeValue()))
        CommmonUI.normalTF(tf: tfCurrentPhn, img: nil, placeHolder: L10n.Current_Phone_Number.description)
        
        tfCurrentPhn.text = "+380 97 135 9884"
        imgVw.image = Asset.tick.image()
        tfCurrentPhn.rightView = imgVw
        tfCurrentPhn.rightViewMode = .always
        
        self.viewTf.addBorders(edges: .bottom, color: .secondaryTextColor.withAlphaComponent(0.24))
        self.viewTf.layer.cornerRadius = 4
        
        tfPhnNum.textColor = UIColor.primaryTextColor
        tfPhnNum.clipsToBounds = true
        tfPhnNum.tintColor = UIColor.primaryTextColor
        tfPhnNum.attributedPlaceholder = NSAttributedString(string: L10n.Mobile_no.description,attributes: [NSAttributedString.Key.foregroundColor: UIColor.secondaryTextColor])
        tfPhnNum.font = UIFont.MontserratRegular(Size.XLarge.sizeValue())
        tfPhnNum.delegate = self
        tfPhnNum.leftViewMode = .never
        
        self.btnCountryPicker.setTitle(countryCode, for: .normal)
        self.btnCountryPicker.tintColor = .primaryTextColor
        btnCountryPicker.titleLabel?.font = .MontserratMedium(Size.Large.sizeValue())
        btnCountryPicker.setTitleColor(.primaryTextColor, for: .normal)
        
        vwCurrentPhnNum.isHidden = isFromEditProfile ? false : true
        
        self.btnSubmit.addTarget(self, action: #selector(btnSubmitTapped), for: .touchUpInside)
        self.btnCountryPicker.addTarget(self, action: #selector(btnCountryPickerTapped), for: .touchUpInside)
        self.btnBack.addTarget(self, action: #selector(btnBackTapped), for: .touchUpInside)
        
        DispatchQueue.main.async {
            self.viewMain.roundCorners([.topLeft, .topRight], radius: 30)
        }

        btnBack.isHidden = isFromEditProfile ? false : true
        
    }
}

//MARK:- Delegate method of country code flag
extension EnterPhoneVC: FPNTextFieldDelegate{
    
    //MARK:- open country code
    func fpnDisplayCountryList() {
        let listController: FPNCountryListViewController = FPNCountryListViewController(style: .grouped)
        listController.setup(repository: tfPhnNum.countryRepository)
        listController.title = "Countries"
        
        let navigationViewController = UINavigationController(rootViewController: listController)
        self.present(navigationViewController, animated: true, completion: nil)
        listController.didSelect = {[weak self] country in
            self?.countryName = country.name
            self?.countryCode = country.phoneCode
            //            self?.lblCountryName.text = "\(country.name) (\(country.phoneCode))"
            self?.tfPhnNum.setFlag(countryCode: country.code)
            self?.btnCountryPicker.setTitle(self?.countryCode, for: .normal)
        }
    }
    
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
        print(name, dialCode, code) // Output "France", "+33", "FR"
        countryCode = dialCode
    }
    
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
        if isValid {
            // Do something...
            //                textField.getFormattedPhoneNumber(format: .E164),           // Output "+33600000001"
            //                textField.getFormattedPhoneNumber(format: .International),  // Output "+33 6 00 00 00 01"
            //                textField.getFormattedPhoneNumber(format: .National),       // Output "06 00 00 00 01"
            //                textField.getFormattedPhoneNumber(format: .RFC3966),        // Output "tel:+33-6-00-00-00-01"
            self.phone = textField.getRawPhoneNumber() ?? ""                               // Output "600000001"
        }
        self.isValid = isValid
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentString: NSString = textField.text! as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        var maxLength = 120
        
        switch textField {
        case tfPhnNum:
            enterPhoneVM.removeError(from: tfPhnNum, viewTf: viewTf, btnCountryPicker: btnCountryPicker, vwSmallLine: vwSmallLine, lblMobileNum: lblMobileNum, vwMobileNum: vwMobileNum)
            maxLength = 16
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
        textField.tintColor = isError ? .red : .primaryTextColor
    }
}

//MARK: - BtnActions
extension EnterPhoneVC{
    
    @objc func btnCountryPickerTapped(sender: UIButton){
        fpnDisplayCountryList()
    }
    
    @objc func btnSubmitTapped(sender: UIButton){
        let result = enterPhoneVM.Validate(with: EnterPhoneRequest(phoneNum: self.tfPhnNum.text ?? "", isValid: self.isValid))
        
        if let error = result.errorMsg{
            isError = true
            CommonFunctions.toster(error)
            self.enterPhoneVM.showError(on: tfPhnNum, viewTf: viewTf, btnCountryPicker: btnCountryPicker, vwSmallLine: vwSmallLine, lblMobileNum: lblMobileNum, vwMobileNum: vwMobileNum)
        }else{
            isError = false
            let vc = VerifyNumberVC.instantiateFromAppStoryboard(appStoryboard: .Main)
            vc.isFromEditProfile = self.isFromEditProfile
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func btnBackTapped(sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}
