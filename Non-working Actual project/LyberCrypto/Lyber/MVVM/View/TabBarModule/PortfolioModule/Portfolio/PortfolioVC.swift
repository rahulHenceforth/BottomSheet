//
//  PortfolioVC.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 08/09/21.
//

import UIKit

class PortfolioVC: UIViewController {
    
    //MARK:- IB OUTLETS
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnBell: UIButton!
    @IBOutlet weak var viewNotification: UIView!
    @IBOutlet weak var lblNotificationCount: UILabel!
    @IBOutlet weak var btnDepositFund: UIButton!
    @IBOutlet weak var lblTotalBalance: UILabel!
    @IBOutlet weak var lblBalanceAmnt: UILabel!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var btnEye: UIButton!
    
    var isBalanceHidden = true
    var hiddenText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetUp()
    }
}

//MARK:- INITIAL SET UP
extension PortfolioVC{
    func initialSetUp(){
        CommmonUI.initialLbl(lbl: lblName, text: "Alex Sotsky", textColor: .appWhiteColor, font: .MontserratBold(Size.Large.sizeValue()))
        CommmonUI.initialLbl(lbl: lblTotalBalance, text: L10n.Total_Balance.description, textColor: .appWhiteColor, font: .MontserratMedium(Size.Header.sizeValue()))
        CommmonUI.initialLbl(lbl: lblBalanceAmnt, text: CommonFunctions.formattedCurrency(from: "82385.60"), textColor: .appWhiteColor, font: .MontserratBold(30))
        CommmonUI.initialLbl(lbl: lblNotificationCount, text: "3", textColor: .appWhiteColor, font: .MontserratBold(Size.VSmall.sizeValue()))
        CommmonUI.unBorderdBtn(btn: btnDepositFund, title: L10n.Deposit_Funds.description, titlecolor: .appWhiteColor, font: .MontserratBold(Size.Large.sizeValue()))
        imgProfile.layer.cornerRadius = 12
        btnBell.layer.cornerRadius = 12
        btnBell.backgroundColor = .appWhiteColor.withAlphaComponent(0.16)
        viewNotification.layer.cornerRadius = viewNotification.bounds.height / 2
        viewNotification.backgroundColor = .AppRedColor
        btnDepositFund.layer.cornerRadius = 24
        btnDepositFund.backgroundColor = .appWhiteColor.withAlphaComponent(0.5)
        
        let img = Asset.visibility_off.image().withRenderingMode(.alwaysTemplate)
        btnEye.setImage(img, for: .normal)
        btnEye.tintColor = .appWhiteColor
        
        (self.lblBalanceAmnt.text ?? "").forEach { _ in
            hiddenText.append("*")
        }
        self.lblBalanceAmnt.text = hiddenText
        
        btnDepositFund.addTarget(self, action: #selector(btnDepositFundTapped), for: .touchUpInside)
        btnBell.addTarget(self, action: #selector(btnBellTapped), for: .touchUpInside)
        btnEye.addTarget(self, action: #selector(btnEyeTapped), for: .touchUpInside)
        
    }
}

//MARK:- TABLE VIEW DELEGATE AND DATA SOURCE METHODS
extension PortfolioVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 4 ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.YourAssetsTVC.getValues(), for: indexPath) as! YourAssetsTVC
            cell.configure()
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.AssetsOptionsTVC.getValues(), for: indexPath) as! AssetsOptionsTVC
            cell.controller = self
            cell.selectionStyle = .none
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.InviteTVC.getValues(), for: indexPath) as! InviteTVC
            cell.configure()
            let tap = UITapGestureRecognizer(target: self, action: #selector(inviteTapped))
            cell.viewBg.addGestureRecognizer(tap)
            cell.selectionStyle = .none
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.NewsTVC.getValues(), for: indexPath) as! NewsTVC
            cell.configure()
            cell.selectionStyle = .none
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.NewsListTVC.getValues(), for: indexPath) as! NewsListTVC
            cell.configure(with: indexPath.row)
            cell.selectionStyle = .none
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerVw = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 12))
        footerVw.backgroundColor = .clear
        return footerVw
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 4{
            return 12
        }else{
            return 0
        }
    }
}

// MARK:- BUTTON ACTIONS
extension PortfolioVC{
    
    @objc func btnDepositFundTapped(sender: UIButton){
        let vc = ChoosePaymentOptionVC.instantiateFromAppStoryboard(appStoryboard: .Tabbar)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func inviteTapped(sender: UITapGestureRecognizer){
        let vc = InviteVC.instantiateFromAppStoryboard(appStoryboard: .Tabbar)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func btnBellTapped(sender: UITapGestureRecognizer){
        let vc = NotificationVC.instantiateFromAppStoryboard(appStoryboard: .Tabbar)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func btnEyeTapped(sender: UIButton){
        isBalanceHidden.toggle()
        
        if isBalanceHidden{
            self.lblBalanceAmnt.text = hiddenText
            let img = Asset.visibility_off.image().withRenderingMode(.alwaysTemplate)
            btnEye.setImage(img, for: .normal)
            
        }else{
            self.lblBalanceAmnt.text = CommonFunctions.formattedCurrency(from: "82385.60")
            let img = Asset.visibility.image().withRenderingMode(.alwaysTemplate)
            btnEye.setImage(img, for: .normal)
        }
        
    }
    
}

