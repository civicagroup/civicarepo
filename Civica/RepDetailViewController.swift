//
//  RepDetailViewController.swift
//  Civica
//
//  Created by OSL on 4/2/22.
//

import UIKit
import AlamofireImage

class RepDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var newsTableView: UITableView!
    @IBOutlet weak var tweetTableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var contactStack: UIStackView!
    
    //    let newsArray = ["a", "b", "c", "d", "e"]
    var tweetArray = [NSDictionary]()
//    var userIdArray = [NSDictionary]()
    let repName = "Barack+Obama"
    let repTwitterScreenName = "barackobama"  // this is the twitter handle
//    let userId = 20
//    var useArray: [String] = []
    var newsArray = [[String: Any]]()
    var numberOfTweet: Int!
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        if tableView == newsTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RepDetailNewsTableViewCell") as! RepDetailNewsTableViewCell
            
            let currentNews = newsArray[indexPath.row]
            let source = (currentNews["source"] as! [String:Any])["name"] as! String
            let time = currentNews["publishedAt"] as! String
            let url = (currentNews["urlToImage"] as? String) ?? ""
            
            cell.newsLabel.text =  currentNews["title"] as? String
            cell.newsSource.text = source
            cell.newsDate.text = time
            
            if url != "" {
                let newsImageUrl = URL(string: (url))
                cell.newsImage.af.setImage(withURL: newsImageUrl!)
            }
            return cell

        } else if tableView == tweetTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RepDetailTweetTableViewCell") as! RepDetailTweetTableViewCell
 
            let user = tweetArray[indexPath.row]["user"] as! NSDictionary
            let tweet = tweetArray[indexPath.row]
            cell.tweetContent.text = tweet["text"] as? String
            cell.tweetDate.text = tweet["created_at"] as? String
            
//            let entities = tweetArray[indexPath.row]["entities"] as? NSDictionary
//            if entities != nil && entities?["media"] != nil {
//                let media = entities?["media"] as! [NSDictionary]
//                let mediaAddress = (media[0]["media_url"] as? String) ?? ""
//                if mediaAddress != "" {
//                    let mediaURL = URL(string: mediaAddress)
//                    cell.tweetImage.af.setImage(withURL: mediaURL!)
//                    }
//                }
            
            return cell
        }
    
        return UITableViewCell()
    }
        
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView == newsTableView ? newsArray.count: tweetArray.count
    }

    @objc func loadTweets(){
        // get a representative's tweets
        let myUrl = "https://api.twitter.com/1.1/statuses/user_timeline.json"
//        guard !userIdArray.isEmpty else {
//            print("This representative don't have a twitter account")
//            return
//        }
//        let userId = userIdArray[0]["id"] as! Int
//        let userId = 1512453420443217920
        numberOfTweet = 20
        let myParams = ["screen_name": repTwitterScreenName, "count": numberOfTweet] as [String : Any]
        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParams, success: { (tweets: [NSDictionary]) in
            self.tweetArray.removeAll()
            for tweet in tweets {
                self.tweetArray.append(tweet)
            }
            print("tweet array length \(self.tweetArray.count)")
            self.tweetTableView.reloadData()
//            self.myRefreshControl.endRefreshing()
        }, failure: { (Error) in
            print(Error.localizedDescription)
            print("Could not retrieve tweets.")
        })
    }
    
//    @objc func getTwitterUserId(_ representativeName: String){
//        // get a representative's tweets
//        let myUrl = "https://api.twitter.com/1.1/users/lookup.json"
//        let myParams = ["screen_name": representativeName]
//        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParams, success: { (users: [NSDictionary]) in
//            print(users)
//            self.userIdArray.removeAll()
//            for user in users {
//                self.userIdArray.append(user)
//            }
//
//            self.tweetTableView.reloadData()
////            self.myRefreshControl.endRefreshing()
//        }, failure: { (Error) in
//            print(Error.localizedDescription)
//            print("Could not retrieve user.")
//        })
//    }

    func getNews(){
        let url = URL(string: "https://newsapi.org/v2/everything?q=\(repName)&apiKey=52c659e80c454dc5bfc719e449c34103")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                self.newsArray = dataDictionary["articles"] as! [[String: Any]]
                
                self.newsTableView.reloadData()
            }
        }
        task.resume()
    }
    
    @IBAction func indexChanged(_ sender: Any) {

        switch segmentedControl.selectedSegmentIndex
        {
        // contact
        case 0:
            contactStack.isHidden = false
            tweetTableView.isHidden = true
            newsTableView.isHidden = true
        // display tweets
        case 1:
            contactStack.isHidden = true
            newsTableView.isHidden = true
            tweetTableView.isHidden = false
        // display news
        case 2:
            contactStack.isHidden = true
            newsTableView.isHidden = false
            tweetTableView.isHidden = true
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        getTwitterUserId(representativeName)
        loadTweets()
        getNews()
        newsTableView.delegate = self
        newsTableView.dataSource = self
        tweetTableView.delegate = self
        tweetTableView.dataSource = self
        
        // set initial value
        contactStack.isHidden = false
        newsTableView.isHidden = true
        tweetTableView.isHidden = true
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
