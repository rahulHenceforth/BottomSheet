//
//  ExchangeVC.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 09/09/21.
//

import UIKit
//import SkyFloatingLabelTextField

class ExchangeVC: UIViewController {
    
    //MARK:- IB OUTLETS
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var vwExchangeFrom: UIView!
    @IBOutlet weak var viewExchangeTo: UIView!
    @IBOutlet weak var imgFrom: UIImageView!
    @IBOutlet weak var lblIHave: UILabel!
    @IBOutlet weak var lblBalanceHave: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnCoinHave: UIButton!
    @IBOutlet weak var imgTo: UIImageView!
    @IBOutlet weak var lblIWant: UILabel!
    @IBOutlet weak var lblConvertedBalance: UILabel!
    @IBOutlet weak var lblPriceTo: UILabel!
    @IBOutlet weak var btnCoinWant: UIButton!
    @IBOutlet weak var viewConevrt: UIView!
    @IBOutlet weak var btnConvert: UIButton!
    @IBOutlet weak var btnNextStep: UIButton!
//    @IBOutlet weak var tfTokens: SkyFloatingLabelTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetUp()
    }
}

//MARK:- INITIAL SET UP
extension ExchangeVC{
    func initialSetUp(){
        CommmonUI.initialLbl(lbl: lblHeader, text: L10n.Exchange.description, textColor: .appWhiteColor, font: .MontserratBold(Size.XXXLarge.sizeValue()))
        
        vwExchangeFrom.layer.cornerRadius = 24
        vwExchangeFrom.layer.borderColor = UIColor.secondaryTextColor.withAlphaComponent(0.36).cgColor
        vwExchangeFrom.backgroundColor = .appWhiteColor.withAlphaComponent(0.16)
        viewExchangeTo.layer.cornerRadius = 24
        viewExchangeTo.layer.borderColor = UIColor.secondaryTextColor.withAlphaComponent(0.36).cgColor
        viewExchangeTo.backgroundColor = .appWhiteColor.withAlphaComponent(0.16)
        
        viewConevrt.layer.cornerRadius = viewConevrt.bounds.height / 2
        btnConvert.layer.cornerRadius = btnConvert.bounds.height / 2
        
        CommmonUI.initialLbl(lbl: lblIHave, text: L10n.I_have.description, textColor: .WalkthroughBgColor, font: .MontserratMedium(Size.Small.sizeValue()))
        CommmonUI.initialLbl(lbl: lblIWant, text: L10n.I_want.description, textColor: .WalkthroughBgColor, font: .MontserratMedium(Size.Small.sizeValue()))
        CommmonUI.initialLbl(lbl:  lblBalanceHave, text: "0.12000 BTC", textColor: .WalkthroughBgColor, font: .MontserratMedium(Size.Small.sizeValue()))
        CommmonUI.initialLbl(lbl:  lblConvertedBalance, text: "0.12000 ETH", textColor: .WalkthroughBgColor, font: .MontserratMedium(Size.Small.sizeValue()))
        CommmonUI.initialLbl(lbl: lblPrice, text: "€41,449.73", textColor: .appWhiteColor, font: .MontserratBold(Size.Large.sizeValue()))
        CommmonUI.initialLbl(lbl: lblPriceTo, text: "€2,747.20", textColor: .appWhiteColor, font: .MontserratBold(Size.Large.sizeValue()))
        CommmonUI.unBorderdBtn(btn: btnCoinHave, title: L10n.Bitcoin.description, titlecolor: .appWhiteColor, font: .MontserratBold(Size.Large.sizeValue()))
        CommmonUI.unBorderdBtn(btn: btnCoinWant, title: L10n.Bitcoin.description, titlecolor: .appWhiteColor, font: .MontserratBold(Size.Large.sizeValue()))
        CommmonUI.borderdBtn(btn: btnNextStep, title: L10n.SUBMIT_CAPS.description, titlecolor: .DescTextColor, bgColor: .appWhiteColor, borderColor: .appWhiteColor, borderWidth: 0, font: .MontserratBold(Size.Medium.sizeValue()), cornerRadius: 20)
        
//        CommmonUI.normalTF(tf: tfTokens, img: nil, placeHolder: L10n.No_of_tokens.description)
        
        btnNextStep.addTarget(self, action: #selector(btnNextStepTapped), for: .touchUpInside)
        btnBack.addTarget(self, action: #selector(btnBackTapped), for: .touchUpInside)
        
    }
}

// MARK:- BUTTON ACTIONS
extension ExchangeVC{
    
    @objc func btnNextStepTapped(sender: UIButton){
        let vc = BoughtSuccessfullVC.instantiateFromAppStoryboard(appStoryboard: .CoinDetail)
        vc.eventName = .Exchange
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func btnBackTapped(sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}


//MARK: TEXTFLD DELEGATE
//extension ExchangeVC: UITextFieldDelegate, UITextViewDelegate{
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        switch textField {
//        case tfTokens:
//            tfTokens.resignFirstResponder()
//        default:
//            break
//        }
//        return true
//    }
//
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        let currentString: NSString = textField.text! as NSString
//        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
//        var maxLength = 120
//
//        switch textField {
//        case tfTokens:
//            maxLength = 7
//            CommmonUI.normalTF(tf: tfTokens, img: nil, placeHolder: L10n.No_of_tokens.description)
//        default:
//            break
//        }
//
//        if let char = string.cString(using: String.Encoding.utf8) {                         //TO ENABLE BCKSPACE EVEN IF NUMBERS ARE MORE THAN fixed CHAR LIMIT
//            let isBackSpace = strcmp(char, "\\b")
//            if (isBackSpace == -92) {
//                return true
//            }
//        }
//
//        return newString.length <= maxLength
//    }
//}
