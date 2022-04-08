//
//  LocalNewsViewController.swift
//  Civica
//
//  Created by Matthew Chong on 4/6/22.
//

import UIKit
import AlamofireImage

class LocalNewsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var newsTableView: UITableView!
    var news = [[String: Any]]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        newsTableView.dataSource = self
        newsTableView.delegate = self
        getNews()
    }
    
    func getNews(){
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=52c659e80c454dc5bfc719e449c34103")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                self.news = dataDictionary["articles"] as! [[String: Any]]
                
                self.newsTableView.reloadData()
            }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newsTableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell") as! NewsTableViewCell
        
        let currentNews = news[indexPath.row]
        let title = currentNews["title"] as! String
        let source = (currentNews["source"] as! [String:Any])["name"] as! String
        let time = currentNews["publishedAt"] as! String
        let url = (currentNews["urlToImage"] as? String) ?? ""
        
        cell.newsSourceLabel.text = source
        cell.newsTitleLabel.text = title
        cell.newsTimeLabel.text = time
        
        if url != "" {
            let newsImageUrl = URL(string: (url))
            cell.newsImage.af.setImage(withURL: newsImageUrl!)
        }
        
        return cell
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
