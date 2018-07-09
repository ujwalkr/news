//
//  News+extension.swift
//  News
//
//  Created by Admin on 09/07/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import CoreData

typealias JSON = [String: Any]

extension News {
    static func createEntity(json: JSON,context: NSManagedObjectContext) -> News {
        let news = News(context: context)
        news.author = json["author"] as? String
        news.title = json["title"] as? String
        news.detail = json["description"] as? String
        news.url = json["url"] as? String
        news.urlToImage = json["urlToImage"] as? String
        news.publishedAt = json["publishedAt"] as? String
        news.source = Source.createEntity(json: (json["source"] as! JSON), context: context)
        return news
    }
    
    static func createEntity(articles : Articles,context: NSManagedObjectContext) -> News {
        let news = News(context: context)
        news.author = articles.author
        news.title = articles.title
        news.detail = articles.description
        news.url = articles.url
        news.urlToImage = articles.urlToImage
        news.publishedAt = articles.publishedAt
        news.source = Source.createEntity(newsSource: articles.source, context: context)
        return news
    }
}

extension News {
    static func fetchNews() -> [News] {
        
        let fetchRequest: NSFetchRequest<News> = News.fetchRequest()
        do {
            let news = try appDelegate.persistentContainer.viewContext.fetch(fetchRequest)
            return news
        } catch {
            print("error while fetching news from coredata \(error.localizedDescription)")
            return []
        }
    }
}
