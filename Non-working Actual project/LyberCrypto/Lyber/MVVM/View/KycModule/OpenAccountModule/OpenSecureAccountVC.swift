//
//  OpenSecureAccountVC.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 07/09/21.
//

import UIKit

class OpenSecureAccountVC: UIViewController {

    //MARK:- IB OUTLETS
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var viewMain2: UIView!
    @IBOutlet weak var lblVerificationType1: UILabel!
    @IBOutlet weak var lblVerificationType2: UILabel!
    @IBOutlet weak var lblVerificationType3: UILabel!
    @IBOutlet weak var lblTermsConditions: UILabel!
    @IBOutlet weak var btnSwitch: UIButton!
    @IBOutlet weak var btnNxtStep: AppBlueButton!
    @IBOutlet weak var vwTermsAndCond: UIView!
    
    var isConditionsAccptd = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialSetUp()
    }
}

//MARK:- INITIAL SET UP
extension OpenSecureAccountVC{
    func initialSetUp(){
        CommmonUI.initialLbl(lbl: lblHeader, text: L10n.Open_your_secure_account.description, textColor: .primaryTextColor, font: .MontserratBold(Size.XXXLarge.sizeValue()))
        CommmonUI.initialLbl(lbl: lblDescription, text: L10n.Open_your_secure_account_desc.description, textColor: .DescTextColor, font: .MontserratMedium(Size.Medium.sizeValue()))
        CommmonUI.initialLbl(lbl: lblVerificationType1, text: L10n.Residential_Address.description, textColor: .primaryTextColor, font: .MontserratMedium(Size.Medium.sizeValue()))
        CommmonUI.initialLbl(lbl: lblVerificationType2, text: L10n.Investment_Experience.description, textColor: .primaryTextColor, font: .MontserratMedium(Size.Medium.sizeValue()))
        CommmonUI.initialLbl(lbl: lblVerificationType3, text: L10n.Identity_Verification.description, textColor: .primaryTextColor, font: .MontserratMedium(Size.Medium.sizeValue()))
        
        self.lblTermsConditions.attributedText = CommonFunctions.sendAttText([L10n.I_agree_with_the.description,
                                                                              L10n.Terms_of_Use.description,
                                                                              L10n.and_the.description,
                                                                              L10n.Privacy_Policy.description]
                                                                 , fonts: [.MontserratMedium(Size.Small.sizeValue()),
                                                                           .MontserratSemiBold(Size.Small.sizeValue()),
                                                                           .MontserratMedium(Size.Small.sizeValue()),
                                                                           .MontserratSemiBold(Size.Small.sizeValue())]
                                                                 , color: [.primaryTextColor,
                                                                           .themeColor,
                                                                           .primaryTextColor,
                                                                           .themeColor]
                                                                , alingment: .left)
        
        DispatchQueue.main.async {
            self.viewMain.roundCorners([.topLeft, .topRight], radius: 36)
            self.viewMain2.roundCorners([.topLeft, .topRight], radius: 36)
        }
        
        vwTermsAndCond.layer.cornerRadius = 20
        btnNxtStep.setTitle(L10n.Next_Step.description, for: .normal)
        btnNxtStep.addTarget(self, action: #selector(btnNxtStepTapped), for: .touchUpInside)
        btnSwitch.addTarget(self, action: #selector(btnSwitchTapped), for: .touchUpInside)
        btnBack.addTarget(self, action: #selector(btnBackTapped), for: .touchUpInside)
    }
}

// MARK:- BUTTON ACTIONS
extension OpenSecureAccountVC{
    
    @objc func btnNxtStepTapped(sender: UIButton){
        if isConditionsAccptd{
            let vc = PersonalInfoVC.instantiateFromAppStoryboard(appStoryboard: .Kyc)
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            self.vwTermsAndCond.shake()
            CommonFunctions.toster(L10n.Please_accpt_terms_and_conditions.description)
        }
    }
    
    @objc func btnSwitchTapped(sender: UIButton){
        isConditionsAccptd.toggle()
        isConditionsAccptd ? sender.setImage(Asset.toogle_on.image(), for: .normal) : sender.setImage(Asset.toogle_off.image(), for: .normal)
    }
    
    @objc func btnBackTapped(sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}


