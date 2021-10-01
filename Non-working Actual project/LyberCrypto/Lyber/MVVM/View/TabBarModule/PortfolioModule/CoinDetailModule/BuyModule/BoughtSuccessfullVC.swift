//
//  BoughtSuccessfullVC.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 09/09/21.
//

enum eventName {
    case Buy
    case Sell
    case Exchange
    case Deposit
    case Sent
}

import UIKit

class BoughtSuccessfullVC: UIViewController {

    //MARK:- IB OUTLETS
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var btnContinue: AppBlueButton!
    @IBOutlet weak var viewIsSold: UIView!
    @IBOutlet weak var lblSoldQty: UILabel!
    @IBOutlet weak var lblUpdatedQty: UILabel!
    @IBOutlet weak var lblBalanceQty: UILabel!
    
    
    var eventName: eventName = .Buy
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialSetUp()
    }
}

//MARK:- INITIAL SET UP
extension BoughtSuccessfullVC{
    func initialSetUp(){
        
        CommmonUI.initialLbl(lbl: lblSoldQty, text: "-0.091 BTC", textColor: .AppRedColor, font: .MontserratMedium(Size.Medium.sizeValue()))
        CommmonUI.initialLbl(lbl: lblUpdatedQty, text: L10n.Updated_Balance.description, textColor: .primaryTextColor, font: .MontserratBold(Size.Large.sizeValue()))
        CommmonUI.initialLbl(lbl: lblBalanceQty, text: "0.3784 BTC", textColor: .themeColor, font: .MontserratBold(Size.Header.sizeValue()))

        btnContinue.setTitle(L10n.CONTINUE.description, for: .normal)
        btnContinue.addTarget(self, action: #selector(btnContinueTapped), for: .touchUpInside)
        
        if eventName == .Sell{
            viewIsSold.isHidden = false
            lblHeader.attributedText = CommonFunctions.sendAttText([L10n.You_successfully_sold.description, " 0.3787 BTC"], fonts: [.MontserratBold(Size.XXXLarge.sizeValue()), .MontserratBold(30)], color: [.primaryTextColor, .themeColor], alingment: .center)
        }else if eventName == .Exchange{
            viewIsSold.isHidden = false
            lblHeader.attributedText = CommonFunctions.sendAttText([L10n.You_successfully_exchange.description, "\n 0.3787 BTC to 5 ETH"], fonts: [.MontserratBold(Size.XXXLarge.sizeValue()), .MontserratBold(30)], color: [.primaryTextColor, .themeColor], alingment: .center)
        }else if eventName == .Sent{
            viewIsSold.isHidden = false
            lblHeader.attributedText = CommonFunctions.sendAttText([L10n.You_successfully_Sent.description, "\n 0.3787 BTC to abc@bc.com"], fonts: [.MontserratBold(Size.XXXLarge.sizeValue()), .MontserratBold(30)], color: [.primaryTextColor, .themeColor], alingment: .center)
        }else{
            viewIsSold.isHidden = true
            lblHeader.attributedText = CommonFunctions.sendAttText([L10n.You_successfully_bought.description, " 0.3787 BTC"], fonts: [.MontserratBold(Size.XXXLarge.sizeValue()), .MontserratBold(30)], color: [.primaryTextColor, .themeColor], alingment: .center)
        }
    }
}

// MARK:- BUTTON ACTIONS
extension BoughtSuccessfullVC{
    
    @objc func btnContinueTapped(sender: UIButton){
        self.navigationController?.popToViewController(ofClass: TabBarVC.self)
    }
}


