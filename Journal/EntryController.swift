//
//  EntryController.swift
//  Journal
//
//  Created by Parker Donat on 5/3/16.
//  Copyright © 2016 Falcone Development. All rights reserved.
//

import Foundation

class EntryController {
    
    static func createEntry(title: String, text: String, completion: (success: Bool) -> Void) {
        let entry = Entry(title: title, text: text)
        
        FirebaseController.base.childByAppendingPath("users").childByAppendingPath(UserController.currentUser!.identifier).childByAppendingPath("entries").childByAutoId().setValue(entry.dictValue) { (error, _) in
            
            if let error = error {
                print(error.localizedDescription)
                completion(success: false)
            } else {
                completion(success: true)
            }
        }
    }
    
    static func deleteEntry(entry: Entry, completion: (success: Bool) -> Void) {
        
        if let identifier = entry.identifier {
            FirebaseController.base.childByAppendingPath("users").childByAppendingPath(UserController.currentUser!.identifier).childByAppendingPath("entries").childByAppendingPath(identifier).removeValueWithCompletionBlock({ (error, _) in
                if let error = error {
                    print(error.localizedDescription)
                    completion(success: false)
                } else {
                    completion(success: true)
                }
            })
        }
    }
    
    static func fetchAllEntriesForUser(user: User, completion: (entries: [Entry]) -> Void) {
        FirebaseController.dataEndpoint("users/\(user.identifier)/entries") { (data) in
            
            guard let entryDicts = data as? [String : [String : AnyObject]] else {
                completion(entries: [])
                return
            }
            
            let entries = entryDicts.map({Entry(dictionary: $0.1, identifier: $0.0)!})
            completion(entries: entries)
        }
    }
    
    static func updateEntry(entry: Entry, completion: (success: Bool) -> Void) {
        if let identifier = entry.identifier {
            FirebaseController.base.childByAppendingPath("users").childByAppendingPath(UserController.currentUser!.identifier).childByAppendingPath("entries").childByAppendingPath(identifier).setValue(entry.dictValue, withCompletionBlock: { (error, _) in
                if let error = error {
                    print(error.localizedDescription)
                    completion(success: false)
                } else {
                    completion(success: true)
                }
            })
        } else {
            print(entry.identifier)
        }
    }
}