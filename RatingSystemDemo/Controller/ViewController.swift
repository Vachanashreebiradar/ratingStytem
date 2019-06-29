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

            }
            
        }
        
    }
  @objc func generateRandomRating() {
    isRandomSelected.toggle()
    let randomGenerator = RandomGenerator(allItems: allItems, target: self, isRandomSelected: isRandomSelected)
    randomGenerator.generateRandomRating()

    }

    override func viewDidLoad() {
        super.viewDidLoad()
            getDataFromJsonfile()

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

