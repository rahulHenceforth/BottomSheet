//
//  CustomMarkerView.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 14/09/21.
//

import UIKit
import Charts

class CustomMarkerView: MarkerView {
    
    //MARK:- IB OUTLETS
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var markerView: UIView!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblDate: UILabel!
//    @IBOutlet weak var markerStick: UIView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initUI()
    }
    
    private func initUI() {
        
        Bundle.main.loadNibNamed("CustomMarkerView", owner: self, options: nil)
        addSubview(contentView)
        
        markerView.layer.cornerRadius = 24
        markerView.backgroundColor = .ethereumColor
        contentView.backgroundColor = .clear
        
        CommmonUI.initialLbl(lbl: lblPrice, text: "dfgdfg", textColor: .appWhiteColor, font: .MontserratBold(Size.Large.sizeValue()))
        CommmonUI.initialLbl(lbl: lblDate, text: "fdgdfgdf", textColor: .appWhiteColor, font: .MontserratMedium(Size.Small.sizeValue()))
        
//        self.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        self.offset = CGPoint(x: -(self.frame.width + 66), y: -self.frame.height - 28.0)
    }
    
}

// MARK:- SOURCE OF THIS CLASS-
//https://medium.com/geekculture/swift-ios-charts-tutorial-highlight-selected-value-with-a-custom-marker-30ccbf92aa1b
