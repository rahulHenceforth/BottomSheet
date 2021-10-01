//
//  EditProfileVC.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 14/09/21.
//

import UIKit
import SkyFloatingLabelTextField

class EditProfileVC: UIViewController {
    
    //MARK:- IB OUTLETS
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var vwProfileImg: UIView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var vwMain: UIView!
    @IBOutlet weak var tfName: SkyFloatingLabelTextField!
    @IBOutlet weak var btnSaveChanges: AppBlueButton!
    @IBOutlet weak var btnCamera: UIButton!
    
    lazy var editProfileVM = EditProfileVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetUp()
    }
}

//MARK:- INITIAL SET UP
extension EditProfileVC{
    func initialSetUp(){
        CommmonUI.initialLbl(lbl: lblHeader, text: L10n.Edit_Profile.description, textColor: .primaryTextColor, font: .MontserratBold(Size.XXXLarge.sizeValue()))
        
        imgProfile.layer.cornerRadius = imgProfile.bounds.height / 2
        vwProfileImg.layer.cornerRadius = vwProfileImg.bounds.height / 2
        btnCamera.layer.cornerRadius = btnCamera.bounds.height / 2
        
        btnCamera.backgroundColor = .primaryTextColor.withAlphaComponent(0.16)
        
        CommmonUI.normalTF(tf: tfName, img: nil, placeHolder: L10n.Full_Name.description)
        
        btnSaveChanges.setTitle(L10n.SAVE_CHANGES.description, for: .normal)
        
        DispatchQueue.main.async {
            self.vwMain.roundCorners([.topLeft, .topRight], radius: 30)
        }
        
        btnBack.addTarget(self, action: #selector(btnBackTapped), for: .touchUpInside)
        btnSaveChanges.addTarget(self, action: #selector(btnSaveChangesTapped), for: .touchUpInside)
        btnCamera.addTarget(self, action: #selector(btnCameraTapped), for: .touchUpInside)
    }
}


//MARK: TEXTFLD DELEGATE
extension EditProfileVC: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case tfName:
            self.view.endEditing(true)
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
        case tfName:
            maxLength = 15
            CommmonUI.normalTF(tf: tfName, img: nil, placeHolder: L10n.Full_Name.description)
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
extension EditProfileVC{
    
    @objc func btnBackTapped(sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func btnSaveChangesTapped(sender: UIButton){
        let request = editProfileVM.validate(with: EditProfileRequest(name: tfName.text))
        
        if let error = request.errorMsg{
            CommonFunctions.toster(error)
            CommmonUI.errorTF(tf: tfName, img: nil, placeHolder: L10n.Full_Name.description)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func btnCameraTapped(sender: UIButton){
        AttachmentHandler.shared.showAttachmentActionSheet(vc: self)
        AttachmentHandler.shared.imagePickedBlock = { (image) in
            self.imgProfile.image = image
        }
    }
}


