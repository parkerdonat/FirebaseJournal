//
//  FirebaseController.swift
//  Journal
//
//  Created by Parker Donat on 5/3/16.
//  Copyright © 2016 Falcone Development. All rights reserved.
//

import Foundation
import Firebase


class FirebaseController {
    static let base = Firebase(url: "https://journal-nathanfalcone.firebaseio.com")
    
    static func dataEndpoint(endpoint: String, completion: (data: AnyObject?) -> Void) {
        let baseForEndpoint = FirebaseController.base.childByAppendingPath(endpoint)
        
        baseForEndpoint.observeSingleEventOfType(.Value, withBlock: { (data) in
            
            if data.value is NSNull {
                completion(data: nil)
            } else {
                completion(data: data.value)
            }
        })
    }
    
    static func observeDataAtEndpoint(endpoint: String, completion: (data: AnyObject?) -> Void) {
        let baseForEndpoint = FirebaseController.base.childByAppendingPath(endpoint)
        
        baseForEndpoint.observeEventType(.Value, withBlock: { (data) in
            if data.value is NSNull {
                completion(data: nil)
            } else {
                completion(data: data.value)
            }
        })
    }
}