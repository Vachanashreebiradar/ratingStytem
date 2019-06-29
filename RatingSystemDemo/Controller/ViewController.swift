//
//  ViewController.swift
//  RatingSystemDemo
//
//  Created by Vachanashree Biradar on 27/06/19.
//  Copyright © 2019 Vachanashree. All rights reserved.
//

import UIKit
typealias JSON = [String : Any]
class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var itemsTableView: UITableView!
    var isRandomSelected = false
//    var timer : Timer? = nil
//    var timeInterval : TimeInterval = 5
    var allItems = [FavouriteItems]()
    var favouriteItems = [JSON]()
    func getDataFromJsonfile() {
        JsonDataManager.shared.readDataFromJsonFile { (items, error) in
            if let err = error {
                print(err.localizedDescription)
                return
            } else {
                guard let dataDict = items else {
                    return
                }
                
                favouriteItems = dataDict["favouriteItems"] as! [JSON]
                favouriteItems = favouriteItems.sorted(by: { $0["ratings"] as! Double > $1["ratings"] as! Double })
                for dict in favouriteItems {
                    let data = FavouriteItems(title: dict["title"] as? String, image: dict["image"] as? String, ratings: dict["ratings"] as? Double)
                    allItems.append(data)
                }
//                let defaults = UserDefaults.standard
//                defaults.set(allItems, forKey: "initialData")

            }
            
        }
        
    }
  @objc func generateRandomRating() {
    isRandomSelected.toggle()
    let randomGenerator = RandomGenerator(allItems: allItems, target: self, isRandomSelected: isRandomSelected)
    randomGenerator.generateRandomRating()
//        isRandomSelected.toggle()
//    if isRandomSelected {
//        navigationItem.rightBarButtonItem?.tintColor = UIColor.darkGray
//
//        timer = Timer(timeInterval: timeInterval, target: self, selector: #selector(runCode), userInfo: nil, repeats: false)
//        RunLoop.main.add(timer!, forMode: .common)
//    } else {
//        timer?.invalidate()
//        navigationItem.rightBarButtonItem?.tintColor = UIColor.red
//    }
   
    

    }
//   @objc func runCode() {
//            timeInterval = TimeInterval(Int.random(in: 10...43200))
//            let randomIndex = Int.random(in: 0...(allItems.count-1))
//            let randomRate = Double.random(in: 0...5)
//            var indexPath = IndexPath(row: randomIndex, section: 0)
//            allItems[indexPath.row].ratings = randomRate
//            allItems = allItems.sorted(by: { $0.ratings! > $1.ratings! })
//            isRandomSelected ? itemsTableView.reloadData() : nil
//            timer?.invalidate()
//            timer = nil
//    timer = Timer(timeInterval: timeInterval, target: self, selector: #selector(runCode), userInfo: nil, repeats: false)
//    RunLoop.main.add(timer!, forMode: .common)
//
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        let defaults = UserDefaults.standard
//       let data = defaults.object(forKey: "initialData") as? [FavouriteItems]
//        if let _ = data {
//            self.itemsTableView.reloadData()
//        } else {
            getDataFromJsonfile()
//        }
        let randomButton = UIBarButtonItem(title: "Random Rating", style: .plain, target: self, action: #selector(generateRandomRating))
        randomButton.tintColor = UIColor.red
        navigationItem.rightBarButtonItem = randomButton
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ratingCell", for: indexPath) as! RatingTableViewCell
        cell.itemTitle.text = allItems[indexPath.row].title
        cell.itemImageView.image = UIImage(named: allItems[indexPath.row].image!)
        cell.cosmosView.rating = allItems[indexPath.row].ratings!
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! RatingTableViewCell
        cell.cosmosView.didTouchCosmos = { rating in
            print(rating)
            self.allItems[indexPath.row].ratings = rating
            self.allItems = self.allItems.sorted(by: { $0.ratings! > $1.ratings! })
            self.itemsTableView.reloadData()

        }
    }
}

