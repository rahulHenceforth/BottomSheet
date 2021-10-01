//
//  ProfileTVC.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 13/09/21.
//

import UIKit

class ProfileTVC: UITableViewCell {

    //MARK:- IB OUTLETS
    @IBOutlet weak var lblTxt: UILabel!
    @IBOutlet weak var vwBg: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        CommmonUI.initialLbl(lbl: lblTxt, textColor: .primaryTextColor, font: .MontserratBold(Size.Large.sizeValue()))
        vwBg.layer.cornerRadius = 20
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//MARK:- CONFIGURE CELL WITH DATA
extension ProfileTVC{
    func configure(with data: String, isLast: Bool){
        lblTxt.text = data
        if isLast{
            lblTxt.textColor = .appWhiteColor
            vwBg.backgroundColor = .primaryTextColor
        }else{
            lblTxt.textColor = .primaryTextColor
            vwBg.backgroundColor = UIColor(netHex: 0xEDF1F9FF)
        }
    }
}

