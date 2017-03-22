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
    static let databaseRef = FIRDatabase.database().reference()
    // current user id
    static var currentUserId:String = ""
    static var currentUser:FIRUser? = nil
    
    // Function used to LOGIN (via email)
    static func Login(email:String, password:String, completion: @escaping(_ success:Bool) -> Void) {
        
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
    
    // new user
    static func createAccount(email:String, password:String, username:String, completion:@escaping(_ result:String) -> Void) {
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error)
            in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            AddUser(username: username, email: email)
            Login(email: email, password: password) {
                (success:Bool) in
                if(success) {
                    print("Account created and logged in")
                } else {
                    print("Failed login after account creation")
                }
            }
            completion("")
        })
    }
    
    // add user
    static func AddUser(username:String, email:String) {
        let uid = FIRAuth.auth()?.currentUser?.uid
        let post = ["uid":uid,
                    "username":username,
                    "email":email,
                    "profileImageURL":""]
        
        databaseRef.child("users").child(uid!).setValue(post)
        
    }
}
