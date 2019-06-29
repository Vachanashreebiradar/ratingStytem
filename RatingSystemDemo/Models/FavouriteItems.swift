//
//  FavouriteItems.swift
//  RatingSystemDemo
//
//  Created by Vachanashree Biradar on 27/06/19.
//  Copyright © 2019 Vachanashree. All rights reserved.
//

import Foundation
struct FavouriteItems : Codable {
    var title : String?
    var image : String?
    var ratings : Double?
//    init(json: [JSON]) {
//        for dataObject in json {
//            title = dataObject["title"] as? String
//            image = dataObject["image"] as? String
//            ratings = dataObject["ratings"] as? Double
//            var jsonString = """
//                             { "favouriteItems" : [
//                             """
//            for _ in 0...json.count-2 {
//                jsonString.append("""
//                                    {
//                                    "title": "\(title!)",
//                                    "image": "\(image!)",
//                                    "ratings": \(ratings!)
//                                    },
//                                  """)
//            }
//            jsonString.append("""
//                {
//                "title": "\(title!)",
//                "image": "\(image!)",
//                "ratings": \(ratings!)
//                }
//                """)
//            jsonString.append("""
//                                ]
//                              }
//                              """)
//            print(jsonString)
//            do {
//                let jsonData = try JSONSerialization.data(withJSONObject: jsonString, options: .prettyPrinted)
//                JsonDataManager.shared.writeDataFromJsonFile(data: jsonData, completion: { (error) in
////                    if let _ = error {
////                        return
////                    }
//                })
//            } catch {
//                print(error.localizedDescription)
//            }
//        }
//    }
}

