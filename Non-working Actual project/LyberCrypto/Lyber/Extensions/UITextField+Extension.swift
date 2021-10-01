//
//  Extension+UITextField.swift
//  NewApp
//
//  Created by Think Recycling Pvt Ltd on 27/08/19.
//  Copyright © 2019 Think Recycling Pvt Ltd. All rights reserved.
//

import UIKit

extension UITextField {
    
    func openView(_ isLeft: Bool, img: UIImageView){
        if isLeft{
            self.leftViewMode = .always
            self.leftView = img
        }else{
            self.rightViewMode = .always
            self.rightView = img
        }
    }
    
    func openView(_ isLeft: Bool, btn: UIButton){
        if isLeft{
            self.leftViewMode = .always
            self.leftView = btn
        }else{
            self.rightViewMode = .always
            self.rightView = btn
        }
    }
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    func customeFont (fontName name : String, maximumFontValue size: CGFloat){
        self.adjustsFontForContentSizeCategory = true
        self.font = CommonFunctions.getFont(fontName: name, maximumFontValue: size)
    }
    
    // set text field with placeholder text and color
    func setPlaceHolderColor(_ setColor: UIColor, placeholderText : String){
        self.tintColor = setColor
        self.attributedPlaceholder = NSAttributedString(string: placeholderText,
                                                        attributes: [NSAttributedString.Key.foregroundColor: setColor])
    }
    
    // set text field with placeholder text, color & font
    func setPlaceHolderColor(_ setColor: UIColor, placeholderText : String, placeholderFont : UIFont){
        self.tintColor = setColor
        self.attributedPlaceholder = NSAttributedString(string: placeholderText,
                                                        attributes: [NSAttributedString.Key.foregroundColor: setColor, NSAttributedString.Key.font: placeholderFont])
    }
    
    
    
    func disableAutoFill() {
        if #available(iOS 12, *) {
            textContentType = .oneTimeCode
        } else {
            textContentType = .init(rawValue: "")
        }
    }
}


class TextFieldPadding: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

extension UITextField {
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        let userdef = UserDefaults.standard
        let langArray = userdef.object(forKey: "AppleLanguages") as! NSArray
        let current = langArray.firstObject as! String
        
        if current == "ar" {
            if textAlignment == .natural {
                self.textAlignment = .right
            }
        }
    }
}
