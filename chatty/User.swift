//
//  User.swift
//  chatty
//
//  Created by A S on 3/22/17.
//  Copyright © 2017 ca.shayegh. All rights reserved.
//

import UIKit

class User: NSObject {
    var username:String
    var email:String
    var uid:String
    var profileImageUrl:String
    
    init(uid:String, username:String, email:String, profileImageUrl:String) {
        self.uid = uid
        self.username = username
        self.email = email
        self.profileImageUrl = profileImageUrl
    }
}
