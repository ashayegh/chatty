//
//  PostManager.swift
//  chatty
//
//  Created by A S on 3/22/17.
//  Copyright © 2017 ca.shayegh. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class PostManager: NSObject {
    // database reference
    static let databaseRef = FIRDatabase.database().reference()
    // post manager (array of type post)
    static var posts = [Post]()
    
    static func addPost(username:String, text:String, toId:String, fromId:String) {
        let p = Post(username: username, text: text, toId: toId)
        
        // if message is not empty
        if (p.text != "") {
            //
            let uid = FIRAuth.auth()?.currentUser?.uid
            
            // post object for firebase
            let post = ["uid":uid!,
                        "username": p.username,
                        "text":p.text,
                        "toId":p.toId
                        ]
            databaseRef.child("posts").childByAutoId().setValue(post)
            
        }
    }
    
    // fill post
    static func fillPosts(uid:String?, toId:String, completion: @escaping(_ result:String) -> Void) {
        posts = []
        let allPost = databaseRef.child("posts")
        print(allPost)
        let post = databaseRef.child("posts").queryOrdered(byChild: "uid").queryEqual(toValue: FirebaseManager.currentUser?.uid).observe(.childAdded, with: {
            
            snapshot in
            print(snapshot)
        })
        
        databaseRef.child("posts").queryOrdered(byChild: "uid").queryEqual(toValue: FirebaseManager.currentUser?.uid).observe(.childAdded, with: {
            
            snapshot in
            print(snapshot)
            
            if let result = snapshot.value as? [String: AnyObject] {
                let toIdCloud = result["toId"] as! String
                if (toIdCloud == toId) {
                    let p = Post(username: result["username"]! as! String, text: result["text"]! as! String, toId: result["toId"]! as! String)
                    PostManager.posts.append(p)
                }
            }
            completion("")
        })
    }
}

// Post Object
class Post {
    var username:String = ""
    var text:String = ""
    var toId:String = ""
    
    init(username:String, text:String, toId:String){
        self.username = username
        self.text = text
        self.toId = toId
    }
}
