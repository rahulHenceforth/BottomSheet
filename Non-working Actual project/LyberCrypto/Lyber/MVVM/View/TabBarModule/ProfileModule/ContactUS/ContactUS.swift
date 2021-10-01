//
//  ContactUS.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 13/09/21.
//

import UIKit
import SkyFloatingLabelTextField
import GrowingTextView

class ContactUS: UIViewController {
    
    //MARK:- IB OUTLETS
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var tfSubject: SkyFloatingLabelTextField!
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var vwMainTopCons: NSLayoutConstraint!
    @IBOutlet weak var scrlvw: UIScrollView!
    @IBOutlet weak var txtVw: GrowingTextView!
    @IBOutlet weak var lblTxtVw: UILabel!
    @IBOutlet weak var btnSendMsg: AppBlueButton!
    @IBOutlet weak var lblTopCons: NSLayoutConstraint!
    @IBOutlet weak var vwLineBelowTxt: UIView!
    
    lazy var contactUsVM = ContactUsVM()
    var isError = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetUp()
    }
}

//MARK:- INITIAL SET UP
extension ContactUS{
    func initialSetUp(){
        
        CommmonUI.initialLbl(lbl: lblHeader, text: L10n.Contact_Us.description, textColor: .primaryTextColor, font: .MontserratBold(Size.XXXLarge.sizeValue()))
        CommmonUI.initialLbl(lbl: lblTxtVw, text: L10n.Message.description, textColor: .secondaryTextColor, font: .MontserratMedium(Size.Large.sizeValue()))
        CommmonUI.normalTF(tf: tfSubject, img: nil, placeHolder: L10n.Subject.description)
        
        DispatchQueue.main.async {
            self.viewMain.roundCorners([.topLeft, .topRight], radius: 36)
        }
        
        self.btnSendMsg.setTitle(L10n.Send_Message.description, for: .normal)
        
        txtVw.tintColor = UIColor.primaryTextColor
        vwLineBelowTxt.backgroundColor = UIColor.secondaryTextColor.withAlphaComponent(0.24)
        
        tfSubject.addDoneOnKeyboardWithTarget(self, action:  #selector(doneButtonClicked))
        txtVw.addDoneOnKeyboardWithTarget(self, action: #selector(doneButtonClicked))
        
        btnBack.addTarget(self, action: #selector(btnBackTapped), for: .touchUpInside)
        btnSendMsg.addTarget(self, action: #selector(btnSendMsgTapped), for: .touchUpInside)
    }
}

//MARK: TEXTFLD DELEGATE
extension ContactUS: UITextFieldDelegate, UITextViewDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case tfSubject:
            txtVw.becomeFirstResponder()
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
        case tfSubject:
            maxLength = 70
            CommmonUI.normalTF(tf: tfSubject, img: nil, placeHolder: L10n.Subject.description)
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if self.vwMainTopCons.constant != 0{
            self.scrlvw.isScrollEnabled = false
            self.vwMainTopCons.constant = 0
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if self.vwMainTopCons.constant != 0{
            self.scrlvw.isScrollEnabled = false
            self.vwMainTopCons.constant = 0
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
        if !self.isError{
            vwLineBelowTxt.backgroundColor = UIColor.themeColor
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        vwLineBelowTxt.backgroundColor = UIColor.secondaryTextColor.withAlphaComponent(0.24)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentString: NSString = textView.text! as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: text) as NSString
        
        if newString.length == 0{
            self.lblTopCons.constant = 10
            vwLineBelowTxt.backgroundColor = UIColor.secondaryTextColor.withAlphaComponent(0.24)
            self.lblTxtVw.text = L10n.Message.description
            UIView.animate(withDuration: 0.2) {
                self.view.layoutIfNeeded()
            }
        }else {
            if self.lblTopCons.constant != -16{
                self.lblTopCons.constant = -16
                self.lblTxtVw.text = self.lblTxtVw.text?.uppercased()
                UIView.animate(withDuration: 0.2) {
                    self.view.layoutIfNeeded()
                }
            }
        }
        self.isError = false
        self.txtVw.tintColor = .primaryTextColor
        self.lblTxtVw.textColor = .secondaryTextColor
        self.vwLineBelowTxt.backgroundColor = UIColor.themeColor
        return true
    }
}


// MARK:- BUTTON ACTIONS
extension ContactUS{
    
    @objc func doneButtonClicked(_ sender: Any) {
        self.closeView()
    }
    
    @objc func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func btnSendMsgTapped(_ sender: Any) {
        let request = contactUsVM.validate(with: ContactUsRequest(subject: tfSubject.text, msg: txtVw.text))
        
        if let error = request.errorMsg{
            CommonFunctions.toster(error)
            
            switch request.errorOnField {
            case .subject:
                CommmonUI.errorTF(tf: tfSubject, img: nil, placeHolder: L10n.Subject.description)
            case .msg:
                txtVw.tintColor = .red
                vwLineBelowTxt.backgroundColor = .red
                lblTxtVw.textColor = .red
                txtVw.shake()
                vwLineBelowTxt.shake()
                lblTxtVw.shake()
                isError = true
            default:
                return
            }
            
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
}


//MARK:- EXTERNAL FUNCTIONS
extension ContactUS{
    func closeView(){
        self.scrlvw.isScrollEnabled = true
        self.vwMainTopCons.constant = 217
        self.view.endEditing(true)
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
        
    }
}

