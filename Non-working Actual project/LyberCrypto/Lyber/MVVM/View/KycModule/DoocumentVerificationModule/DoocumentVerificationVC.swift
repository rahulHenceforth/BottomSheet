//
//  DoocumentVerificationVC.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 07/09/21.
//

import UIKit

class DoocumentVerificationVC: UIViewController {

    //MARK:- IB OUTLETS
    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var btnPassPort: UIButton!
    @IBOutlet weak var btnDl: UIButton!
    @IBOutlet weak var btnIdCard: UIButton!
    @IBOutlet weak var btnResidencePermit: UIButton!
    @IBOutlet var vws: [UIView]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialSetUp()
    }
}

//MARK:- INITIAL SET UP
extension DoocumentVerificationVC{
    func initialSetUp(){
        CommmonUI.initialLbl(lbl: lblHeading, text: L10n.Document_Verification.description, textColor: .primaryTextColor, font: .MontserratBold(Size.XXXLarge.sizeValue()))
        CommmonUI.initialLbl(lbl: lblDesc, text: L10n.Document_Verification_Desc.description, textColor: .DescTextColor, font: .MontserratMedium(Size.Medium.sizeValue()))
        CommmonUI.unBorderdBtn(btn: btnPassPort, title: L10n.Passport.description, titlecolor: .primaryTextColor, font: .MontserratBold(Size.Large.sizeValue()))
        CommmonUI.unBorderdBtn(btn: btnDl, title: L10n.Driving_License.description, titlecolor: .primaryTextColor, font: .MontserratBold(Size.Large.sizeValue()))
        CommmonUI.unBorderdBtn(btn: btnIdCard, title: L10n.Identity_Card.description, titlecolor: .primaryTextColor, font: .MontserratBold(Size.Large.sizeValue()))
        CommmonUI.unBorderdBtn(btn: btnResidencePermit, title: L10n.Residence_Permit.description, titlecolor: .primaryTextColor, font: .MontserratBold(Size.Large.sizeValue()))
        
        DispatchQueue.main.async {
            self.viewMain.roundCorners([.topLeft, .topRight], radius: 36)
        }
        
        for vw in vws{
            vw.layer.cornerRadius = 20
        }
        
        btnPassPort.addTarget(self, action: #selector(optionSelecter), for: .touchUpInside)
        btnDl.addTarget(self, action: #selector(optionSelecter), for: .touchUpInside)
        btnIdCard.addTarget(self, action: #selector(optionSelecter), for: .touchUpInside)
        btnResidencePermit.addTarget(self, action: #selector(optionSelecter), for: .touchUpInside)
    }
}

// MARK:- BUTTON ACTIONS
extension DoocumentVerificationVC{
    
    @objc func optionSelecter(sender: UIButton){
        switch sender.tag {
        case 0:
            let vc = ScanDocumentVC.instantiateFromAppStoryboard(appStoryboard: .Kyc)
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = ScanDocumentVC.instantiateFromAppStoryboard(appStoryboard: .Kyc)
            self.navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = ScanDocumentVC.instantiateFromAppStoryboard(appStoryboard: .Kyc)
            self.navigationController?.pushViewController(vc, animated: true)
        case 3:
            let vc = ScanDocumentVC.instantiateFromAppStoryboard(appStoryboard: .Kyc)
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            return
        }
    }
}

