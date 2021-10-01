//
//  ChangePassVC.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 13/09/21.
//

import UIKit
import SkyFloatingLabelTextField

class ChangePassVC: UIViewController {
    
    //MARK:- IB OUTLETS
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var vwMain: UIView!
    @IBOutlet weak var tfCurrentPass: SkyFloatingLabelTextField!
    @IBOutlet weak var tfNewPass: SkyFloatingLabelTextField!
    @IBOutlet weak var btnResetPass: AppBlueButton!
    
    var btneye: UIButton!
    var btneye1: UIButton!
    var changePassVM =  ChangePassVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetUp()
    }
}

//MARK:- INITIAL SET UP
extension ChangePassVC{
    func initialSetUp(){
        
        btneye = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        btneye1 = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        
        btneye.tag = 0
        btneye1.tag = 1
        
        CommmonUI.initialLbl(lbl: lblHeader, text: L10n.Change_Password.description, textColor: .primaryTextColor, font: .MontserratBold(Size.XXXLarge.sizeValue()))
        CommmonUI.normalTFBtn(tf: tfCurrentPass, btn: btneye, placeHolder: L10n.Current_password.description)
        CommmonUI.normalTFBtn(tf: tfNewPass, btn: btneye1, placeHolder: L10n.New_password.description)
        
        DispatchQueue.main.async {
            self.vwMain.roundCorners([.topLeft, .topRight], radius: 36)
        }
        
        self.btnResetPass.setTitle(L10n.Reset_Password.description, for: .normal)
        
        btneye.addTarget(self, action: #selector(btnEyeTapped(_:)) , for: .touchUpInside)
        btneye1.addTarget(self, action: #selector(btnEyeTapped(_:)) , for: .touchUpInside)
        btnResetPass.addTarget(self, action: #selector(btnResetPassTapped(_:)) , for: .touchUpInside)
        btnBack.addTarget(self, action: #selector(btnBackTapped(_:)) , for: .touchUpInside)
        
    }
}

//MARK: TEXTFLD DELEGATE
extension ChangePassVC: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case tfCurrentPass:
            tfNewPass.becomeFirstResponder()
        case tfNewPass:
            tfNewPass.resignFirstResponder()
        default:
            break
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentString: NSString = textField.text! as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        var maxLength = 120
        
        switch textField {
        case tfCurrentPass:
            maxLength = 18
            CommmonUI.normalTFBtn(tf: tfCurrentPass, btn: btneye, placeHolder: L10n.Current_password.description)
        case tfNewPass:
            maxLength = 18
            CommmonUI.normalTFBtn(tf: tfNewPass, btn: btneye1, placeHolder: L10n.New_password.description)
        default:
            break
        }
        
        if let char = string.cString(using: String.Encoding.utf8) {                         //TO ENABLE BCKSPACE EVEN IF NUMBERS ARE MORE THAN fixed CHAR LIMIT
            let isBackSpace = strcmp(char, "\\b")
            if (isBackSpace == -92) {
                return true
            }
        }
        
        return newString.length <= maxLength
    }
}


// MARK:- BUTTON ACTIONS
extension ChangePassVC{
    
    @objc func btnResetPassTapped(_ sender: UIButton){
        let request = changePassVM.validate(with: ChangePassRequest(oldPass: tfCurrentPass.text, newPass: tfNewPass.text))
        
        if let error = request.errorMsg{
            CommonFunctions.toster(error)
            
            switch request.errorOnField {
            case .oldPass:
                CommmonUI.normalTFBtn(tf: tfCurrentPass, btn: btneye, placeHolder: L10n.Current_password.description)
            case .newPass:
                CommmonUI.normalTFBtn(tf: tfNewPass, btn: btneye1, placeHolder: L10n.New_password.description)
            default:
                return
            }
            
        }else{
            let vc = PassCodeverificationVC.instantiateFromAppStoryboard(appStoryboard: .Main)
            vc.isFromProfile = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func btnBackTapped(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func btnEyeTapped(_ sender: UIButton){
        let tf = sender.tag == 0 ? self.tfCurrentPass : self.tfNewPass
        tf!.isSecureTextEntry = !tf!.isSecureTextEntry
        let img1 = Asset.visibility_off.image().imageWithInsets(insets: UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 20))?.withRenderingMode(.alwaysTemplate)
        let img2 = Asset.visibility.image().imageWithInsets(insets: UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 20))?.withRenderingMode(.alwaysTemplate)
        sender.setImage( tf!.isSecureTextEntry ? img1 : img2, for: .normal)
    }
    
}
