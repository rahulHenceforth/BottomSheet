//
//  CoinDetailVC.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 08/09/21.
//

import UIKit
import Charts

class CoinDetailVC: UIViewController {
    
    //MARK:- IB OUTLETS
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var btnWatchList: UIButton!
    @IBOutlet weak var lblCoinName: UILabel!
    @IBOutlet weak var lblCurrentPrice: UILabel!
    @IBOutlet weak var lblDayChange: UILabel!
    
    @IBOutlet weak var vwLineChart: LineChartView!
    @IBOutlet weak var collView: UICollectionView!
    @IBOutlet weak var lblHigh: UILabel!
    @IBOutlet weak var lblHighAmnt: UILabel!
    @IBOutlet weak var lblLow: UILabel!
    @IBOutlet weak var lblLowAmnt: UILabel!
    @IBOutlet weak var btnBuy: UIButton!
    
    @IBOutlet weak var btnSell: UIButton!
    @IBOutlet weak var btnDeposit: UIButton!
    @IBOutlet weak var btnExchange: UIButton!
    @IBOutlet weak var vwCoin: UIView!
    @IBOutlet weak var vwDayChange: UIView!
    
    
    // MARK:- VARIABLES
    var graphTypeData: [GraphTypeModal] = [GraphTypeModal(title: "1\(L10n.D.description)", id: 1, isSelected: false),GraphTypeModal(title: "1\(L10n.W.description)", id: 2, isSelected: true),GraphTypeModal(title: "1\(L10n.M.description)", id: 3, isSelected: false),GraphTypeModal(title: "1\(L10n.Y.description)", id: 4, isSelected: false),GraphTypeModal(title: L10n.All.description, id: 5, isSelected: false)]
    var graphValues : [ChartDataEntry] = []
    let customMarkerView = CustomMarkerView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetUp()
        setUpChart()
        setUpCustomMarker()
    }
}

//MARK:- INITIAL SET UP
extension CoinDetailVC{
    func initialSetUp(){
        CommmonUI.initialLbl(lbl: lblHeader, text: "\(L10n.Wallet_Balance.description) 10 ETH ≈ \(CommonFunctions.formattedCurrency(from: "25473.23"))", textColor: .appWhiteColor, font: .MontserratBold(Size.Large.sizeValue()))
        CommmonUI.initialLbl(lbl: lblCoinName, text: "Ethereum (ETH)", textColor: .primaryTextColor, font: .MontserratMedium(Size.Large.sizeValue()))
        CommmonUI.initialLbl(lbl: lblCurrentPrice, text: "€2,747.20", textColor: .primaryTextColor, font: .MontserratBold(Size.XXXLarge.sizeValue()))
        CommmonUI.initialLbl(lbl: lblDayChange, text: "2.200%", textColor: .ethereumColor, font: .MontserratBold(Size.Large.sizeValue()))
        CommmonUI.initialLbl(lbl: lblHigh, text: L10n.High.description, textColor: .DescTextColor.withAlphaComponent(0.86), font: .MontserratMedium(Size.Medium.sizeValue()))
        CommmonUI.initialLbl(lbl: lblHighAmnt, text: "€2,747.20", textColor: .primaryTextColor, font: .MontserratBold(Size.Large.sizeValue()))
        CommmonUI.initialLbl(lbl: lblLow, text: L10n.Low.description, textColor: .DescTextColor.withAlphaComponent(0.86), font: .MontserratMedium(Size.Medium.sizeValue()))
        CommmonUI.initialLbl(lbl: lblLowAmnt, text: "€2,790.20", textColor: .primaryTextColor, font: .MontserratBold(Size.Large.sizeValue()))
        
        vwCoin.layer.cornerRadius = vwCoin.bounds.height / 2
        btnBack.backgroundColor = .secondaryTextColor.withAlphaComponent(0.16)
        btnWatchList.backgroundColor = .secondaryTextColor.withAlphaComponent(0.16)
        btnBack.layer.cornerRadius = 12
        btnWatchList.layer.cornerRadius = 12
        vwDayChange.layer.cornerRadius = 24
        
        CommmonUI.borderdBtn(btn: btnBuy, title: L10n.Buy.description, titlecolor: .white, bgColor: .ethereumColor, borderColor: .ethereumColor, borderWidth: 0, font: .MontserratBold(Size.Medium.sizeValue()), cornerRadius: 20)
        CommmonUI.borderdBtn(btn: btnSell, title: L10n.Sell.description, titlecolor: .primaryTextColor, bgColor: .ethereumColor.withAlphaComponent(0.08), borderColor: .ethereumColor, borderWidth: 0, font: .MontserratBold(Size.Medium.sizeValue()), cornerRadius: 20)
        CommmonUI.borderdBtn(btn: btnDeposit, title: L10n.Deposit.description, titlecolor: .primaryTextColor, bgColor: .ethereumColor.withAlphaComponent(0.08), borderColor: .ethereumColor, borderWidth: 0, font: .MontserratBold(Size.Medium.sizeValue()), cornerRadius: 20)
        CommmonUI.borderdBtn(btn: btnExchange, title: L10n.Exchange.description, titlecolor: .primaryTextColor, bgColor: .ethereumColor.withAlphaComponent(0.08), borderColor: .ethereumColor, borderWidth: 0, font: .MontserratBold(Size.Medium.sizeValue()), cornerRadius: 20)
        
        btnBack.addTarget(self, action: #selector(btnBackTapped), for: .touchUpInside)
        btnBuy.addTarget(self, action: #selector(optionsTapped), for: .touchUpInside)
        btnSell.addTarget(self, action: #selector(optionsTapped), for: .touchUpInside)
        btnExchange.addTarget(self, action: #selector(optionsTapped), for: .touchUpInside)
        btnDeposit.addTarget(self, action: #selector(optionsTapped), for: .touchUpInside)
        btnWatchList.addTarget(self, action: #selector(btnWatchListTapped), for: .touchUpInside)
        
    }
    
    func setUpChart(){
        for index in 0..<36 {
            let randomValue = Double(arc4random_uniform(15000))
            graphValues.append(ChartDataEntry(x: Double(index), y: randomValue))
        }
        CommonFunctions.drawDetailChart(with: graphValues, on: self.vwLineChart, gradientColors: [.ethereumColor, .appWhiteColor], lineColor: .ethereumColor)
        vwLineChart.delegate = self
    }
    
    func setUpCustomMarker(){
        //                let marker:BalloonMarker = BalloonMarker(color: .ethereumColor, font: .MontserratBold(Size.Large.sizeValue()), textColor: .appWhiteColor, insets: UIEdgeInsets(top: 8.0, left: 28.0, bottom: 28.0, right: 8.0))
        //                marker.minimumSize = CGSize(width: 75.0, height: 35.0)//CGSize(75.0, 35.0)
        ////                marker.image = Asset.ballon_shadow.image()
        //                marker.chartView = self.vwLineChart
        //                self.vwLineChart.marker = marker
        //                self.vwLineChart.drawMarkers = true
        
        customMarkerView.chartView = self.vwLineChart
        self.vwLineChart.marker = customMarkerView
        self.vwLineChart.drawMarkers = true
    }
}

//MARK:- TABLE VIEW DELEGATE AND DATA SOURCE METHODS
extension CoinDetailVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return graphTypeData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.GraphTypeCVC.getValues(), for: indexPath as IndexPath) as! GraphTypeCVC
        cell.configure(with: self.graphTypeData[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.graphTypeData.indices.forEach { self.graphTypeData[$0].isSelected = false }
        self.graphTypeData[indexPath.item].isSelected = true
        self.collView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (k.DeviceInfo.screenWidth - 120) / 5, height: self.collView.frame.height)
    }
}

// MARK:- CHART VIEW DELEGATE METHODS
extension CoinDetailVC: ChartViewDelegate{
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        guard let dataSet = chartView.data?.dataSets[highlight.dataSetIndex] else { return }
        let entryIndex = dataSet.entryIndex(entry: entry)
        //        let graphPoint = chartView.getMarkerPosition(highlight: highlight)
        //        customMarkerView.lblDate.text = "\(items[entryIndex].birthRate)"
        //        customMarkerView.lblPrice.text = "\(graphValues[entryIndex].y)"
        //        customMarkerView.center = CGPoint(x: graphPoint.x, y: customMarkerView.center.y)
        customMarkerView.lblDate.text = "Aug 27, 2021"
        customMarkerView.lblPrice.text = "€\(highlight.y)"
    }
    
    
}

// MARK:- BUTTON ACTIONS
extension CoinDetailVC{
    
    @objc func btnBackTapped(sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func btnWatchListTapped(sender: UIButton){
        sender.isSelected.toggle()
        sender.setImage(sender.isSelected ? Asset.star_filled.image() : Asset.star.image(), for: .normal)
    }
    
    @objc func optionsTapped(sender: UIButton){
        switch sender.tag {
        case 0:
            let vc = BuyVC.instantiateFromAppStoryboard(appStoryboard: .CoinDetail)
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = BuyVC.instantiateFromAppStoryboard(appStoryboard: .CoinDetail)
            vc.isSell = true
            self.navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = DepositVC.instantiateFromAppStoryboard(appStoryboard: .CoinDetail)
            vc.modalPresentationStyle = .custom
            let bottomSheetManager = BottomSheetManager(delegate: self, bottomSheetVw: vc.view, presentedViewController: self, sizeOfBottomSheet: UIDevice.current.hasNotch ? [0.4, 0.6] : [0.25, 0.75])
            vc.transitioningDelegate = bottomSheetManager
            self.present(vc, animated: true, completion: nil)
            
        case 3:
            let vc = ToCryptoVC.instantiateFromAppStoryboard(appStoryboard: .CoinDetail)
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            return
        }
    }
}

// MARK:- Bottom sheet manager delegate listener
extension CoinDetailVC: BottomSheetManagerDelegate{
    func dismissSheet() {
        self.dismiss(animated: true, completion: nil)
    }
}

