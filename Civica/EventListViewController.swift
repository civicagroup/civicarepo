//
//  EventListViewController.swift
//  Civica
//
//  Created by OSL on 4/20/22.
//

import UIKit
import Parse
import AlamofireImage

class EventListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var events = [PFObject]()
    var eventCount: Int!
    let incrementLoad = 10
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventDetailTableViewCell") as! EventDetailTableViewCell
        let event = self.events[indexPath.row]
        cell.eventDesc.text = event["Description"] as? String ?? ""
        cell.eventName.text = event["EventName"] as? String ?? ""
        cell.eventLocation.text = "Location: \(event["Address"] ?? "TBD"), \(event["Zipcode"] ?? "")."
        
        let authorObject = event["Author"] as! PFUser
        cell.eventOrganizer.text = "Created by \(authorObject.username as! String)"
        
        if let imageFile = event["Image"] as? PFFileObject {
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            cell.eventImage.af.setImage(withURL: url)

        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy  hh:mm a"
        if let startTime = event["StartTime"] as? Date {
            cell.eventStartTime.text = "\(dateFormatter.string(from: startTime))"
        }
        return cell
    }
    

    @objc func queryParse(postCount: Int) -> Void {
        let query = PFQuery(className: "Event")
        query.includeKeys(["Author", "StartTime", "Description", "Image", "EventName", "Address", "Zipcode"])
        query.limit = eventCount
        query.order(byDescending: "StartTime")
        query.findObjectsInBackground { (events, error) in
            if events != nil {
                print("Retrieving...")
                self.events = events!
                self.tableView.reloadData()
                print(events!)
//                self.myRefreshControl.endRefreshing()
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventCount = incrementLoad
        queryParse(postCount: eventCount)
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onCreateEvent(_ sender: Any) {
//        print(PFUser.current())
        if PFUser.current() != nil {
            performSegue(withIdentifier: "toCreateEvent", sender: self)
        } else {
            performSegue(withIdentifier: "toLoginPage", sender: self)
        }
    }
    
    
    @IBAction func onLogout(_ sender: Any) {
        PFUser.logOut()
        displayAlert(withTitle: "Success", message: "You have logged out.")
//        let main = UIStoryboard(name: "Main", bundle: nil)
//        let loginViewController = main.instantiateViewController(identifier: "LoginViewController")
//        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//              let delegate = windowScene.delegate as? SceneDelegate else { return }
//        delegate.window?.rootViewController = loginViewController
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
