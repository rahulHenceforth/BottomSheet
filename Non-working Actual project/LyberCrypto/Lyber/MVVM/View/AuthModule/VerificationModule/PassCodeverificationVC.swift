//
//  PassCodeverificationVC.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 01/09/21.
//

import UIKit

class PassCodeverificationVC: UIViewController {
    
    //MARK:- IB OUTLETS
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var lblHeadeDesc: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet var vwRound: [UIView]!
    @IBOutlet var btnKeys: [UIButton]!
    
    // MARK:- VARIABLES
    var passCodeLength = 4
    var passcode: [[Int]] = [[],[],[]]
    var screenStatus = 0
    var isFromProfile = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetUp()
    }
    
}

//MARK:- INITIAL SET UP
extension PassCodeverificationVC{
    func initialSetUp(){
        CommmonUI.initialLbl(lbl: lblHeader, text: isFromProfile ? L10n.Current_Pin.description : L10n.Verification.description, textColor: .primaryTextColor, font: .MontserratBold(Size.XXXLarge.sizeValue()))
        CommmonUI.initialLbl(lbl: lblHeadeDesc, text: L10n.Verification_Desc.description, textColor: .DescTextColor, font: .MontserratMedium(Size.Medium.sizeValue()))
        
        btnBack.addTarget(self, action: #selector(btnBackTapped) , for: .touchUpInside)
        
        self.setKeys()
        self.setRoundVws()
    }
}

// MARK:- BUTTON ACTIONS
extension PassCodeverificationVC{
    
    @objc func btnBackTapped(_ sender: UIButton){
        //        if self.screenStatus == 0{
        //            self.navigationController?.popViewController(animated: true)
        //        }else if self.screenStatus == 1{
        //            self.lblHeader.text = L10n.Current_Pin.description
        //            self.passcode[self.screenStatus].removeAll()
        //            self.screenStatus -= 1
        //            self.passcode[self.screenStatus].removeAll()
        //            self.setRoundVws()
        //        }else if screenStatus == 2{
        //            self.lblHeader.text = L10n.New_Pin.description
        //            self.passcode[self.screenStatus].removeAll()
        //            self.screenStatus -= 1
        //            self.passcode[self.screenStatus].removeAll()
        //            self.setRoundVws()
        //        }
        
        switch self.screenStatus {
        case 0:
            self.navigationController?.popViewController(animated: true)
        case 1,2:
            self.lblHeader.text = self.screenStatus == 1 ? L10n.Current_Pin.description : L10n.New_Pin.description
            self.passcode[self.screenStatus].removeAll()
            self.screenStatus -= 1
            self.passcode[self.screenStatus].removeAll()
            self.setRoundVws()
        default:
            return
        }
    }
    
    @objc func btnKeyTapped(_ sender: UIButton){
        switch sender.tag {
        case 1,2,3,4,5,6,7,8,9:
            if passcode[screenStatus].count < self.passCodeLength{
                self.passcode[screenStatus].append(sender.tag)
                self.vwRound[passcode[screenStatus].count - 1].backgroundColor = .AppGreenColor
            }
        case 10:
            if passcode[screenStatus].count < self.passCodeLength{
                self.passcode[screenStatus].append(0)
                self.vwRound[passcode[screenStatus].count - 1].backgroundColor = .AppGreenColor
            }
        case 11:
            if !passcode[screenStatus].isEmpty{
                self.vwRound[self.passcode[screenStatus].count-1].backgroundColor = .secondaryTextColor
                self.passcode[screenStatus].removeLast()
                print(self.passcode[screenStatus])
                
                if self.passcode[screenStatus].count == 0 && self.screenStatus != 0{
                    self.screenStatus -= 1
                }
            }
            
        default:
            return
        }
        
        sender.backgroundColor = .white
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            sender.backgroundColor = .clear
        }
        
        chckValidations()
    }
}

//MARK:- EXTERNAL FUNCTIONS
extension PassCodeverificationVC{
    func setRoundVws(){
        for (kNum, vw) in vwRound.enumerated(){
            if passCodeLength > kNum{
                vwRound[kNum].isHidden = false
            }else{
                vwRound[kNum].isHidden = true
            }
            vw.backgroundColor = .secondaryTextColor
            vw.layer.cornerRadius = vw.bounds.height / 2
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
    
    func chckValidations(){
        if self.passcode[screenStatus].count == 4 && !isFromProfile{
            let vc = TabBarVC.instantiateFromAppStoryboard(appStoryboard: .Tabbar)
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            if self.passcode[screenStatus].count == 4{
                self.screenStatus += 1
                self.setRoundVws()
            }
            
            if passcode[2].count == 4{
                print(self.passcode)
                if passcode[1] != passcode[2]{
                    self.screenStatus = 1
                    self.lblHeader.text = L10n.New_Pin.description
                    self.passcode[1].removeAll()
                    self.passcode[2].removeAll()
                    CommonFunctions.toster(k.ErrorMsgs.Passcode_didnt_matched)
                    return
                }
                self.navigationController?.popToViewController(ofClass: TabBarVC.self)
            }
            
            
            if isFromProfile{
                switch self.screenStatus {
                case 0:
                    self.lblHeader.text = L10n.Current_Pin.description
                case 1:
                    self.lblHeader.text = L10n.New_Pin.description
                case 2:
                    self.lblHeader.text = L10n.Confirm_Pin.description
                default:
                    return
                }
            }
        }
    }
}
