//
//  NewsListTVC.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 08/09/21.
//

import UIKit

class NewsListTVC: UITableViewCell {

    //MARK:- IB OUTLETS
    @IBOutlet weak var lblImageContent: UILabel!
    @IBOutlet weak var lblTym: UILabel!
    @IBOutlet weak var imgVw: UIImageView!
    @IBOutlet weak var viewBg: UIView!
    
    
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
extension NewsListTVC{
    func configure(with data: Int){
        CommmonUI.initialLbl(lbl: lblImageContent, text: L10n.Weekly_Newsletter.description, textColor: .primaryTextColor, font: .MontserratBold(Size.Medium.sizeValue()))
        CommmonUI.initialLbl(lbl: lblTym, text: "an hour ago", textColor: .primaryTextColor, font: .MontserratMedium(Size.Small.sizeValue()))
        imgVw.layer.cornerRadius = 12
        
        if data == 0{
            DispatchQueue.main.async {
                self.viewBg.roundCorners([.topLeft, .topRight], radius: 24)
            }
        }else if data == 1{
            DispatchQueue.main.async {
                self.viewBg.roundCorners([.bottomLeft, .bottomRight], radius: 24)
            }
        }
    }
}

