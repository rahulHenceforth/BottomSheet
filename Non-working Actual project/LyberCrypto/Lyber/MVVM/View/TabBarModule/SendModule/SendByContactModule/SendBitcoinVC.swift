//
//  SendBitcoinVC.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 10/09/21.
//

import UIKit
import FlagPhoneNumber
import SkyFloatingLabelTextField

class SendBitcoinVC: UIViewController {
    
    //MARK:- IB OUTLETS
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnBell: UIButton!
    @IBOutlet weak var vwBell: UIView!
    @IBOutlet weak var lblBellCount: UILabel!
    @IBOutlet weak var lblPhn: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var vwSmallPhm: UIView!
    @IBOutlet weak var vwSmallEmail: UIView!
    @IBOutlet weak var vwSelectedLine: UIView!
    @IBOutlet weak var selectedLineLeadCon: NSLayoutConstraint!
    @IBOutlet weak var vwCoin: UIView!
    @IBOutlet weak var lblAvailable: UILabel!
    @IBOutlet weak var tfHowMuch: UITextField!
    @IBOutlet weak var vwPhnTf: UIView!
    @IBOutlet weak var vwEmailTf: UIView!
    @IBOutlet weak var tfPhnNun: FPNTextField!
    @IBOutlet weak var btnCountryCode: UIButton!
    @IBOutlet weak var lblPhnNum: UILabel!
    @IBOutlet weak var tfEmail: SkyFloatingLabelTextField!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var btnPhnOption: UIButton!
    @IBOutlet weak var btnEmailOption: UIButton!
    
    var countryCode = "+91"
    var countryName = "United States"
    var phone = ""
    var isValid = false
    var imgVw = UIImageView()
    var isInAmount = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetUp()
    }
}

//MARK:- INITIAL SET UP
extension SendBitcoinVC{
    func initialSetUp(){
        CommmonUI.initialLbl(lbl: lblHeader, text: L10n.Send_Bitcoin.description, textColor: .appWhiteColor, font: .MontserratBold(Size.Header.sizeValue()))
        CommmonUI.initialLbl(lbl: lblPhn, text: L10n.Phone_No.description, textColor: .appWhiteColor, font: .MontserratBold(Size.Large.sizeValue()))
        CommmonUI.initialLbl(lbl: lblEmail, text: L10n.Email.description, textColor: .appWhiteColor, font: .MontserratBold(Size.Large.sizeValue()))
        CommmonUI.initialLbl(lbl: lblBellCount, text: "3", textColor: .appWhiteColor, font: .MontserratBold(Size.VSmall.sizeValue()))
        
        btnBack.layer.cornerRadius = 12
        btnBack.backgroundColor = UIColor.appWhiteColor.withAlphaComponent(0.24)
        vwSmallPhm.layer.cornerRadius = vwSmallPhm.bounds.height / 2
        vwSmallPhm.backgroundColor = UIColor.appWhiteColor.withAlphaComponent(0.24)
        vwSmallEmail.layer.cornerRadius = vwSmallEmail.bounds.height / 2
        vwSmallEmail.backgroundColor = UIColor.appWhiteColor.withAlphaComponent(0.24)
        vwSelectedLine.backgroundColor = UIColor.appWhiteColor.withAlphaComponent(0.86)
        self.vwEmailTf.isHidden = true
        
        btnBell.layer.cornerRadius = 12
        btnBell.backgroundColor = .appWhiteColor.withAlphaComponent(0.16)
        vwBell.layer.cornerRadius = vwBell.bounds.height / 2
        vwBell.backgroundColor = .AppRedColor
        vwCoin.layer.cornerRadius = vwCoin.bounds.height / 2
        
        CommmonUI.initialLbl(lbl: lblAvailable, text: "3.465 \(L10n.BTC_Available.description)", textColor: .secondaryTextColor, font: .MontserratBold(Size.Large.sizeValue()))
        
        tfPhnNun.textColor = UIColor.primaryTextColor
        tfPhnNun.clipsToBounds = true
        tfPhnNun.tintColor = UIColor.primaryTextColor
        tfPhnNun.attributedPlaceholder = NSAttributedString(string: L10n.Mobile_no.description,attributes: [NSAttributedString.Key.foregroundColor: UIColor.secondaryTextColor])
        tfPhnNun.font = UIFont.MontserratRegular(Size.XLarge.sizeValue())
        tfPhnNun.delegate = self
        tfPhnNun.leftViewMode = .never
        
        imgVw.image = Asset.phone_no.image()
        tfPhnNun.openView(false, img: imgVw)
        
        tfHowMuch.textColor = UIColor(netHex: 0xF9AA4BFF)
        tfHowMuch.clipsToBounds = true
        tfHowMuch.placeholder = "0.00"
        tfHowMuch.tintColor = UIColor(netHex: 0xF9AA4BFF)
        tfHowMuch.attributedPlaceholder = NSAttributedString(string: "0.00",attributes: [NSAttributedString.Key.foregroundColor: UIColor.secondaryTextColor])
        tfHowMuch.font = UIFont.MontserratBold(Size.max.sizeValue())
        
        self.btnCountryCode.setTitle(countryCode, for: .normal)
        self.btnCountryCode.tintColor = .primaryTextColor
        btnCountryCode.titleLabel?.font = .MontserratMedium(Size.Large.sizeValue())
        btnCountryCode.setTitleColor(.primaryTextColor, for: .normal)
        
        CommmonUI.initialLbl(lbl: lblPhnNum, text: L10n.Phone_No.description, textColor: UIColor.secondaryTextColor.withAlphaComponent(0.24), font: .MontserratMedium(Size.Large.sizeValue()))
        CommmonUI.initialLbl(lbl: lblDesc, text: vwEmailTf.isHidden ? L10n.Send_Desc.description : L10n.Send_Desc2.description, textColor: .secondaryTextColor, font: .MontserratMedium(Size.Small.sizeValue()))
        
        self.btnSend.layer.cornerRadius = 20
        self.btnSend.titleLabel?.font = UIFont.MontserratBold(Size.Medium.sizeValue())
        self.btnSend.setTitleColor(.appWhiteColor, for: .normal)
        self.btnSend.setTitle(L10n.Send.description, for: .normal)
        
        DispatchQueue.main.async {
            self.btnSend.applyGradient(colors: [UIColor(netHex: 0xF9AA4BFF).cgColor, UIColor(netHex: 0xF7931AFF).cgColor], isHorizontal: true)
        }
        
        CommmonUI.normalTF(tf: tfEmail, img: nil, placeHolder: L10n.Email_address.description, rytImage: Asset.phone_no.image())
        
        self.btnCountryCode.addTarget(self, action: #selector(btnCountryPickerTapped), for: .touchUpInside)
        self.btnPhnOption.addTarget(self, action: #selector(btnPhnOptionTapped), for: .touchUpInside)
        self.btnEmailOption.addTarget(self, action: #selector(btnEmailOptionTapped), for: .touchUpInside)
        self.btnBack.addTarget(self, action: #selector(btnBackTapped), for: .touchUpInside)
        self.btnSend.addTarget(self, action: #selector(btnSendTapped), for: .touchUpInside)
        self.btnBell.addTarget(self, action: #selector(btnBellTapped), for: .touchUpInside)
    }
}

//MARK:- Delegate method of country code flag
extension SendBitcoinVC: FPNTextFieldDelegate{
    
    //MARK:- open country code
    func fpnDisplayCountryList() {
        let listController: FPNCountryListViewController = FPNCountryListViewController(style: .grouped)
        listController.setup(repository: tfPhnNun.countryRepository)
        listController.title = "Countries"
        
        let navigationViewController = UINavigationController(rootViewController: listController)
        self.present(navigationViewController, animated: true, completion: nil)
        listController.didSelect = {[weak self] country in
            self?.countryName = country.name
            self?.countryCode = country.phoneCode
            //            self?.lblCountryName.text = "\(country.name) (\(country.phoneCode))"
            self?.tfPhnNun.setFlag(countryCode: country.code)
            self?.btnCountryCode.setTitle(self?.countryCode, for: .normal)
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
        case tfPhnNun:
            //            enterPhoneVM.removeError()
            maxLength = 16
        case tfEmail:
            maxLength = 70
        case tfHowMuch:
            maxLength = 7
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
    
    //    func textFieldDidBeginEditing(_ textField: UITextField) {
    //        textField.tintColor = isError ? .red : .primaryTextColor
    //    }
}


//MARK: - BtnActions
extension SendBitcoinVC{
    
    @objc func btnCountryPickerTapped(sender: UIButton){
        fpnDisplayCountryList()
    }
    
    @objc func btnPhnOptionTapped(sender: UIButton){
        self.vwEmailTf.isHidden = true
        self.vwPhnTf.isHidden = false
        self.selectedLineLeadCon.constant = 24
        self.lblDesc.text = L10n.Send_Desc.description
    }
    
    @objc func btnEmailOptionTapped(sender: UIButton){
        self.vwPhnTf.isHidden = true
        self.vwEmailTf.isHidden = false
        self.selectedLineLeadCon.constant = self.btnEmailOption.frame.width + 40
        self.lblDesc.text = L10n.Send_Desc2.description
    }
    
    @objc func btnBackTapped(sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func btnSendTapped(sender: UIButton){
        let vc = SendToFrndConfirmationVC.instantiateFromAppStoryboard(appStoryboard: .Send)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func btnBellTapped(sender: UITapGestureRecognizer){
        let vc = NotificationVC.instantiateFromAppStoryboard(appStoryboard: .Tabbar)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
