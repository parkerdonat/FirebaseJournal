//
//  User.swift
//  Journal
//
//  Created by Parker Donat on 5/3/16.
//  Copyright © 2016 Falcone Development. All rights reserved.
//

import Foundation

class User {
    private let kEmail = "email"
    private let kEntries = "entries"
    
    var entries: [Entry]
    var email: String
    var identifier: String
    var dictValue: [String: AnyObject] {
        return [kEmail: email, kEntries: entries.map({$0.dictValue})]
    }
    
    init(email: String, identifier: String) {
        self.entries = []
        self.email = email
        self.identifier = identifier
    }
    
    init?(dictionary: [String: AnyObject], identifier: String) {
        if let entries = dictionary[kEntries] as? [String: [String: AnyObject]] {
            self.entries = entries.map({Entry(dictionary: $0.1, identifier: $0.0)!})
        } else {
            self.entries = []
        }
        
        if let email = dictionary[kEmail] as? String {
            self.email = email
        } else {
            return nil
        }
        
        self.identifier = identifier
    }
}