//
//  AssetsOptionsTVC.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 08/09/21.
//

import UIKit

class AssetsOptionsTVC: UITableViewCell {
    
    //MARK:- IB OUTLETS
    @IBOutlet weak var collViw: UICollectionView!
    @IBOutlet weak var collVwHt: NSLayoutConstraint!
    
    var controller: PortfolioVC!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collViw.delegate = self
        collViw.dataSource = self
        
        self.setLayout()
        
        collViw.reloadData()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setLayout(){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        layout.itemSize = CGSize(width: (k.DeviceInfo.screenWidth - 64) / 2, height: 128)
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = 12
        collViw!.collectionViewLayout = layout
        
        let height = collViw.collectionViewLayout.collectionViewContentSize.height
        collVwHt.constant = height
    }
}

//MARK:- TABLE VIEW DELEGATE AND DATA SOURCE METHODS
extension AssetsOptionsTVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.AssetsOptionsCVC.getValues(), for: indexPath as IndexPath) as! AssetsOptionsCVC
        cell.configure(with: "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = CoinDetailVC.instantiateFromAppStoryboard(appStoryboard: .CoinDetail)
        self.controller.navigationController?.pushViewController(vc, animated: true)
    }
    
}
