//
//  FirebaseManager.swift
//  chatty
//
//  Created by A S on 3/22/17.
//  Copyright © 2017 ca.shayegh. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class FirebaseManager: NSObject {
    // reference to database
    static let databaseRed = FIRDatabase.database().reference()
    // current user id
    static var currentUserId:String = ""
    static var currentUser:FIRUser? = nil
    
    // Function used to LOGIN (via email)
    static func Login(email:String, password:String, completion: @escaping(_ _success:Bool) -> Void) {
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(false)
            } else {
                // if successfull
                currentUser = user
                currentUserId = (user?.uid)!
                completion(true)
            }
        })
        
    }
}
