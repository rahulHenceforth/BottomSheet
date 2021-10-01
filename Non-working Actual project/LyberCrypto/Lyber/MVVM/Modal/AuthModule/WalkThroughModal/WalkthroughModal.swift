//
//  WalkthroughModal.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 25/08/21.
//

import Foundation
import UIKit

struct SplashScreenModal {
    var title : String!
    var subTitle : String!
    var image : UIImage?
    var imageLink : String?
    var isHeader: Bool!
    
    init(_ title: String, _ subTitle: String, _ img: UIImage?, _ imgLink: String?, isHeader: Bool) {
        self.title = title
        self.subTitle = subTitle
        self.image = img
        self.imageLink = imgLink
        self.isHeader = isHeader
    }
}
