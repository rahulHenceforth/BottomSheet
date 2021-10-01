//
//  InviteTVC.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 08/09/21.
//

import UIKit

class InviteTVC: UITableViewCell {

    //MARK:- IB OUTLETS
    @IBOutlet weak var btnDollar: UIButton!
    @IBOutlet weak var lblInvite: UILabel!
    @IBOutlet weak var lblInvite2: UILabel!
    @IBOutlet weak var viewBg: GradientView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//MARK:- CONFIGURE CELL WITH DATA
extension InviteTVC{
    func configure(){
        btnDollar.layer.cornerRadius = 12
        viewBg.layer.cornerRadius = 24
        btnDollar.backgroundColor = .appWhiteColor.withAlphaComponent(0.16)
        CommmonUI.initialLbl(lbl: lblInvite, text: L10n.Earn_up_to_€50_in_LYB_tokens.description, textColor: .appWhiteColor, font: .MontserratBold(Size.Medium.sizeValue()))
        CommmonUI.initialLbl(lbl: lblInvite2, text: L10n.Invite_your_friends.description, textColor: .appWhiteColor, font: .MontserratMedium(Size.Small.sizeValue()))
        
       
    }
}

