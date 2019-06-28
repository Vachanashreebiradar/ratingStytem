//
//  RatingTableViewCell.swift
//  RatingSystemDemo
//
//  Created by Vachanashree Biradar on 27/06/19.
//  Copyright © 2019 Vachanashree. All rights reserved.
//

import UIKit
import Cosmos
class RatingTableViewCell: UITableViewCell {

    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemRatingView: UIView!
    lazy var cosmosView : CosmosView = {
        var view = CosmosView()
        view.settings.minTouchRating = 0.0
        view.settings.emptyBorderColor = UIColor.lightGray
        view.settings.emptyBorderWidth = 0.7
        view.settings.filledColor = UIColor.blue
        view.settings.fillMode = .precise
        view.settings.starSize = 30
        view.settings.starMargin = 3
//        view.text = "Rate Me"
//        view.settings.textColor = UIColor.red
//        view.settings.textMargin = 10
        view.center = CGPoint(x: self.itemRatingView.frame.size.width  / 2,
                                     y: self.itemRatingView.frame.size.height / 2)

        return view
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        itemRatingView.layer.borderWidth = 0.7
        itemRatingView.layer.borderColor = UIColor.lightGray.cgColor
        itemRatingView.layer.cornerRadius = 5
        itemImageView.layer.cornerRadius = 5
        itemRatingView.addSubview(cosmosView)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
//    func cellData(item: [String:String]) {
//        itemTitle.text = item["title"]
//        itemImageView.image = UIImage(named: item["image"]!)
//        
//    }
}
