//
//  WalkthroughVC.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 01/09/21.
//

import UIKit

class WalkthroughVC: UIViewController {
    
    //MARK:- IB OUTLETS
    @IBOutlet weak var collView: UICollectionView!{
        didSet{
            collView.delegate = self
            collView.dataSource = self
        }
    }
    @IBOutlet weak var btnLeft: UIButton!
    @IBOutlet weak var btnRight: AppBlueButton!
    @IBOutlet weak var vwBg: UIView!
    
    // MARK: - VARIABLES
    var currentSelectedPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        
    }
}

// MARK: - SETUP UI
extension WalkthroughVC{
    func setUpUI(){
        collView.contentInsetAdjustmentBehavior = .never
        collView.isUserInteractionEnabled = false
        
        if #available(iOS 13.0, *) {
            collView.automaticallyAdjustsScrollIndicatorInsets = false
        } else {
            // Fallback on earlier versions
        }
        
        CommmonUI.unBorderdBtn(btn: btnLeft, title: L10n.Skip.description, titlecolor: .primaryTextColor, font: UIFont.MontserratBold(Size.Medium.sizeValue()))
        
        btnLeft.layer.cornerRadius = 20
        btnLeft.backgroundColor = .appWhiteColor
        btnRight.setTitle(L10n.Next.description, for: .normal)
        
        btnLeft.addTarget(self, action: #selector(btnLeftTapped(_:)), for: .touchUpInside)
        btnRight.addTarget(self, action: #selector(btnRightTapped(_:)), for: .touchUpInside)

    }
    
    func setPageControl(index: Int){
        if index == self.currentSelectedPage{
            return
        }
        if index == 0{
            self.btnLeft.setTitle(L10n.Skip.description, for: .normal)
        }else if index < 4{
            self.btnLeft.setTitle(L10n.Back.description, for: .normal)
        }else{
            self.btnLeft.setTitle(L10n.SIGN_Up.description, for: .normal)
            self.btnRight.setTitle(L10n.LOGIN.description, for: .normal)
        }
    }
}

// MARK: - COLLECTION VIEW FUNCTIONS
extension WalkthroughVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.walkThroughCell.getValues(), for: indexPath) as! WalkThroughCVC
        cell.setData(index: indexPath.item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let value = (scrollView.contentOffset.x + scrollView.frame.width/2)/scrollView.frame.width
        self.setPageControl(index: Int(value))
        self.currentSelectedPage = Int(value)
    }
    
}


// MARK: - EXTERNAL FUNCTIONS
extension WalkthroughVC{
    @objc func btnLeftTapped(_ sender: UIButton){
        if currentSelectedPage > 0{
            if currentSelectedPage == 4{
                let vc = SignUpVC.instantiateFromAppStoryboard(appStoryboard: .Main)
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                collView.scrollToItem(at: IndexPath(item: currentSelectedPage - 1, section: 0), at: [.centeredHorizontally, .centeredVertically], animated: true)
                self.currentSelectedPage -= 1
            }
        }else{
//           let vc = LinkBankVC.instantiateFromAppStoryboard(appStoryboard: .Main)
//           self.navigationController?.pushViewController(vc, animated: true)
            let vc = CoinDetailVC.instantiateFromAppStoryboard(appStoryboard: .CoinDetail)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func btnRightTapped(_ sender: UIButton){
//        if currentSelectedPage == 4{
//            let vc = LogInVC.instantiateFromAppStoryboard(appStoryboard: .Main)
//            self.navigationController?.pushViewController(vc, animated: true)
//        }else{
//            collView.scrollToItem(at: IndexPath(item: currentSelectedPage + 1, section: 0), at: [.centeredHorizontally, .centeredVertically], animated: true)
//            self.currentSelectedPage += 1
//        }
        let vc = CoinDetailVC.instantiateFromAppStoryboard(appStoryboard: .CoinDetail)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
