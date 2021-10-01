//
//  ProfileVerificationVC.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 07/09/21.
//

import UIKit

enum ScreenType {
    case Welcome
    case Verification
    case Profile
}

class ProfileVerificationVC: UIViewController {
    
    //MARK:- IB OUTLETS
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var lblSubHeader: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var imgVw: UIImageView!
    @IBOutlet weak var btnStartVerification: AppBlueButton!
    @IBOutlet weak var btnVerificationInProgress: UIButton!
    
    
    // MARK:- VARIABLES
    var screenType: ScreenType = .Welcome
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetUp()
    }
}

//MARK:- INITIAL SET UP
extension ProfileVerificationVC{
    func initialSetUp(){
        
        CommmonUI.initialLbl(lbl: lblHeader, text: L10n.Welcome_to_Lyber.description, textColor: .primaryTextColor, font: .MontserratBold(Size.XXXLarge.sizeValue()))
        CommmonUI.initialLbl(lbl: lblSubHeader, text: L10n.Welcome_to_lyber_desc.description, textColor: .DescTextColor, font: .MontserratMedium(Size.Medium.sizeValue()))
        
        btnStartVerification.addTarget(self, action: #selector(btnStartVerificationTapped), for: .touchUpInside)
        btnBack.addTarget(self, action: #selector(btnBackTapped), for: .touchUpInside)
        
        if screenType == .Verification{
            btnBack.isHidden = true
            self.imgVw.image = Asset.verification_progress.image()
            btnStartVerification.isHidden = true
            btnVerificationInProgress.isHidden = false
            btnVerificationInProgress.setTitleColor(.primaryTextColor, for: .normal)
            self.lblHeader.text = L10n.Welcome_to_Lyber.description
            self.lblSubHeader.attributedText = CommonFunctions.sendAttText([L10n.Welcome_to_lyber_desc2.description, L10n.Welcome_to_lyber_desc3.description], fonts: [.MontserratMedium(Size.Medium.sizeValue()), .MontserratSemiBold(Size.Medium.sizeValue())], color: [.primaryTextColor, .themeColor], alingment: .center)
            btnVerificationInProgress.setTitle(L10n.Verification_in_progress.description, for: .normal)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                let vc = TabBarVC.instantiateFromAppStoryboard(appStoryboard: .Tabbar)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }else if screenType == .Profile{
            btnBack.isHidden = false
            btnStartVerification.setTitle(L10n.BACK_TO_PROFILE.description, for: .normal)
            self.imgVw.image = Asset.well_done.image()
            btnStartVerification.isHidden = false
            btnVerificationInProgress.isHidden = true
            self.lblHeader.text = L10n.Well_Done.description
            self.lblSubHeader.attributedText = CommonFunctions.sendAttText([L10n.Profile_Change_Desc.description], fonts: [.MontserratMedium(Size.Medium.sizeValue()),], color: [.primaryTextColor], alingment: .center)
            btnVerificationInProgress.setTitle(L10n.Verification_in_progress.description, for: .normal)
        }else{
            btnBack.isHidden = true
            btnStartVerification.setTitle(L10n.Start_Profile_Verification.description, for: .normal)
            btnStartVerification.isHidden = false
            btnVerificationInProgress.isHidden = true
            self.lblHeader.text = L10n.Welcome_to_Lyber.description
            self.lblSubHeader.attributedText = CommonFunctions.sendAttText([L10n.Welcome_to_lyber_desc.description], fonts: [.MontserratMedium(Size.Medium.sizeValue())], color: [.primaryTextColor], alingment: .center)
            btnVerificationInProgress.setTitle(L10n.Verification_in_progress.description, for: .normal)
        }
    }
}

// MARK:- BUTTON ACTIONS
extension ProfileVerificationVC{
    
    @objc func btnStartVerificationTapped(sender: UIButton){
        if screenType == .Welcome{
            let vc = OpenSecureAccountVC.instantiateFromAppStoryboard(appStoryboard: .Kyc)
            self.navigationController?.pushViewController(vc, animated: true)
        }else if screenType == .Profile{
            self.navigationController?.popToViewController(ofClass: TabBarVC.self)
        }
    }
    
    @objc func btnBackTapped(sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}


