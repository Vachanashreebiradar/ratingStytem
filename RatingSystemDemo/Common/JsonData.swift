//
//  JsonData.swift
//  RatingSystemDemo
//
//  Created by Vachanashree Biradar on 27/06/19.
//  Copyright © 2019 Vachanashree. All rights reserved.
//

import Foundation
class JsonDataManager {
    private init(){}
    static let shared = JsonDataManager()
    func readDataFromJsonFile(completion: ([String : Any]?, Error?) -> ()) {
        
        guard let path = Bundle.main.path(forResource: "FavouriteItems", ofType: "json") else { return }
        let url = URL(fileURLWithPath: path)
            do {
                
                let data = try Data(contentsOf: url)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String : Any]
                completion(jsonResult, nil)
            } catch {
                // handle error
                print(error)
                completion(nil, error)
            }
    
    }
  
}

