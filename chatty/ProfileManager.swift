//
//  ProfileManager.swift
//  chatty
//
//  Created by A S on 3/22/17.
//  Copyright © 2017 ca.shayegh. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth


class ProfileManager: NSObject {
    
    // static reference to db
    static let dbref = FIRDatabase.database().reference()
    
    // reference to uid
    static let uid = FIRAuth.auth()?.currentUser?.uid
    
    // array of user obj
    static var users = [User]()
    
    // function to get current user
    // remember: what's an optioan? something that can be nil
    static func getCurrentUser(uid:String) -> User? {
        
        // query to find user
        if let i = users.index(where: {$0.uid == uid}) {
            // if found, return user at index
            return users[i]
        } else {
            // optional return lets us write a clean else
            return nil
        }
    }
    
    // callback after users come
    static func fillUsers(completion: @escaping () -> Void) {
        
        users = []
        // child -> chose a node: Users -> set objerver to wait for new node
        dbref.child("users").observe(.childAdded, with: {
            // results come in snapshots
            snapshot in
            print(snapshot)
            
            // build result by taking apart the snapshot
            if let result = snapshot.value as? [String:AnyObject] {
                
                let uid = result["uid"]! as! String
                let username = result["username"]! as! String
                let email = result["email"]! as! String
                let profileImageUrl = result["profileImageURL"]! as! String
                
                // initialize the user
                let u = User(uid: uid, username: username, email: email, profileImageUrl: profileImageUrl)
                
                // add user to managet users array
                ProfileManager.users.append(u)
            }
            // call completion
            completion()
        })
    }  

}
