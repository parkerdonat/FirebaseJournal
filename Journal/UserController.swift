//
//  UserController.swift
//  Journal
//
//  Created by Parker Donat on 5/3/16.
//  Copyright © 2016 Falcone Development. All rights reserved.
//

import Foundation
import Firebase
class UserController {
    
    static var currentUser: User?
    
    static func createUser(email: String, password: String, completion:(success: Bool) -> Void) {
        FirebaseController.base.createUser(email, password: password) { (error, userData) in
            if let error = error {
                print(error.localizedDescription)
                completion(success: false)
            } else {
                guard let uid = userData["uid"] as? String else {
                    completion(success: false)
                    return
                }
                let user = User(email: email, identifier: uid)
                FirebaseController.base.childByAppendingPath("users").childByAppendingPath(user.identifier).setValue(user.dictValue)
                authorizeUser(email, password: password, completion: { (success) in
                    if success {
                        completion(success: true)
                    } else {
                        completion(success: false)
                    }
                })
            }
        }
    }
    
    static func authorizeUser(email: String, password: String, completion: (success: Bool) -> Void) {
        FirebaseController.base.authUser(email, password: password) { (error, authData) in
            if let error = error {
                print("\(#function) " + error.localizedDescription)
                self.currentUser = nil
                completion(success: false)
                return
            } else {
                guard let authData = authData.uid else {
                    print("no user came back with auth data")
                    self.currentUser = nil
                    completion(success: false)
                    return
                }
                userForIdentifier(authData, completion: { (user) in
                    self.currentUser = user
                    completion(success: true)
                })
            }
        }
    }
    
    static func userForIdentifier(identifier: String, completion: (user: User?) -> Void) {
        FirebaseController.base.childByAppendingPath("users").childByAppendingPath(identifier).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            guard let jsonValue = snapshot.value as? [String: AnyObject],
                user = User(dictionary: jsonValue, identifier: identifier) else {
                    print("dont have the info you want from \(identifier)")
                    completion(user: nil)
                    return
            }
            completion(user: user)
        })
    }
}