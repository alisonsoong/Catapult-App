//
//  TestingEmailViewController.swift
//  Catapult
//
//  Created by Alison Soong on 2/12/21.
//

import UIKit
import SwiftSMTP

//let smtp = SMTP(
//    hostname: "smtp.gmail.com",     // SMTP server address
//    email: "asoongtesting@gmail.com",        // username to login
//    password: "a1s2d3f4%"            // password to login
//
//)


class TestingEmailViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func pressedButton(_ sender: UIButton) {
        
        let user = Mail.User(name: "Name", email: "asoongtesting@gmail.com")
        let me = Mail.User(name: "Catapult Submissions", email: "asoongtesting@gmail.com")
        
        let mail = Mail(
            from: user,
            to: [me],
            subject: "Testing",
            text: "Woah"
        )

        smtp.send(mail) { (error) in
            if let error = error {
                print(error)
            }
        }
        

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

