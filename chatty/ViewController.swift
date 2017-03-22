//
//  ViewController.swift
//  chatty
//
//  Created by A S on 3/21/17.
//  Copyright © 2017 ca.shayegh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func loginClicked(_ sender: Any) {
        let email = "test1@gmail.com"
        let password = "password"
        
        // do login
        FirebaseManager.Login(email: email, password: password) { (success:Bool) in
            if(success) {
                self.performSegue(withIdentifier: "showProfile", sender: sender)
            }
        }
    }

}

