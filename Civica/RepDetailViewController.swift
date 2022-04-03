//
//  RepDetailViewController.swift
//  Civica
//
//  Created by OSL on 4/2/22.
//

import UIKit

class RepDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    let newsArray = ["a", "b", "c"]
    let tweetArray = ["e", "f", "g"]
    var useArray: [String] = []
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepDetailNewsTableViewCell") as! RepDetailNewsTableViewCell
        
        cell.newsLabel.text = useArray[indexPath.row] as! String
//        switch segmentedControl.selectedSegmentIndex
//        {
//        case 0:
//            nameLabel.text = "First Segment Selected"
//            cell.newsLabel.text = newsArray[indexPath.row]
////            return cell
//        case 1:
//            nameLabel.text = "Second Segment Selected"
//            cell.newsLabel.text = tweetArray[indexPath.row]
////            return cell
//        default:
//            break
//        }
        
//        if segmentedControl.selectedSegmentIndex == 0 {
//            cell.newsLabel.text = newsArray[indexPath.row]
//        }
//        else if segmentedControl.selectedSegmentIndex == 1 {
//            cell.newsLabel.text = tweetArray[indexPath.row]
//        }
                
        return cell
    }
        
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return useArray.count
    }



    @IBAction func indexChanged(_ sender: Any) {

        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            useArray = newsArray
            tableView.reloadData()
        case 1:
            useArray = tweetArray
            tableView.reloadData()
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // set initial value
        useArray = newsArray
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
