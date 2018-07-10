//
//  Source+extension.swift
//  News
//
//  Created by Admin on 09/07/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import CoreData

extension Source {
    static func createEntity(json: JSON, context: NSManagedObjectContext) -> Source {
        let source = Source(context: context)
        source.id = json["id"] as? String
        source.name = json["name"] as? String
        return source
    }
    static func createEntity(newsSource: NewsSource, context: NSManagedObjectContext) -> Source {
        let source = Source(context: context)
        source.id = UUID().uuidString
        source.name = newsSource.name
        return source
    }
}
