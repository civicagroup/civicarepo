//
//  RepresentativesViewController.swift
//  Civica
//
//  Created by Antonella on 4/21/22.
//

import UIKit

class RepresentativesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let CIVIC_API_KEY = "AIzaSyCC2MxPRX7kj6Mg6e7eaYaHGMKZWkNb8Jg"
        let rawAddress = "1600 Pennsylvania Avenue Northwest, Washington, DC, 20500"
        let address:String = rawAddress.replacingOccurrences(of: " ", with: "%20")
        let url = URL(string: "https://www.googleapis.com/civicinfo/v2/representatives?key=\(CIVIC_API_KEY)&address=\(address)")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
        let task = session.dataTask(with: request) { [self] (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
               let dataDictionary = try!
                                JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
//                self.repTableView.reloadData()
                print("PRINTING FROM FETCH FUNCTION:")
                print(dataDictionary)
                
            }
           

        }
        task.resume()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
