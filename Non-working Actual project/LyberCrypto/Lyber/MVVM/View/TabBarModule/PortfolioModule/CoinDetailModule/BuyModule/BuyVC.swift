//
//  BuyVC.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 09/09/21.
//

import UIKit

class BuyVC: UIViewController {

    //MARK:- IB OUTLETS
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var vwCoint: UIView!
    @IBOutlet weak var imgCoin: UIImageView!
    @IBOutlet weak var lblCoinName: UILabel!
    @IBOutlet weak var lblBalance: UILabel!
    @IBOutlet weak var tfAmnt: UITextField!
    @IBOutlet weak var btnNxtStep: UIButton!
    @IBOutlet weak var vwTf: UIView!
    @IBOutlet weak var lblHowMuchCurrency: UILabel!
    
    var isSell = false
    var isInAmount = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialSetUp()
    }
}

//MARK:- INITIAL SET UP
extension BuyVC{
    func initialSetUp(){
        CommmonUI.initialLbl(lbl: lblHeader, text: isSell ? L10n.Sell.description : L10n.Buy.description, textColor: .primaryTextColor, font: .MontserratBold(Size.XXXLarge.sizeValue()))
        CommmonUI.initialLbl(lbl: lblCoinName, text: L10n.Ethereum.description, textColor: .primaryTextColor, font: .MontserratMedium(Size.Large.sizeValue()))
        CommmonUI.initialLbl(lbl: lblBalance, text: "4.7845 \(L10n.ETH.description) Available", textColor: .DescTextColor, font: .MontserratMedium(Size.Medium.sizeValue()))
        CommmonUI.initialLbl(lbl: lblHowMuchCurrency, text: "0.00\(L10n.ETH.description)", textColor: .DescTextColor, font: .MontserratMedium(Size.Large.sizeValue()))
        vwCoint.layer.cornerRadius = vwCoint.bounds.height / 2
        vwTf.layer.cornerRadius = 24
        vwTf.layer.borderWidth = 1
        vwTf.layer.borderColor = UIColor.secondaryTextColor.withAlphaComponent(0.36).cgColor
        
        tfAmnt.textColor = UIColor.themeColor
        tfAmnt.clipsToBounds = true
        tfAmnt.tintColor = UIColor.themeColor
        tfAmnt.attributedPlaceholder = NSAttributedString(string: "€0.00",attributes: [NSAttributedString.Key.foregroundColor: UIColor.secondaryTextColor])
        tfAmnt.font = UIFont.MontserratBold(Size.max.sizeValue())
        
        CommmonUI.borderdBtn(btn: btnNxtStep, title: L10n.SUBMIT_CAPS.description, titlecolor: .DescTextColor, bgColor: .white, borderColor: .white, borderWidth: 0, font: .MontserratBold(Size.Medium.sizeValue()), cornerRadius: 20)
        
        btnNxtStep.addTarget(self, action: #selector(btnNxtStepTapped), for: .touchUpInside)
        btnBack.addTarget(self, action: #selector(btnBackTapped), for: .touchUpInside)
    }
}

//MARK: TEXTFLD DELEGATE
extension BuyVC: UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentString: NSString = textField.text! as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        var maxLength = 120
        
        switch textField {
        case tfAmnt:
            maxLength = 7
            if tfAmnt.text?.count == 0{
                tfAmnt.text?.insert("€", at: tfAmnt.text?.startIndex ?? String().startIndex)
            }
            if newString.length <= maxLength{
                var trimmed = ""
                if newString.hasPrefix("€"){
                    trimmed = "\(newString)"
                    trimmed.remove(at: trimmed.startIndex)
                }else{
                    trimmed = "\(newString)"
                }
                lblHowMuchCurrency.text = "\((Double(trimmed) ?? 0.0) / 8000)\(L10n.ETH.description)"
            }
        default:
            break
        }
        
        if let char = string.cString(using: String.Encoding.utf8) {                         //TO ENABLE BCKSPACE EVEN IF NUMBERS ARE MORE THAN fixed CHAR LIMIT
            let isBackSpace = strcmp(char, "\\b")
            if (isBackSpace == -92) {
                if tfAmnt.text?.count == 2{
                    tfAmnt.text?.removeAll()
                    return true
                }
            }
        }
        
        return newString.length <= maxLength
    }
}

// MARK:- BUTTON ACTIONS
extension BuyVC{
    
    @objc func btnNxtStepTapped(sender: UIButton){
        let vc = BoughtSuccessfullVC.instantiateFromAppStoryboard(appStoryboard: .CoinDetail)
        vc.eventName = isSell ? .Sell : .Buy
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func btnBackTapped(sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
}


