//
//  AssetsTVC.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 10/09/21.
//

import UIKit
import Charts

class AssetsTVC: UITableViewCell {
    
    //MARK:- IB OUTLETS
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var imgCoin: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblSymbol: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblDayChange: UILabel!
    @IBOutlet weak var viewLineChart: LineChartView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewBg.layer.borderWidth = 1
        viewBg.layer.borderColor = UIColor.secondaryTextColor.withAlphaComponent(0.36).cgColor
        viewBg.layer.cornerRadius = 24
        
        CommmonUI.initialLbl(lbl: lblName, text: L10n.Bitcoin.description, textColor: .primaryTextColor, font: .MontserratBold(Size.Large.sizeValue()))
        CommmonUI.initialLbl(lbl: lblSymbol, text: "BTC", textColor: .primaryTextColor, font: .MontserratMedium(Size.Small.sizeValue()))
        CommmonUI.initialLbl(lbl: lblPrice, text: "€41,449.73", textColor: .primaryTextColor, font: .MontserratBold(Size.Large.sizeValue()))
        CommmonUI.initialLbl(lbl: lblDayChange, text: "2.12%", textColor: .AppGreenColor, font: .MontserratMedium(Size.Small.sizeValue()))
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

//MARK:- CONFIGURE CELL WITH DATA
extension AssetsTVC{
    fileprivate func extractedFunc(_ graphValues: [ChartDataEntry]) {
        CommonFunctions.drawChart(with: graphValues, on: viewLineChart, gradientColors: [UIColor(netHex: 0xF9AB4E3D), .appWhiteColor], lineColor: UIColor(netHex: 0xF9AB4E3D))
    }
    
    func configure(with data: [ChartDataEntry]){
        var graphValues: [ChartDataEntry] = []
        for index in 0..<36 {
            let randomValue = Double(arc4random_uniform(15000))
            graphValues.append(ChartDataEntry(x: Double(index), y: randomValue))
        }
        extractedFunc(graphValues)
    }
}

