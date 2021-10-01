//
//  VerifyNumberVC.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 07/09/21.
//

import UIKit

class VerifyNumberVC: UIViewController {
    
    //MARK:- IB OUTLETS
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var lblHeaderDesc: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnStack: UIStackView!
    @IBOutlet var tfCollection: [UITextField]!
    @IBOutlet var btnKeys: [UIButton]!
    @IBOutlet weak var btnSubmit: AppBlueButton!
    @IBOutlet var vwCollection: [UIView]!
    @IBOutlet weak var stackTf: UIStackView!
    
    // MARK:- VARIABLES
    var passCodeLength = 4
    var passcode = [Int]()
    var isFromEditProfile = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        initialSetUp()
    }
}

//MARK:- INITIAL SET UP
extension VerifyNumberVC{
    func initialSetUp(){
        CommmonUI.initialLbl(lbl: lblHeader, text: L10n.Verify_Number.description, textColor: .primaryTextColor, font: .MontserratBold(Size.XXXLarge.sizeValue()))
        CommmonUI.initialLbl(lbl: lblHeaderDesc, text: L10n.Verify_Number_Desc.description, textColor: .DescTextColor, font: .MontserratMedium(Size.Medium.sizeValue()))
        
        btnSubmit.setTitle(L10n.SUBMIT_CAPS.description, for: .normal)
        btnBack.addTarget(self, action: #selector(btnBackTapped) , for: .touchUpInside)
        btnSubmit.addTarget(self, action: #selector(btnSubmitTapped) , for: .touchUpInside)
        
        self.setKeys()
        self.setRoundVws()
    }
}

// MARK:- BUTTON ACTIONS
extension VerifyNumberVC{
    
    @objc func btnBackTapped(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func btnSubmitTapped(_ sender: UIButton){
        if self.passcode.count != 4{
            self.setErrorRoundVws()
            self.stackTf.shake()
            CommonFunctions.toster(k.ErrorMsgs.PleaseEnterOtp)
            return
        }
        if isFromEditProfile{
            let vc = ProfileVerificationVC.instantiateFromAppStoryboard(appStoryboard: .Main)
            vc.screenType = .Profile
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = LinkBankVC.instantiateFromAppStoryboard(appStoryboard: .Main)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func btnKeyTapped(_ sender: UIButton){
        switch sender.tag {
        case 1,2,3,4,5,6,7,8,9:
            if passcode.count < self.passCodeLength{
                self.passcode.append(sender.tag)
                self.tfCollection[self.passcode.count - 1].text = "\(sender.tag)"
                self.tfCollection[self.passcode.count].borderColor = .themeColor
                self.tfCollection[self.passcode.count-1].borderColor = .TfBorderColor
            }
        case 10:
            if passcode.count < self.passCodeLength{
                self.passcode.append(0)
                self.tfCollection[self.passcode.count - 1].text = "0"
                self.tfCollection[self.passcode.count].borderColor = .themeColor
                self.tfCollection[self.passcode.count-1].borderColor = .TfBorderColor
            }
        case 11:
            if !passcode.isEmpty{
                self.tfCollection[self.passcode.count - 1].text = nil
                self.tfCollection[self.passcode.count].borderColor = .TfBorderColor
                self.tfCollection[self.passcode.count-1].borderColor = .themeColor
                self.passcode.removeLast()
                print(self.passcode)
            }
            
        default:
            return
        }
        
        setNormalRoundVws()
        sender.backgroundColor = .white
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            sender.backgroundColor = .clear
        }
        
//        if self.passcode.count == 4{
//            let vc = AddBankVC.instantiateFromAppStoryboard(appStoryboard: .Main)
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
        
    }
}

//MARK:- EXTERNAL FUNCTIONS
extension VerifyNumberVC{
    func setRoundVws(){
        for (kNum, tf) in tfCollection.enumerated(){
            if passCodeLength > kNum{
                vwCollection[kNum].isHidden = false
            }else{
                vwCollection[kNum].isHidden = true
            }
            if kNum == 0{
                tf.layer.borderColor = UIColor.themeColor.cgColor
            }else{
                tf.layer.borderColor = UIColor.TfBorderColor.cgColor
            }
            
            tf.textAlignment = .center
            tf.isUserInteractionEnabled = false
            tf.textColor = .themeColor
            tf.font = .MontserratMedium(Size.max.sizeValue())
            tf.backgroundColor = .appWhiteColor
            tf.layer.cornerRadius = 16
            tf.layer.borderWidth = 1
        }
    }
    
    func setErrorRoundVws(){
        for tf in tfCollection{
            tf.textColor = .red
            tf.layer.borderColor = UIColor.red.cgColor
        }
    }
    
    func setNormalRoundVws(){
        for (kNum, tf) in tfCollection.enumerated(){
            if kNum == self.passcode.count-1{
                tf.layer.borderColor = UIColor.themeColor.cgColor
            }else{
                tf.layer.borderColor = UIColor.TfBorderColor.cgColor
            }
            tf.textColor = .themeColor
        }
    }
    
    func setKeys(){
        for (kNum, btn) in btnKeys.enumerated(){
            if kNum == 9{
                btn.setTitle("0", for: .normal)
            }else if kNum == 10{
                btn.setTitle(nil, for: .normal)
            }else{
                btn.setTitle("\(kNum + 1)", for: .normal)
            }
            btn.clipsToBounds = true
            btn.layer.cornerRadius = btn.frame.size.height / 2
            btn.titleLabel?.font = .MontserratBold(Size.XXXLarge.sizeValue())
            btn.setTitleColor(.primaryTextColor, for: .normal)
            btn.addTarget(self, action: #selector(btnKeyTapped) , for: .touchUpInside)
            btn.tag = kNum+1
        }
    }
}
