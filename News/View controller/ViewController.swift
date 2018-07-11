//
//  ViewController.swift
//  News
//
//  Created by Admin on 09/07/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as! AppDelegate

class ViewController: UIViewController {
    let apikey = "0022ac54f82f4793b20031dbc905e3ee"
    let api = "https://newsapi.org/v2/top-headlines?country=in&apiKey=0022ac54f82f4793b20031dbc905e3ee"
    
    var news = [News]()
    var newsResult: NewsResult? {
        didSet{
            let container = appDelegate.persistentContainer
            
            container.performBackgroundTask{ [weak self] context in
                do {
                    for article in (self?.newsResult?.articles)!{
                    let _ = News.createEntity(articles: article, context: context)
                        print("storing news in coredata")
                }
                  try context.save()
                    print("saved items in coredata")
                    DispatchQueue.main.async { [weak self] in
                        self?.news = News.fetchNews()
                        self?.tableView.reloadData()
                        print("reload tableview")
                    }
                }catch {
                    print ("News didnt saved \(error.localizedDescription)")
                }
            }
            
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        makeUrlCall()
    }
    
    private func makeUrlCall() {
        guard let url = URL(string: api) else {print("error in url"); return}
        
        URLSession.shared.dataTask(with: url) { (data,response,error) in 
            if error != nil {
                print("failed to fetch result: error \(String(describing: error?.localizedDescription))")
            }
            
            guard let data  = data else {print("error in data"); return}
            do {
                print("fetching news result")
                let newsResult = try JSONDecoder().decode(NewsResult.self, from: data)
                print("fetched and decoded news result")
                DispatchQueue.main.async {
                    self.newsResult = newsResult
                }
            }catch let jsonError{
                print(jsonError)
            }
        }.resume()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "dropdown" {
            if let _ = segue.destination as? DropdownViewController {
                
            }
        }
    }
}

extension ViewController: UITableViewDelegate {
    
}
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "news", for: indexPath)
        if let newsCell = cell as? NewsTableViewCell {
            newsCell.news = news[indexPath.row]
        }
        return cell
    }
}

struct NewsResult: Decodable {
    var status: String?
    var totalResults: Int?
    var articles: [Articles]
}

struct Articles: Decodable {
    var source: NewsSource
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
}

struct NewsSource: Decodable {
    var name: String?
}
