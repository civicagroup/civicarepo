//
//  LocalNewsViewController.swift
//  Civica
//
//  Created by Matthew Chong on 4/6/22.
//
import UIKit
import AlamofireImage
import SafariServices

class LocalNewsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var newsTableView: UITableView!
    var news = [[String: Any]]()
    var nextPage: Int = 0
    var searchString: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        newsTableView.dataSource = self
        newsTableView.delegate = self
        
        searchBar.delegate = self
        
        getNews(pageNumber: nextPage)
//        getNewsWithQuery(query: "california")
    }
    
    func getNews(pageNumber: Int){
        self.news.removeAll()
        let url = URL(string: "https://newsdata.io/api/1/news?apikey=pub_6332cf3898e5a1fe6775a85dd43794c2f6d6&category=politics&country=us&page=\(pageNumber)")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                self.news = dataDictionary["results"] as! [[String: Any]]
                self.nextPage = (dataDictionary["nextPage"] as? Int) ?? -1
                self.newsTableView.reloadData()
            }
        }
        task.resume()
    }
    
    func getMoreNews(){
        let url = URL(string: "https://newsdata.io/api/1/news?apikey=pub_6332cf3898e5a1fe6775a85dd43794c2f6d6&category=politics&country=us&page=\(self.nextPage)")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                let temp = dataDictionary["results"] as! [[String: Any]]
                for news in temp {
                    self.news.append(news)
                }
                self.nextPage = (dataDictionary["nextPage"] as? Int) ?? -1
                self.newsTableView.reloadData()
            }
        }
        task.resume()
    }
    
    func getNewsWithQuery(query: String){
        self.news.removeAll()
        let url = URL(string: "https://newsdata.io/api/1/news?apikey=pub_6332cf3898e5a1fe6775a85dd43794c2f6d6&category=politics&country=us&page=\(self.nextPage)&q=\(query)")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                let temp = dataDictionary["results"] as! [[String: Any]]
                for news in temp {
                    self.news.append(news)
                }
                self.nextPage = (dataDictionary["nextPage"] as? Int) ?? -1
                
                self.newsTableView.reloadData()
            }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == self.news.count {
            if (searchBar.text == "" && self.nextPage != -1) {
                getMoreNews()
            } else {
                if (self.nextPage != -1) {
                    getNewsWithQuery(query: self.searchString)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newsTableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell") as! NewsTableViewCell
        
        let currentNews = news[indexPath.row]
        let title = currentNews["title"] as! String
        let source = currentNews["source_id"] as! String
        let time = currentNews["pubDate"] as! String
        let url = (currentNews["image_url"] as? String) ?? ""
        
        cell.newsSourceLabel.text = source
        cell.newsTitleLabel.text = title
        cell.newsTimeLabel.text = time
        
        if url != "" {
            let newsImageUrl = URL(string: (url))
            cell.newsImage.af.setImage(withURL: newsImageUrl!)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentNews = news[indexPath.row]
        let url = currentNews["link"] as! String ?? ""
        if url == "" {
            return
        }
        showNews(url: url)
        newsTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func showNews(url: String) {
        if let url = URL(string: "\(url)") {
                let config = SFSafariViewController.Configuration()
                config.entersReaderIfAvailable = false

                let vc = SFSafariViewController(url: url, configuration: config)
                present(vc, animated: true)
            }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.nextPage = 0
        var text = searchBar.text
        text = text?.trimmingCharacters(in: .whitespaces)
        text = text?.replacingOccurrences(of: " ", with: "%20")
        if (text != nil) {
            getNewsWithQuery(query: text!)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchString = searchText
        if (searchText.trimmingCharacters(in: .whitespaces) == "") {
            self.nextPage = 0
            getNews(pageNumber: nextPage)
        }
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
