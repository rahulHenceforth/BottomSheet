//
//  d.swift
//  NewApp
//
//  Created by Think Recycling Pvt Ltd on 26/08/19.
//  Copyright © 2019 Think Recycling Pvt Ltd. All rights reserved.
//

import UIKit

#if os(iOS) || os(tvOS) || os(watchOS)
    import UIKit.UIImage
    typealias Image = UIImage
#elseif os(OSX)
    import AppKit.NSImage
    typealias Image = NSImage
#endif

enum Asset : String {
    
    case splash_one = "splash_one"
    case splash_two = "splash_two"
    case splash_three = "splash_three"
    case splash_five = "splash_four"
    case splash_four = "splash_five"
    case visibility_off = "eye_off"
    case visibility = "eye"
    case arrow_down = "arrow_down"
    case radio_button_checked = "radio_button_checked"
    case radio_button_unchecked = "radio_button_unchecked"
    case logo_home = "logo_home"
    case notification = "notification"
    case blue_border_notification = "blue_border_notification"
    case notification1 = "notification-1"
    case tick = "tick"
    case clock = "clock"
    case verification_progress = "verification_progress"
    case toogle_on = "toogle_on"
    case toogle_off = "toogle_off"
    case calender = "calender"
    case id_card_back = "id_card_back"
    case uncheck = "uncheck"
    case check = "check"
    case phone_no = "phone_no"
    case well_done = "well_done-1"
    case star_filled = "star_filled"
    case star = "star"
    case ballon_shadow = "ballon_shadow"
    case bitcoin_small = "bitcoin_small"
    case ethereum_small = "ethereum_small"
    case eur = "eur"
    
    func image () -> UIImage{
        return UIImage(named: self.rawValue) ?? UIImage()
    }
}


extension Image {
    convenience init!(asset: Asset) {
        self.init(named: asset.rawValue)
    }
}
