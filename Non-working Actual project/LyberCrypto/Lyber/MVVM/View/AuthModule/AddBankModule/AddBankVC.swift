//
//  AddBankVC.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 07/09/21.
//

import UIKit
import SkyFloatingLabelTextField

class AddBankVC: UIViewController {
    
    //MARK:- IB OUTLETS
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var lblHeaderDesc: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var tfName: SkyFloatingLabelTextField!
    @IBOutlet weak var tfCardNumber: SkyFloatingLabelTextField!
    @IBOutlet weak var tfExpiry: SkyFloatingLabelTextField!
    @IBOutlet weak var tfCvv: SkyFloatingLabelTextField!
    @IBOutlet weak var btnSkip: UIButton!
    @IBOutlet weak var btnAdd: AppBlueButton!
    
    var rytImg = UIImageView()
//    var isFromEditProfile = false
     var addBankVM = AddBankVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetUp()
        
    }
}


//MARK:- INITIAL SET UP
extension AddBankVC{
    func initialSetUp(){
        
        CommmonUI.initialLbl(lbl: lblHeader, text: L10n.Card_Details.description, textColor: .primaryTextColor, font: .MontserratBold(Size.XXXLarge.sizeValue()))
        CommmonUI.initialLbl(lbl: lblHeaderDesc, text: L10n.Card_Details_Desc.description, textColor: .DescTextColor, font: .MontserratMedium(Size.Medium.sizeValue()))
        CommmonUI.normalTF(tf: tfName, img: nil, placeHolder: L10n.Name_On_Card.description)
        CommmonUI.normalTF(tf: tfCardNumber, img: nil, placeHolder: L10n.Card_Number.description)
        CommmonUI.normalTF(tf: tfExpiry, img: nil, placeHolder: L10n.Expiry.description)
        CommmonUI.normalTF(tf: tfCvv, img: nil, placeHolder: L10n.CVV.description)
        
        //        rytImg.image = Asset.tick.image()
        //        tfCardNumber.openView(false, img: rytImg)
        
        DispatchQueue.main.async {
            self.viewMain.roundCorners([.topLeft, .topRight], radius: 36)
        }
        
        CommmonUI.unBorderdBtn(btn: btnSkip, title: L10n.Skip.description, titlecolor: .primaryTextColor, font: UIFont.MontserratBold(Size.Medium.sizeValue()))
        btnSkip.layer.cornerRadius = 20
        btnSkip.backgroundColor = .WalkthroughBgColor
        btnAdd.setTitle(L10n.ADD.description, for: .normal)
        
        btnSkip.addTarget(self, action: #selector(btnSkipTapped(_:)), for: .touchUpInside)
        btnAdd.addTarget(self, action: #selector(btnAddTapped(_:)), for: .touchUpInside)
        btnBack.addTarget(self, action: #selector(btnBackTapped(_:)), for: .touchUpInside)
        
//        if isFromEditProfile{
            self.btnSkip.isHidden = true
//            self.btnAdd.setTitle(L10n.SUBMIT_CAPS.description, for: .normal)
//        }
    }
}

//MARK: TEXTFLD DELEGATE
extension AddBankVC: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case tfName:
            tfCardNumber.becomeFirstResponder()
        case tfCardNumber:
            tfExpiry.becomeFirstResponder()
        default:
            break
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentString: NSString = textField.text! as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        var maxLength = 120
        
        if textField == tfExpiry{
            guard let oldText = textField.text, let r = Range(range, in: oldText) else {
                return true
            }
            let updatedText = oldText.replacingCharacters(in: r, with: string)
            if string == "" {
                if updatedText.count == 2 {
                    textField.text = "\(updatedText.prefix(1))"
                    return false
                }
            } else if updatedText.count == 1 {
                if updatedText > "1" {
                    textField.text = "0\(updatedText)/"
                    return false
                }
            } else if updatedText.count == 2 {
                if updatedText <= "12" { //Prevent user to not enter month more than 12
                    textField.text = "\(updatedText)/" //This will add "/" when user enters 2nd digit of month
                }
                return false
            } else if updatedText.count > 5 {
                return false
            }
            CommmonUI.normalTF(tf: tfExpiry, img: nil, placeHolder: L10n.Expiry.description)
        }
        else if(textField == tfCvv){
            CommmonUI.normalTF(tf: tfCvv, img: nil, placeHolder: L10n.CVV.description)
            maxLength = 4
        }
        else if(textField == tfCardNumber){
            CommmonUI.normalTF(tf: tfCardNumber, img: nil, placeHolder: L10n.Card_Number.description)
            maxLength = 16
        }
        else if(textField == tfName){
            CommmonUI.normalTF(tf: tfName, img: nil, placeHolder: L10n.Name_On_Card.description)
            maxLength = 16
        }
        return newString.length <= maxLength
    }
}


// MARK: - EXTERNAL FUNCTIONS
extension AddBankVC{
    @objc func btnSkipTapped(_ sender: UIButton){
        let vc = ProfileVerificationVC.instantiateFromAppStoryboard(appStoryboard: .Main)
        vc.screenType = .Welcome
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func btnAddTapped(_ sender: UIButton){
        let request = addBankVM.Validate(with: AddBankRequest(name: tfName.text, cardNum: tfCardNumber.text, expiry: tfExpiry.text, cvv: tfCvv.text))
        
        if let error = request.errorMsg{
            CommonFunctions.toster(error)
            
            switch request.errorOnField{
            case .name:
                CommmonUI.errorTF(tf: tfName, img: nil, placeHolder: L10n.Name_On_Card.description)
            case .cardNum:
                CommmonUI.errorTF(tf: tfCardNumber, img: nil, placeHolder: L10n.Card_Number.description)
            case .expiry:
                CommmonUI.errorTF(tf: tfExpiry, img: nil, placeHolder: L10n.Expiry.description)
            case .cvv:
                CommmonUI.errorTF(tf: tfCvv, img: nil, placeHolder: L10n.CVV.description)
            default:
                return
            }
            
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func btnBackTapped(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}
