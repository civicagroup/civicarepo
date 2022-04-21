//
//  RepresentativesTableViewController.swift
//  Civica
//
//  Created by Antonella on 4/16/22.
//
//  RepresentativeViewController.swift
//  Civica
//
//  Created by OSL on 4/1/22.
//

import UIKit

class RepresentativesTableViewController: UITableViewController {
    
    var repsArray = [[String: AnyObject]]()
    var officialsDict = [[String: AnyObject]]()
    var dataDictionary = [String: AnyObject]()
    @IBOutlet var repTableView: UITableView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        repTableView.dataSource = self
        repTableView.delegate = self
        fetchReps()
    }
  
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 11
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "repCell", for: indexPath) as! RepInfoTableViewCell
//      repsArray = dataDictionary["officials"] as! [[String: AnyObject]]
        print("printing from table view cell")
        print(dataDictionary)

//        let rep = repsArray[indexPath.row]
        

        return cell
    }
    
    func fetchReps() {
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
                dataDictionary = try!
                                JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
                self.repTableView.reloadData()
                
            }
            print("PRINTING FROM FETCH FUNCTION:")
            print(dataDictionary)

        }
        task.resume()
        
    }

}
