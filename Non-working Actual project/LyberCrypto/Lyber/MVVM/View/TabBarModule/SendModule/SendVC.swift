//
//  SendVC.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 10/09/21.
//

import UIKit

class SendVC: UIViewController {

    //MARK:- IB OUTLETS
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var btnExternalWallet: UIButton!
    @IBOutlet weak var btnFrnd: UIButton!
    @IBOutlet weak var lblOr: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialSetUp()
    }
}

//MARK:- INITIAL SET UP
extension SendVC{
    func initialSetUp(){
        CommmonUI.initialLbl(lbl: lblHeader, text: L10n.Chose_Withdrawal_method.description, textColor: .primaryTextColor, font: .MontserratBold(Size.XXXLarge.sizeValue()))
        CommmonUI.initialLbl(lbl: lblOr, text: L10n.or.description, textColor: .DescTextColor, font: .MontserratMedium(Size.Medium.sizeValue()))
        CommmonUI.borderdBtn(btn: btnExternalWallet, title: L10n.External_Wallet.description, titlecolor: .primaryTextColor, bgColor: .white, borderColor: .secondaryTextColor.withAlphaComponent(0.36), borderWidth: 1, font: .MontserratBold(Size.Large.sizeValue()), cornerRadius: 24)
        CommmonUI.borderdBtn(btn: btnFrnd, title: L10n.Friends.description, titlecolor: .primaryTextColor, bgColor: .white, borderColor: .secondaryTextColor.withAlphaComponent(0.36), borderWidth: 1, font: .MontserratBold(Size.Large.sizeValue()), cornerRadius: 24)
        
        btnExternalWallet.addTarget(self, action: #selector(btnExternalWalletTapped), for: .touchUpInside)
        btnFrnd.addTarget(self, action: #selector(btnFrndTapped), for: .touchUpInside)
        
    }
}

// MARK:- BUTTON ACTIONS
extension SendVC{
    
    @objc func btnExternalWalletTapped(sender: UIButton){
        let vc = FriendsVC.instantiateFromAppStoryboard(appStoryboard: .Send)
        vc.screenType = .externalWallet
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func btnFrndTapped(sender: UIButton){
        let vc = FriendsVC.instantiateFromAppStoryboard(appStoryboard: .Send)
        vc.screenType = .friends
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

