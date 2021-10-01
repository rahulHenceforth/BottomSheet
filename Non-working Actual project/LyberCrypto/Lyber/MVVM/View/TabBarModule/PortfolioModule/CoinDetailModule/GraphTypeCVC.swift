//
//  GraphTypeCVC.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 08/09/21.
//

import Foundation
import UIKit

class GraphTypeCVC: UICollectionViewCell {
    
    //MARK:- IB OUTLETS
    @IBOutlet weak var lblTitlee: UILabel!
    @IBOutlet weak var viewBg: UIView!
    
}

//MARK:- CONFIGURE CELL WITH DATA
extension GraphTypeCVC{
    func configure(with data: GraphTypeModal){
        CommmonUI.initialLbl(lbl: lblTitlee, text: data.title, textColor: .primaryTextColor, font: .MontserratMedium(Size.Small.sizeValue()))
        viewBg.layer.cornerRadius = 8
        if data.isSelected{
            lblTitlee.textColor = .primaryTextColor
            viewBg.backgroundColor = .WalkthroughBgColor
        }else{
            lblTitlee.textColor = .secondaryTextColor
            viewBg.backgroundColor = .clear
        }
    }
}
