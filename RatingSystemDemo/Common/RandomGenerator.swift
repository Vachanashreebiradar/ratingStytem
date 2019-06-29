//
//  RandomGenerator.swift
//  RatingSystemDemo
//
//  Created by Vachanashree Biradar on 28/06/19.
//  Copyright © 2019 Vachanashree. All rights reserved.
//

import Foundation
import UIKit
class RandomGenerator {
    var timeInterval : TimeInterval
    let targetVC : ViewController
    var isRandomSelected : Bool
    var timer : Timer? = nil
    var allItems : [FavouriteItems] = []
    init(allItems : [FavouriteItems], target: ViewController, isRandomSelected: Bool) {
        self.allItems = allItems
        timeInterval = 5
        targetVC = target
        self.isRandomSelected = isRandomSelected
        
    }
    func generateRandomRating() {
        isRandomSelected.toggle()
        if isRandomSelected {
            targetVC.navigationItem.rightBarButtonItem?.tintColor = UIColor.darkGray
            
            timer = Timer(timeInterval: timeInterval, target: self, selector: #selector(runCode), userInfo: nil, repeats: false)
            RunLoop.main.add(timer!, forMode: .common)
        } else {
            timer?.invalidate()
            targetVC.navigationItem.rightBarButtonItem?.tintColor = UIColor.red
        }
        
    }
    @objc func runCode() {
        let randomIndex = Int.random(in: 0...(allItems.count-1))
        let randomRate = Double.random(in: 0...5)
        var indexPath = IndexPath(row: randomIndex, section: 0)
        allItems[indexPath.row].ratings = randomRate
        allItems = allItems.sorted(by: { $0.ratings! > $1.ratings! })
        targetVC.allItems = allItems
        isRandomSelected ? targetVC.itemsTableView.reloadData() : nil
        timeInterval = TimeInterval(Int.random(in: 10...43200))
        timer?.invalidate()
        timer = nil
        timer = Timer(timeInterval: timeInterval, target: self, selector: #selector(runCode), userInfo: nil, repeats: false)
        RunLoop.main.add(timer!, forMode: .common)
        
    }
}
