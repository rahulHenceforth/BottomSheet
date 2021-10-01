//
//  MarketVC.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 10/09/21.
//

import UIKit
import Charts

class MarketVC: UIViewController {
    
    //MARK:- IB OUTLETS
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnTransactions: UIButton!
    @IBOutlet weak var viewTransactions: UIView!
    @IBOutlet weak var lblTransactionsCount: UILabel!
    @IBOutlet weak var lblTotalBalance: UILabel!
    @IBOutlet weak var lblBalanceAmnt: UILabel!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var btnEye: UIButton!
    
    var graphValues : [ChartDataEntry] = []
    var isBalanceHidden = true
    var hiddenText = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        initialSetUp()
    }
}

//MARK:- INITIAL SET UP
extension MarketVC{
    func initialSetUp(){
        CommmonUI.initialLbl(lbl: lblName, text: "Alex Sotsky", textColor: .appWhiteColor, font: .MontserratBold(Size.Large.sizeValue()))
        CommmonUI.initialLbl(lbl: lblTotalBalance, text: "\(L10n.Total_Balance.description) in €", textColor: .appWhiteColor, font: .MontserratMedium(Size.Header.sizeValue()))
        CommmonUI.initialLbl(lbl: lblBalanceAmnt, text: CommonFunctions.formattedCurrency(from: "82385.60"), textColor: .appWhiteColor, font: .MontserratBold(30))
        CommmonUI.initialLbl(lbl: lblTransactionsCount, text: "3", textColor: .appWhiteColor, font: .MontserratBold(Size.VSmall.sizeValue()))
        
        imgProfile.layer.cornerRadius = 12
        btnTransactions.layer.cornerRadius = btnTransactions.bounds.height / 2
        viewTransactions.layer.cornerRadius = viewTransactions.bounds.height / 2
        viewTransactions.backgroundColor = .AppRedColor
        
        let img = Asset.visibility_off.image().withRenderingMode(.alwaysTemplate)
        btnEye.setImage(img, for: .normal)
        btnEye.tintColor = .appWhiteColor

        (self.lblBalanceAmnt.text ?? "").forEach { _ in
            hiddenText.append("*")
        }
        self.lblBalanceAmnt.text = hiddenText
        
        btnEye.addTarget(self, action: #selector(btnEyeTapped), for: .touchUpInside)
        btnTransactions.addTarget(self, action: #selector(btnTransactionsTapped), for: .touchUpInside)
        
    }
}

//MARK:- TABLE VIEW DELEGATE AND DATA SOURCE METHODS
extension MarketVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 3 ? 4 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0,2:
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.HeaderTVC.getValues(), for: indexPath) as! HeaderTVC
            cell.configure(with: indexPath.section == 0 ? L10n.Watchlists.description : L10n.Assets.description)
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.WatchListTVC.getValues(), for: indexPath) as! WatchListTVC
            cell.controller = self
            cell.selectionStyle = .none
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.AssetsTVC.getValues(), for: indexPath) as! AssetsTVC
            cell.selectionStyle = .none
            cell.configure(with: graphValues)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 3{
            let vc = CoinDetailVC.instantiateFromAppStoryboard(appStoryboard: .CoinDetail)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

// MARK:- BUTTON ACTIONS
extension MarketVC{
    
    @objc func btnTransactionsTapped(sender: UIButton){
        let vc = AllTransactionsVC.instantiateFromAppStoryboard(appStoryboard: .Transaction)
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



