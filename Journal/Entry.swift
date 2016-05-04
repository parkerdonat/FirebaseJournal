//
//  Entry.swift
//  Journal
//
//  Created by Parker Donat on 5/3/16.
//  Copyright © 2016 Falcone Development. All rights reserved.
//

import Foundation

class Entry {
    
    private let kTitle = "title"
    private let kText = "text"
    
    var title: String
    var text: String
    var identifier: String?
    var dictValue: [String: AnyObject] {
        return [kTitle: title, kText: text]
    }
    
    init(title: String, text: String) {
        self.title = title
        self.text = text
        self.identifier = nil
    }
    
    init?(dictionary: [String: AnyObject], identifier: String) {
     guard let title = dictionary[kTitle] as? String,
        text = dictionary[kText] as? String else {return nil}
        self.title = title
        self.text = text
        self.identifier = identifier
    }
}