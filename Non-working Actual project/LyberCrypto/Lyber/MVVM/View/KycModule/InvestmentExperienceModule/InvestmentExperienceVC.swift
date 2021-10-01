//
//  InvestmentExperienceVC.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 07/09/21.
//

import UIKit

class InvestmentExperienceVC: UIViewController {

    //MARK:- IB OUTLETS
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblVwHead1: UILabel!
    @IBOutlet weak var lblVwDesc1: UILabel!
    @IBOutlet weak var lblVwHead2: UILabel!
    @IBOutlet weak var lblVwDesc2: UILabel!
    @IBOutlet weak var lblVwHead3: UILabel!
    @IBOutlet weak var lblVwDesc3: UILabel!
    @IBOutlet weak var lblVwHead4: UILabel!
    @IBOutlet weak var lblVwDesc4: UILabel!
    @IBOutlet weak var btnNxtStep: AppBlueButton!
    @IBOutlet weak var viewMain2: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialSetUp()
    }
    
}

//MARK:- INITIAL SET UP
extension InvestmentExperienceVC{
    func initialSetUp(){
        CommmonUI.initialLbl(lbl: lblHeader, text: L10n.Investment_Experience.description, textColor: .primaryTextColor, font: .MontserratBold(Size.XXXLarge.sizeValue()))
        CommmonUI.initialLbl(lbl: lblDescription, text: L10n.Investment_Experience_Desc.description, textColor: .DescTextColor, font: .MontserratMedium(Size.Medium.sizeValue()))
        CommmonUI.initialLbl(lbl: lblVwHead1, text: L10n.Investement_Expereince_SubTitle1.description, textColor: .secondaryTextColor, font: .MontserratMedium(Size.Medium.sizeValue()))
        CommmonUI.initialLbl(lbl: lblVwHead2, text: L10n.Investement_Expereince_SubTitle2.description, textColor: .secondaryTextColor, font: .MontserratMedium(Size.Medium.sizeValue()))
        CommmonUI.initialLbl(lbl: lblVwHead3, text: L10n.Investement_Expereince_SubTitle3.description, textColor: .secondaryTextColor, font: .MontserratMedium(Size.Medium.sizeValue()))
        CommmonUI.initialLbl(lbl: lblVwHead4, text: L10n.Investement_Expereince_SubTitle4.description, textColor: .secondaryTextColor, font: .MontserratMedium(Size.Medium.sizeValue()))
        CommmonUI.initialLbl(lbl: lblVwDesc1, text: L10n.Please_Select.description, textColor: .primaryTextColor, font: .MontserratMedium(Size.Large.sizeValue()))
        CommmonUI.initialLbl(lbl: lblVwDesc2, text: L10n.Please_Select.description, textColor: .primaryTextColor, font: .MontserratMedium(Size.Large.sizeValue()))
        CommmonUI.initialLbl(lbl: lblVwDesc3, text: L10n.Please_Select.description, textColor: .primaryTextColor, font: .MontserratMedium(Size.Large.sizeValue()))
        CommmonUI.initialLbl(lbl: lblVwDesc4, text: L10n.Please_Select.description, textColor: .primaryTextColor, font: .MontserratMedium(Size.Large.sizeValue()))
        
        
        DispatchQueue.main.async {
            self.viewMain.roundCorners([.topLeft, .topRight], radius: 36)
            self.viewMain2.roundCorners([.topLeft, .topRight], radius: 36)
        }
        
        btnNxtStep.setTitle(L10n.Next_Step.description, for: .normal)
        btnNxtStep.addTarget(self, action: #selector(btnNxtStepTapped), for: .touchUpInside)
        btnBack.addTarget(self, action: #selector(btnBackTapped(_:)), for: .touchUpInside)
    }
}

// MARK:- BUTTON ACTIONS
extension InvestmentExperienceVC{
    
    @objc func btnNxtStepTapped(sender: UIButton){
        let vc = DoocumentVerificationVC.instantiateFromAppStoryboard(appStoryboard: .Kyc)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func btnBackTapped(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}


