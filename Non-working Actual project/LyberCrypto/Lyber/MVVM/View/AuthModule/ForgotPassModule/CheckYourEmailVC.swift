//
//  CheckYourEmailVC.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 01/09/21.
//

import UIKit

class CheckYourEmailVC: UIViewController {
    
    //MARK:- IB OUTLETS
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var lblHeaderDesc: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnBackToLogin: AppBlueButton!
    
    var isFromCreateAccountScreen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetUp()
    }
}


//MARK:- INITIAL SET UP
extension CheckYourEmailVC{
    func initialSetUp(){
        
        CommmonUI.initialLbl(lbl: lblHeader, text: L10n.Check_Your_Email.description, textColor: .primaryTextColor, font: .MontserratBold(Size.XXXLarge.sizeValue()))
        CommmonUI.initialLbl(lbl: lblHeaderDesc, text: L10n.Check_Your_Email_Desc.description, textColor: .DescTextColor, font: .MontserratMedium(Size.Medium.sizeValue()))
        
        self.btnBackToLogin.setTitle(L10n.Back_to_Login.description, for: .normal)
        btnBackToLogin.addTarget(self, action: #selector(btnBackToLoginTapped) , for: .touchUpInside)
        btnBack.addTarget(self, action: #selector(btnBackTapped) , for: .touchUpInside)
        
        if isFromCreateAccountScreen{
            self.lblHeader.text = L10n.Email_Verification.description
            self.lblHeaderDesc.attributedText = CommonFunctions.sendAttText(["\(L10n.Email_verification_desc1.description)", "abc@avc.com", " \n\n\(L10n.Email_verification_desc2.description)"], fonts: [.MontserratMedium(Size.Medium.sizeValue()), .MontserratMedium(Size.Medium.sizeValue()), .MontserratMedium(Size.Medium.sizeValue())], color: [.DescTextColor, .primaryTextColor, .DescTextColor], alingment: .center)
            self.btnBackToLogin.setTitle(L10n.Next_Step.description, for: .normal)
            self.btnBack.isHidden = true
        }
    }
}


// MARK:- BUTTON ACTIONS
extension CheckYourEmailVC{
    
    @objc func btnBackToLoginTapped(_ sender: UIButton){
        if !isFromCreateAccountScreen{
            if let vc = self.navigationController?.hasViewController(ofKind: LogInVC.self){
                self.navigationController?.popToViewController(vc, animated: true)
            }
        }else{
            let vc = EnterPhoneVC.instantiateFromAppStoryboard(appStoryboard: .Main)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func btnBackTapped(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}
