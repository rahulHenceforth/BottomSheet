//
//  LinkBankVC.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 15/09/21.
//

import UIKit
import SkyFloatingLabelTextField

class LinkBankVC: UIViewController {
    
    //MARK:- IB OUTLETS
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var lblSubHeader: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var tfName: SkyFloatingLabelTextField!
    @IBOutlet weak var tfAccountNum: SkyFloatingLabelTextField!
    @IBOutlet weak var tfRoutingNum: SkyFloatingLabelTextField!
    @IBOutlet weak var tfAddress: SkyFloatingLabelTextField!
    @IBOutlet weak var tfPostalCode: SkyFloatingLabelTextField!
    @IBOutlet weak var viewMaain: UIView!
    @IBOutlet weak var btnAdd: AppBlueButton!
    @IBOutlet weak var btnSkip: UIButton!
    
    var isFromEditProfile = false
    var linkBankVM = LinkBankVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetUp()
    }
}

//MARK:- INITIAL SET UP
extension LinkBankVC{
    func initialSetUp(){
        
        CommmonUI.initialLbl(lbl: lblHeader, text: isFromEditProfile ? L10n.Linked_Bank_Account.description : L10n.Add_Bank_Account.description, textColor: .primaryTextColor, font: .MontserratBold(Size.XXXLarge.sizeValue()))
        CommmonUI.initialLbl(lbl: lblSubHeader, text: L10n.Add_Bank_Account_Desc.description, textColor: .DescTextColor, font: .MontserratMedium(Size.Medium.sizeValue()))
        CommmonUI.normalTF(tf: tfName, img: nil, placeHolder: L10n.Full_Name.description)
        CommmonUI.normalTF(tf: tfAccountNum, img: nil, placeHolder: L10n.AccountNum.description)
        CommmonUI.normalTF(tf: tfAddress, img: nil, placeHolder: L10n.Address.description)
        CommmonUI.normalTF(tf: tfPostalCode, img: nil, placeHolder: L10n.PostalCode.description)
        CommmonUI.normalTF(tf: tfRoutingNum, img: nil, placeHolder: L10n.RoutingNum.description)
        
        DispatchQueue.main.async {
            self.viewMaain.roundCorners([.topLeft, .topRight], radius: 36)
        }
        
        CommmonUI.unBorderdBtn(btn: btnSkip, title: L10n.Skip.description, titlecolor: .primaryTextColor, font: UIFont.MontserratBold(Size.Medium.sizeValue()))
        btnSkip.layer.cornerRadius = 20
        btnSkip.backgroundColor = .WalkthroughBgColor
        btnAdd.setTitle(L10n.ADD.description, for: .normal)
        
        btnSkip.addTarget(self, action: #selector(btnSkipTapped(_:)), for: .touchUpInside)
        btnAdd.addTarget(self, action: #selector(btnAddTapped(_:)), for: .touchUpInside)
        btnBack.addTarget(self, action: #selector(btnBackTapped(_:)), for: .touchUpInside)
        
        if isFromEditProfile{
            self.btnSkip.isHidden = true
            self.btnAdd.setTitle(L10n.SUBMIT_CAPS.description, for: .normal)
        }
    }
}

//MARK: TEXTFLD DELEGATE
extension LinkBankVC: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case tfName:
            tfAccountNum.becomeFirstResponder()
        case tfAccountNum:
            tfRoutingNum.becomeFirstResponder()
        case tfRoutingNum:
            tfAddress.becomeFirstResponder()
        case tfAddress:
            tfPostalCode.becomeFirstResponder()
        case tfPostalCode:
            self.view.endEditing(true)
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
        case tfName:
            maxLength = 15
            CommmonUI.normalTF(tf: tfName, img: nil, placeHolder: L10n.Full_Name.description)
        case tfAccountNum:
            maxLength = 16
            CommmonUI.normalTF(tf: tfAccountNum, img: nil, placeHolder: L10n.AccountNum.description)
        case tfRoutingNum:
            maxLength = 8
            CommmonUI.normalTF(tf: tfRoutingNum, img: nil, placeHolder: L10n.RoutingNum.description)
        case tfAddress:
            maxLength = 70
            CommmonUI.normalTF(tf: tfAddress, img: nil, placeHolder: L10n.Address.description)
        case tfPostalCode:
            maxLength = 6
            CommmonUI.normalTF(tf: tfPostalCode, img: nil, placeHolder: L10n.PostalCode.description)
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

// MARK: - EXTERNAL FUNCTIONS
extension LinkBankVC{
    @objc func btnSkipTapped(_ sender: UIButton){
        let vc = ProfileVerificationVC.instantiateFromAppStoryboard(appStoryboard: .Main)
        vc.screenType = .Welcome
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func btnAddTapped(_ sender: UIButton){
        let result = linkBankVM.Validate(with: LinkBankRequest(name: self.tfName.text, accountNum: self.tfAccountNum.text, routingNum: self.tfRoutingNum.text, address: self.tfAddress.text, postalCode: self.tfPostalCode.text))
        
        if let error = result.errorMsg{
            CommonFunctions.toster(error)
            switch result.errorOnField {
            case .name:
                CommmonUI.errorTF(tf: tfName, img: nil, placeHolder: L10n.Full_Name.description)
            case .accountNum:
                CommmonUI.errorTF(tf: tfAccountNum, img: nil, placeHolder: L10n.AccountNum.description)
            case .routingNum:
                CommmonUI.errorTF(tf: tfRoutingNum, img: nil, placeHolder: L10n.RoutingNum.description)
            case .address:
                CommmonUI.errorTF(tf: tfAddress, img: nil, placeHolder: L10n.Address.description)
            case .postalCode:
                CommmonUI.errorTF(tf: tfPostalCode, img: nil, placeHolder: L10n.PostalCode.description)
            default:
                return
            }
            
        }else{
            if self.isFromEditProfile{
                self.navigationController?.popViewController(animated: true)
            }else{
                let vc = ProfileVerificationVC.instantiateFromAppStoryboard(appStoryboard: .Main)
                vc.screenType = .Welcome
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    @objc func btnBackTapped(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}
