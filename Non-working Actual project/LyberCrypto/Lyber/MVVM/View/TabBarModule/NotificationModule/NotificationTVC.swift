//
//  NotificationTVC.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 14/09/21.
//

import UIKit

class NotificationTVC: UITableViewCell {

    //MARK:- IB OUTLETS
    @IBOutlet weak var vwBg: UIView!
    @IBOutlet weak var lblContent: UILabel!
    @IBOutlet weak var lblTym: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        CommmonUI.initialLbl(lbl: lblContent, text: "2.1BTC sucessfully sent to abc@xyz.com", textColor: .primaryTextColor, font: .MontserratBold(Size.Large.sizeValue()))
        CommmonUI.initialLbl(lbl: lblTym, text: "Aug 27, 2021", textColor: .primaryTextColor, font: .MontserratMedium(Size.Small.sizeValue()))
        vwBg.layer.cornerRadius = 24
        vwBg.layer.borderWidth = 1
        vwBg.layer.borderColor = UIColor.secondaryTextColor.withAlphaComponent(0.36).cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
