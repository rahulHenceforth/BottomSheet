//
//  ChoosePaymentOptionVC.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 08/09/21.
//

import UIKit

class ChoosePaymentOptionVC: UIViewController {

    //MARK:- IB OUTLETS
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var btnCreditcard: UIButton!
    @IBOutlet weak var lblOr: UILabel!
    @IBOutlet weak var btnWireFrame: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialSetUp()
    }
}

//MARK:- INITIAL SET UP
extension ChoosePaymentOptionVC{
    func initialSetUp(){
        CommmonUI.initialLbl(lbl: lblHeader, text: L10n.Chose_Payment_method.description, textColor: .primaryTextColor, font: .MontserratBold(Size.XXXLarge.sizeValue()))
        CommmonUI.initialLbl(lbl: lblOr, text: L10n.or.description, textColor: .primaryTextColor, font: .MontserratMedium(Size.Medium.sizeValue()))
        CommmonUI.borderdBtn(btn: btnCreditcard, title: L10n.Credit_Card.description, titlecolor: .primaryTextColor, bgColor: .white, borderColor: .secondaryTextColor.withAlphaComponent(0.36), borderWidth: 1, font: .MontserratBold(Size.Large.sizeValue()), cornerRadius: 24)
        CommmonUI.borderdBtn(btn: btnWireFrame, title: L10n.Wire_deposit.description, titlecolor: .primaryTextColor, bgColor: .white, borderColor: .secondaryTextColor.withAlphaComponent(0.36), borderWidth: 1, font: .MontserratBold(Size.Large.sizeValue()), cornerRadius: 24)
        
        btnBack.addTarget(self, action: #selector(btnBackTapped), for: .touchUpInside)
        btnCreditcard.addTarget(self, action: #selector(btnCreditcardTapped), for: .touchUpInside)
        btnWireFrame.addTarget(self, action: #selector(btnWireFrameTapped), for: .touchUpInside)
        
    }
}

// MARK:- BUTTON ACTIONS
extension ChoosePaymentOptionVC{
    
    @objc func btnBackTapped(sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func btnCreditcardTapped(sender: UIButton){
        
    }
    
    @objc func btnWireFrameTapped(sender: UIButton){
        
    }
}


