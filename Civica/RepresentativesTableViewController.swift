//
//  RepresentativesTableViewController.swift
//  Civica
//
//  Created by Antonella on 4/16/22.
//


//
//  RepresentativeViewController.swift
//  Civica
//
//  Created by OSL on 4/1/22.
//





import UIKit

class RepresentativesTableViewController: UITableViewController {

    var repsArray = [[String: Any]]()
    @IBOutlet var repTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        repTableView.dataSource = self
        repTableView.delegate = self
        
    }
    /*
    func configure() {
        RepService.shared.fetchReps() { [weak self]
            detail in
            self?.nameLabel.text = detail?.name
        }
    }
*/
    // MARK: - Table view data source
        
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "repCell", for: indexPath) as! RepInfoTableViewCell
        
        cell.nameLabel.text = "Barack Obama"
        cell.firstlineLabel.text = "President"
        

        // Configure the cell...

        return cell
    }
    
    
    func fetchReps(completion: @escaping((Representative?) -> Void)) {
       
        let CIVIC_API_KEY = "AIzaSyCC2MxPRX7kj6Mg6e7eaYaHGMKZWkNb8Jg"
        let address = "1600 Pennsylvania Avenue Northwest, Washington, DC, 20500"
        let addressFixed:String = address.replacingOccurrences(of: " ", with: "%20")
        let url = URL(string: "https://www.googleapis.com/civicinfo/v2/representatives?key=\(CIVIC_API_KEY)&address=\(addressFixed)")!
        
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let decoder = JSONDecoder()
                let repsList = try? decoder.decode(Representative.self, from: data)
                completion(repsList)
                print(repsList ?? "empty")
            }

        }
        task.resume()
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
