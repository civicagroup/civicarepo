//
//  RepresentativesViewController.swift
//  Civica
//
//  Created by Antonella on 4/21/22.
//

import UIKit

class RepresentativesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var repsArray = [[String: Any]]()
    @IBOutlet weak var repTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        repTableView.dataSource = self
        repTableView.delegate = self
        
        fetchReps()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.repsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepInfoTableViewCell", for: indexPath) as! RepInfoTableViewCell
        
        let currentRep = self.repsArray[indexPath.row]
        let name = currentRep["name"] as! String
        let addressObject = (currentRep["address"] as! [[String: Any]])[0]
        let addressLine1 = addressObject["line1"] as! String
        let city = addressObject["city"] as! String
        let state = addressObject["state"] as! String
        let zip = addressObject["zip"] as! String
        let party = currentRep["party"] as! String
        
        cell.nameLabel.text = name
        cell.partyLabel.text = party
        cell.addressLabel.text = "\(addressLine1), \(city), \(state), \(zip)"

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
                let dataDictionary = try!
                                JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
                
                self.repsArray = dataDictionary["officials"] as! [[String: Any]]
                
                print("PRINTING FROM FETCH FUNCTION:")
                print(self.repsArray)
                self.repTableView.reloadData()
                
            }

        }
        task.resume()
        
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
