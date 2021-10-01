//
//  AppBlueButton.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 25/08/21.
//

import Foundation
import UIKit

class AppBlueButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 20
        self.titleLabel?.font = UIFont.MontserratBold(Size.Medium.sizeValue())
        self.setTitleColor(.appWhiteColor, for: .normal)
        
        DispatchQueue.main.async {
            self.applyGradient(colors: [UIColor.themeColor.cgColor, UIColor.GradientSecondColor.cgColor], isHorizontal: true)
        }
        
    }
    
    var originalButtonText: String?
    var originalButtonImage: UIImage?
    var activityIndicator: UIActivityIndicatorView!
    
    func showLoading() {
        originalButtonText = self.titleLabel?.text
        originalButtonImage = self.currentImage
        self.setTitle("", for: .normal)
        self.setImage(nil, for: .normal)
        
        if (activityIndicator == nil) {
            activityIndicator = createActivityIndicator()
        }
        
        showSpinning()
    }
    
    func hideLoading() {
        self.setTitle(originalButtonText, for: .normal)
        self.setImage(originalButtonImage, for: .normal)
        if activityIndicator != nil{
            activityIndicator.stopAnimating()
        }
    }
    
    private func createActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .white
        return activityIndicator
    }
    
    private func showSpinning() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activityIndicator)
        centerActivityIndicatorInButton()
        activityIndicator.startAnimating()
    }
    
    private func centerActivityIndicatorInButton() {
        let xCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: activityIndicator, attribute: .centerX, multiplier: 1, constant: 0)
        self.addConstraint(xCenterConstraint)
        
        let yCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: activityIndicator, attribute: .centerY, multiplier: 1, constant: 0)
        self.addConstraint(yCenterConstraint)
    }
}


