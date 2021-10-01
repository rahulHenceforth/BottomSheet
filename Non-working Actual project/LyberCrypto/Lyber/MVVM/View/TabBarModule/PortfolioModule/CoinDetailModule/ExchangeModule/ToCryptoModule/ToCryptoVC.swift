//
//  ToCryptoVC.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 09/09/21.
//

import UIKit

class ToCryptoVC: UIViewController {

    //MARK:- IB OUTLETS
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var tblView: UITableView!
    
    // MARK:- VARIABLES
    private var dataSource : SetUpTableView<ToCryptoTVC, String>!
    var tblData = ["","",""]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialSetUp()
        updateDataSource()
    }
}

//MARK:- INITIAL SET UP
extension ToCryptoVC{
    func initialSetUp(){
        CommmonUI.initialLbl(lbl: lblHeader, text: L10n.To_Crypto.description, textColor: .primaryTextColor, font: .MontserratBold(Size.XXXLarge.sizeValue()))
     
        btnBack.addTarget(self, action: #selector(btnBackTapped), for: .touchUpInside)
    }
}



// MARK:- TABLE VIEW SETUP
extension ToCryptoVC{
    
    func updateDataSource(){
        
        self.dataSource = SetUpTableView(cellIdentifier: TableViewCell.ToCryptoTVC.getValues(), items: tblData, configureCell: { (cell, data, index) in
            cell.configure(row: index.row)
            cell.selectionStyle = .none
        }, cellTap: { (indexPath, item) in
            print("Cell_Tapped at : \(indexPath), item = \(item)")
            let vc = ExchangeVC.instantiateFromAppStoryboard(appStoryboard: .CoinDetail)
            self.navigationController?.pushViewController(vc, animated: true)
        })
        
        DispatchQueue.main.async {
            self.tblView.delegate = self.dataSource
            self.tblView.dataSource = self.dataSource
            self.tblView.reloadData()
        }
    }
}

// MARK:- BUTTON ACTIONS
extension ToCryptoVC{
    
    @objc func btnBackTapped(sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}


