//
//  RepresentativesViewController.swift
//  Civica
//
//  Created by Antonella on 4/21/22.
//

import UIKit

class RepresentativesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var repsArray = [[String: Any]]()
    var positions : [Int: String] = [:]
    var officesArray = [[String: Any]]()
    var rawAddress: String?
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
        if let addressObjects = (currentRep["address"] as? [[String: Any]]) {
            let addressObject = addressObjects[0]
            let addressLine1 = addressObject["line1"] as! String
            let city = addressObject["city"] as! String
            let state = addressObject["state"] as! String
            let zip = addressObject["zip"] as! String
            cell.addressLabel.text = "\(addressLine1), \(city), \(state), \(zip)"
        }
        
        let party = currentRep["party"] as! String
        let office = self.positions[indexPath.row]!
        
        cell.nameLabel.text = name
        cell.partyLabel.text = party
        cell.officeLabel.text = office

        return cell
    }
    @IBAction func onBack(_ sender: Any) {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let addresVC = main.instantiateViewController(identifier: "AddressViewController")
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let delegate = windowScene.delegate as? SceneDelegate else { return }
        delegate.window?.rootViewController = addresVC
    }
    
    func fetchReps() {
        let CIVIC_API_KEY = "AIzaSyCC2MxPRX7kj6Mg6e7eaYaHGMKZWkNb8Jg"
        guard let address:String = rawAddress?.replacingOccurrences(of: " ", with: "%20") else {return}
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
                self.officesArray = dataDictionary["offices"] as! [[String: Any]]
                
                for office in self.officesArray {
                    let indicies = office["officialIndices"] as! [Int]
                    let name = office["name"] as! String
                    for index in indicies {
                        self.positions[index] = name
                    }
                }
                
//                print("PRINTING FROM FETCH FUNCTION:")
//                print(self.repsArray)
//                print(self.positions)
                self.repTableView.reloadData()
            }
        }
        task.resume()
        
    }
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let cell = sender as! UITableViewCell
        let indexPath = self.repTableView.indexPath(for: cell)!
        let rep = self.repsArray[indexPath.row]
        
        // Pass the selected movie to the dettails view controller
        let repDetailViewController = segue.destination as! RepDetailViewController
        repDetailViewController.currentRep = rep
        repDetailViewController.repPosition = self.positions[indexPath.row]!
        
        self.repTableView.deselectRow(at: indexPath, animated: true)
    }

}
