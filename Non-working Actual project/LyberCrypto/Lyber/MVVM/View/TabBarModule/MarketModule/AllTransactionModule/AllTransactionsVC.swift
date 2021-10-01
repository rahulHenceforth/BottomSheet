//
//  AllTransactionsVC.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 10/09/21.
//

import UIKit

class AllTransactionsVC: UIViewController {

    //MARK:- IB OUTLETS
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnFilter: UIButton!
    @IBOutlet weak var tblView: UITableView!
    
    // MARK:- VARIABLES
    private var dataSource : SetUpTableView<AllTransactionTVC, String>!
    var tblData = ["","","","","","","","",""]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialSetUp()
        updateDataSource()
    }

}

//MARK:- INITIAL SET UP
extension AllTransactionsVC{
    func initialSetUp(){
        CommmonUI.initialLbl(lbl: lblHeader, text: L10n.All_Transactions.description, textColor: .primaryTextColor, font: .MontserratBold(Size.XXXLarge.sizeValue()))
        btnBack.addTarget(self, action: #selector(btnBackTapped), for: .touchUpInside)
        btnFilter.addTarget(self, action: #selector(btnFilterTapped), for: .touchUpInside)
    }
}

// MARK:- TABLE VIEW SETUP
extension AllTransactionsVC{
    
    func updateDataSource(){
        
        self.dataSource = SetUpTableView(cellIdentifier: TableViewCell.AllTransactionTVC.getValues(), items: tblData, configureCell: { (cell, data, index) in
            cell.selectionStyle = .none
        }, cellTap: { (indexPath, item) in
            print("Cell_Tapped at : \(indexPath), item = \(item)")
            let vc = TransactionDetailVC.instantiateFromAppStoryboard(appStoryboard: .Transaction)
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
extension AllTransactionsVC{
    
    @objc func btnBackTapped(sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func btnFilterTapped(sender: UIButton){
        k.DeviceInfo.sizeHeight = UIDevice.current.hasNotch ? [0.5, 0.5] : [0.4, 0.6]
        let vc = TransactionsTypeVC.instantiateFromAppStoryboard(appStoryboard: .Transaction)
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self
        self.present(vc, animated: true, completion: nil)
        vc.doneTapped = {
            
        }
    }
}


// MARK:- HALF SHEET VIEW DELEGATE
extension AllTransactionsVC: UIViewControllerTransitioningDelegate {
    // 2.
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        BottomSheetPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
