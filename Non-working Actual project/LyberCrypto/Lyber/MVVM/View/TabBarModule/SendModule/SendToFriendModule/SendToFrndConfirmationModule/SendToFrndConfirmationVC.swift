//
//  SendToFrndConfirmationVC.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 13/09/21.
//

import UIKit

class SendToFrndConfirmationVC: UIViewController {
    
    //MARK:- IB OUTLETS
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var lblHeaderDesc: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var vwBottom: UIView!
    @IBOutlet weak var lblReciept: UILabel!
    @IBOutlet weak var lblEmailPhone: UILabel!
    @IBOutlet weak var vwBorder: UIView!
    @IBOutlet weak var lbLAmnt: UILabel!
    @IBOutlet weak var lblAmntValue: UILabel!
    @IBOutlet weak var lblAmntMoney: UILabel!
    @IBOutlet weak var lblMoneyVal: UILabel!
    @IBOutlet weak var btnConfirm: AppBlueButton!
    @IBOutlet var vwRound: [UIView]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetUp()
    }
    
}

//MARK:- INITIAL SET UP
extension SendToFrndConfirmationVC{
    func initialSetUp(){
        CommmonUI.initialLbl(lbl: lblHeader, text: L10n.Send_To_Your_Friend.description, textColor: .primaryTextColor, font: .MontserratBold(Size.XXXLarge.sizeValue()))
        CommmonUI.initialLbl(lbl: lblHeaderDesc, text: L10n.Confirm_your_transaction.description, textColor: .primaryTextColor, font: .MontserratMedium(Size.Medium.sizeValue()))
        CommmonUI.initialLbl(lbl: lblReciept, text: L10n.Recepient.description, textColor: .secondaryTextColor, font: .MontserratMedium(Size.Large.sizeValue()))
        CommmonUI.initialLbl(lbl: lblEmailPhone, text: "Abcd@gmail.com", textColor: .primaryTextColor, font: .MontserratBold(Size.Large.sizeValue()))
        CommmonUI.initialLbl(lbl: lbLAmnt, text: L10n.Amount.description, textColor: .secondaryTextColor, font: .MontserratMedium(Size.Medium.sizeValue()))
        CommmonUI.initialLbl(lbl: lblAmntMoney, text: L10n.Amount_€.description, textColor: .secondaryTextColor, font: .MontserratMedium(Size.Medium.sizeValue()))
        CommmonUI.initialLbl(lbl: lblAmntValue, text: "0.00965 BTC", textColor: .primaryTextColor, font: .MontserratBold(Size.Header.sizeValue()))
        CommmonUI.initialLbl(lbl: lblMoneyVal, text: "€103.24", textColor: .primaryTextColor, font: .MontserratBold(Size.Header.sizeValue()))
        
        DispatchQueue.main.async {
            self.vwBorder.addDashedLine(with: UIColor(netHex: 0xBDC4D3FF))
            self.vwBottom.roundCorners([.topLeft, .topRight], radius: 20)
        }
        
        btnConfirm.setTitle(L10n.CONFIRM.description, for: .normal)
        
        for vw in vwRound{
            vw.layer.cornerRadius = vw.frame.height / 2
        }
        
        btnBack.addTarget(self, action: #selector(btnBackTapped), for: .touchUpInside)
        btnConfirm.addTarget(self, action: #selector(btnConfirmTapped), for: .touchUpInside)
    }
}

// MARK:- BUTTON ACTIONS
extension SendToFrndConfirmationVC{
    
    @objc func btnBackTapped(sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func btnConfirmTapped(sender: UIButton){
        let vc = BoughtSuccessfullVC.instantiateFromAppStoryboard(appStoryboard: .CoinDetail)
        vc.eventName = .Sent
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


