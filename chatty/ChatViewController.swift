//
//  ChatViewController.swift
//  chatty
//
//  Created by A S on 3/21/17.
//  Copyright © 2017 ca.shayegh. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    var selectedUser:User?
    
    @IBOutlet weak var chatTable: UITableView!
    
    @IBOutlet weak var userInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        PostManager.fillPosts(uid: FirebaseManager.currentUser?.uid, toId: (selectedUser?.uid)!) {
            (result:String) in
            DispatchQueue.main.async {
                self.chatTable.reloadData()
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        PostManager.posts = []
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    @IBAction func sendClicked(_ sender: Any) {
        PostManager.addPost(username: (selectedUser?.username)!, text: userInput.text!, toId: (selectedUser?.uid)!, fromId: (FirebaseManager.currentUser?.uid)!)
        userInput.text = ""
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return PostManager.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! chatTableViewCell
        let messageText = cell.messageText!
        messageText.delegate = self
        let post = PostManager.posts[indexPath.row]
        cell.messageText.text = post.text
        
        return cell
     }
}
// fixing delegate issue. (messageText.delegate = self)
extension ChatViewController:UITextViewDelegate {
    
}
 
