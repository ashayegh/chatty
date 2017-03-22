//
//  ViewController.swift
//  chatty
//
//  Created by A S on 3/21/17.
//  Copyright © 2017 ca.shayegh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func loginClicked(_ sender: Any) {
        //let email = "test1@gmail.com"
        //let password = "password"
        
        // do login
        FirebaseManager.Login(email: email.text!, password: password.text!) { (success:Bool) in
            if(success) {
                self.performSegue(withIdentifier: "showProfile", sender: sender)
            }
        }
    }
    @IBAction func newAccountClicked(_ sender: UIButton) {
        FirebaseManager.createAccount(email: email.text!, password: password.text!, username: username.text!){
            (result:String) in
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "showProfile", sender: sender)
            }
        }
        
    }

}

