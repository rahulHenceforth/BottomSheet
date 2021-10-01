//
//  FriendsTVC.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 10/09/21.
//

import UIKit

class FriendsTVC: UITableViewCell {

    //MARK:- IB OUTLETS
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var imgCoin: UIImageView!
    @IBOutlet weak var lblNam: UILabel!
    @IBOutlet weak var lblSymbol: UILabel!
    @IBOutlet weak var btnSend: AppBlueButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        CommmonUI.initialLbl(lbl: lblNam, text: L10n.Bitcoin.description, textColor: .primaryTextColor, font: .MontserratBold(Size.Large.sizeValue()))
        CommmonUI.initialLbl(lbl: lblSymbol, text: "1.116 BTC", textColor: .primaryTextColor, font: .MontserratMedium(Size.Small.sizeValue()))
        viewBg.layer.cornerRadius = 24
        viewBg.layer.borderWidth = 1
        viewBg.layer.borderColor = UIColor.secondaryTextColor.withAlphaComponent(0.36).cgColor
        btnSend.setTitle(L10n.Send.description, for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
