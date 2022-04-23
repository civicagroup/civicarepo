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
    var wikiParam: String = ""
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
            
            
            let photoUrlStr = currentRep["photoUrl"] as? String
            print("\(name), rep photo url \(photoUrlStr as? String ?? "NA")")
            
            if photoUrlStr != nil, let photoImageUrl = URL(string: (photoUrlStr!)) {
                cell.repImage.af.setImage(withURL: photoImageUrl)
            }
            
            // some hard coded images - replace this with wikipedia api
            
            if name == "Joseph R. Biden" {
                let photoImageUrl = URL(string: ("https://upload.wikimedia.org/wikipedia/commons/thumb/6/68/Joe_Biden_presidential_portrait.jpg/960px-Joe_Biden_presidential_portrait.jpg"))
                cell.repImage.af.setImage(withURL: photoImageUrl!)
            } else if name == "Kamala D. Harris" {
            
                let photoImageUrl = URL(string: ("https://upload.wikimedia.org/wikipedia/commons/thumb/4/41/Kamala_Harris_Vice_Presidential_Portrait.jpg/1280px-Kamala_Harris_Vice_Presidential_Portrait.jpg"))
                cell.repImage.af.setImage(withURL: photoImageUrl!)
            } else if name == "Ron DeSantis" {
                
                let photoImageUrl = URL(string: ("https://upload.wikimedia.org/wikipedia/commons/b/b3/Ron_DeSantis_2020_%28cropped%29.jpg"))
                cell.repImage.af.setImage(withURL: photoImageUrl!)
            } else if name == "Carlos A. Gimenez" {
                
                let photoImageUrl = URL(string: ("https://upload.wikimedia.org/wikipedia/commons/thumb/e/ee/Rep._Carlos_Gimenez_official_photo%2C_117th_Congress.jpg/1280px-Rep._Carlos_Gimenez_official_photo%2C_117th_Congress.jpg"))
                cell.repImage.af.setImage(withURL: photoImageUrl!)
            } else if name == "Harvey Ruvin" {
                
                let photoImageUrl = URL(string: ("https://s3.amazonaws.com/ballotpedia-api4/files/thumbs/200/300/HarveyRuvin.jpg"))
                cell.repImage.af.setImage(withURL: photoImageUrl!)
            }else if name == "Pedro J. Garcia" {
                
                let photoImageUrl = URL(string: ("https://www.miamidade.gov/pa/images/pedro-garcia.jpg"))
                cell.repImage.af.setImage(withURL: photoImageUrl!)
            }else if name == "Daniella Levine Cava" {
                
                let photoImageUrl = URL(string: ("https://www.miamidade.gov/resources/images/mayor/mayor-cava-headshot-high-res.jpg"))
                cell.repImage.af.setImage(withURL: photoImageUrl!)
            } else if name == "Ricky Polston" {
                
                let photoImageUrl = URL(string: ("https://upload.wikimedia.org/wikipedia/commons/d/d1/Florida-Supreme-Court-Justice-Ricky-Polston-2019.jpg"))
                cell.repImage.af.setImage(withURL: photoImageUrl!)
            }else if name == "Jorge Labarga" {
                
                let photoImageUrl = URL(string: ("https://upload.wikimedia.org/wikipedia/commons/thumb/8/85/Florida-Supreme-Court-Justice-Jorge-Labarga-2019.jpg/1200px-Florida-Supreme-Court-Justice-Jorge-Labarga-2019.jpg"))
                cell.repImage.af.setImage(withURL: photoImageUrl!)
            }else if name == "John D. Couriel" {
                
                let photoImageUrl = URL(string: ("https://upload.wikimedia.org/wikipedia/commons/3/3a/John_D._Couriel_%28cropped%29.jpg"))
                cell.repImage.af.setImage(withURL: photoImageUrl!)
            }else if name == "Jamie R. Grosshans" {
                
                let photoImageUrl = URL(string: ("https://upload.wikimedia.org/wikipedia/commons/e/ef/Jamie_R._Grosshans_%28cropped%29.jpg"))
                cell.repImage.af.setImage(withURL: photoImageUrl!)
            }else if name == "Charles T. Canady" {
                
                let photoImageUrl = URL(string: ("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0RIg57WMSdOQNlTrLP7nXQDuuuSs-4UHEbyabBCyZpsbj9hrDxFEK7NkRk7bS6-tl2bo&usqp=CAU"))
                cell.repImage.af.setImage(withURL: photoImageUrl!)
            }else if name == "Jeanette Nuñez" {
                
                let photoImageUrl = URL(string: ("https://upload.wikimedia.org/wikipedia/commons/thumb/4/43/Jeanette_Nunez_official_photo.jpg/1200px-Jeanette_Nunez_official_photo.jpg"))
                cell.repImage.af.setImage(withURL: photoImageUrl!)
            }
            
            
            
            
                
            
//            var rawWikiParam = name
//            
//            if rawWikiParam == "Joseph R. Biden" {
//                rawWikiParam = "Joe_Biden"
//            } else {
//                
//            }
//            wikiParam = rawWikiParam.replacingOccurrences(of: " ", with: "%20")
//            
//            let url = URL(string: "https://en.wikipedia.org/w/api.php?action=query&prop=pageimages&format=json&piprop=original&titles=\(wikiParam)")!
//    
//            let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
//            let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
//            let task = session.dataTask(with: request) { [self] (data, response, error) in
//                if let error = error {
//                    print(error.localizedDescription)
//                } else if let data = data {
//                    print("PRINTING FROM WIKI CALL:")
//                    print(name)
//                    print(wikiParam)
//                    print(data)
//                }
//            
//        }
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
