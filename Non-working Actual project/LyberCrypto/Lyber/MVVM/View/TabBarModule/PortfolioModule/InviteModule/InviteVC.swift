//
//  InviteVC.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 09/09/21.
//

import UIKit

class InviteVC: UIViewController {

    //MARK:- IB OUTLETS
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var btnShareYourLink: AppBlueButton!
    @IBOutlet weak var btnCopy: UIButton!
    @IBOutlet weak var btnTermsCond: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialSetUp()
    }
}

//MARK:- INITIAL SET UP
extension InviteVC{
    func initialSetUp(){
        CommmonUI.initialLbl(lbl: lblHeader, text: L10n.Earn_LYB_Tokens.description, textColor: .primaryTextColor, font: .MontserratBold(Size.XXXLarge.sizeValue()))
        lblDesc.attributedText = CommonFunctions.sendAttText([L10n.Earn_LYB_Tokens_Desc1.description, "\n\n\(L10n.Earn_LYB_Tokens_Desc2.description)"], fonts: [.MontserratMedium(Size.Medium.sizeValue()), .MontserratMedium(Size.Medium.sizeValue())], color: [.DescTextColor, .DescTextColor.withAlphaComponent(0.64)], alingment: .center)
        btnShareYourLink.setTitle(L10n.Share_Your_Invite_Link.description, for: .normal)
        CommmonUI.unBorderdBtn(btn: btnCopy, title: L10n.Copy.description, titlecolor: .themeColor, font: .MontserratBold(Size.Large.sizeValue()))
        CommmonUI.unBorderdBtn(btn: btnTermsCond, title: L10n.Terms_Conditions.description, titlecolor: .themeColor, font: .MontserratBold(Size.Large.sizeValue()))
        
        btnBack.addTarget(self, action: #selector(btnBackTapped), for: .touchUpInside)
        btnCopy.addTarget(self, action: #selector(btnCopyTapped), for: .touchUpInside)
        btnShareYourLink.addTarget(self, action: #selector(btnShareTapped), for: .touchUpInside)
    }
    
    func a(){
        let q = DispatchQueue(label: "", qos: .background)
        q.sync {
            print("adasd")
        }
        
    }
}

// MARK:- BUTTON ACTIONS
extension InviteVC{
    
    @objc func btnBackTapped(sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func btnCopyTapped(sender: UIButton){
        UIPasteboard.general.string = "Hello world"
        CommonFunctions.toster("Copied successfully")
    }
    
    @objc func btnShareTapped(sender: UIButton){
        CommonFunctions.showShareActivity(msg: "Share your referral code", image: nil, url: nil, sourceRect: nil)
    }
    
}

