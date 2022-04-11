//
//  RepService.swift
//  Civica
//
//  Created by Antonella on 4/11/22.
//

import Foundation


class RepService {
    static let shared = RepService()
    
    func fetchReps(completion: @escaping(([Representative]) -> Void)) {
       
        let CIVIC_API_KEY = "AIzaSyCC2MxPRX7kj6Mg6e7eaYaHGMKZWkNb8Jg"
        let address = "1600 Pennsylvania Avenue Northwest, Washington, DC, 20500"
        let addressFixed:String = address.replacingOccurrences(of: " ", with: "%20")
        let url = URL(string: "https://www.googleapis.com/civicinfo/v2/representatives?key=\(CIVIC_API_KEY)&address=\(addressFixed)")!
        
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
        let task = session.dataTask(with: request) { (data, response, error) in
//            guard error == nil else {
//                print("got an error")
//                return
//            }
//            guard let data = data else {
//                print("got no data")
//                return
//            }
//
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                 let repsRawData = dataDictionary["officials"] as! [[String: Any]]
                 var representatives = [Representative]()
                 for rawData in repsRawData {
                     let representative = Representative(name: rawData["name"] as! String,
//                                                         address: rawData["address"]["line1"] as! String,
                                                         party: rawData["party"] as! String,
                                                         phones: rawData["phones"] as! [String]
                                                         //website: rawData["urls"] as! String,
                                                         //emails: rawData["emails"] as! [String]
//                                                         imageURL: rawData[""]
                     )
                     representatives.append(representative)
                 }
                 completion(representatives)
             }
        }
        task.resume()
        
    }

}

