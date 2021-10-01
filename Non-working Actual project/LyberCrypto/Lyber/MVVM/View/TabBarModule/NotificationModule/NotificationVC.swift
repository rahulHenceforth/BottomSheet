//
//  NotificationVC.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 14/09/21.
//

import UIKit

class NotificationVC: UIViewController {
    
    //MARK:- IB OUTLETS
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var tblVw: UITableView!
    
    // MARK:- VARIABLES
    private var dataSource : SetUpTableView<NotificationTVC, String>!
    var tblData = ["","","","","","","","",""]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialSetUp()
        updateDataSource()
    }
}

//MARK:- INITIAL SET UP
extension NotificationVC{
    func initialSetUp(){
        CommmonUI.initialLbl(lbl: lblHeader, text: L10n.Notifications.description, textColor: .primaryTextColor, font: .MontserratBold(Size.XXXLarge.sizeValue()))
        btnBack.addTarget(self, action: #selector(btnBackTapped), for: .touchUpInside)
    }
}

// MARK:- BUTTON ACTIONS
extension NotificationVC{
    
    @objc func btnBackTapped(sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}


// MARK:- TABLE VIEW SETUP
extension NotificationVC{
    
    func updateDataSource(){
        
        self.dataSource = SetUpTableView(cellIdentifier: TableViewCell.NotificationTVC.getValues(), items: tblData, configureCell: { (cell, data, index) in
            cell.selectionStyle = .none
        }, cellTap: { (indexPath, item) in
            print("Cell_Tapped at : \(indexPath), item = \(item)")
        })
        
        DispatchQueue.main.async {
            self.tblVw.delegate = self.dataSource
            self.tblVw.dataSource = self.dataSource
            self.tblVw.reloadData()
        }
    }
}
