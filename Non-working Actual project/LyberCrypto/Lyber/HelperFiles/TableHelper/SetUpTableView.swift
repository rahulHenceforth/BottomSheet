//
//  SetUpTableView.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 26/08/21.
//

import Foundation
import UIKit


class SetUpTableView<CELL: UITableViewCell,T> : NSObject, UITableViewDataSource, UITableViewDelegate {
    
    private var cellIdentifier: String!
    private var items: [T]!
    private var isFooterEnabled = false
    var configureCell: (CELL, T, IndexPath) -> () = {_,_,_ in }
    var cellTap: (IndexPath, T) -> () = {_,_ in }
    
    
    init(cellIdentifier : String, items : [T], isFooterEnabled: Bool? = false, configureCell : @escaping (CELL, T, IndexPath) -> (), cellTap: @escaping (IndexPath, T) -> ()) {
        self.cellIdentifier = cellIdentifier
        self.items =  items
        self.configureCell = configureCell
        self.cellTap = cellTap
        self.isFooterEnabled = isFooterEnabled ?? false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(items.count)
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CELL
        
        let item = self.items[indexPath.row]
        self.configureCell(cell, item, indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.cellTap(indexPath, self.items[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 12))
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return isFooterEnabled ? 12 : 0
    }
}


