//
//  LoginViewController.swift
//  DemoSwiftyCam
//
//  Created by Josh Graef on 3/30/18.
//  Copyright © 2018 Cappsule. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        errorLabel.text = nil
    }
    
    func loginUser() {
        if let email = emailTextField.text, let password = passwordTextField.text {
            
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                
                if let u = user {
                    print("\(u) user logged in!")
                    self.performSegue(withIdentifier: "goToViewController", sender: self)
                }
                else {
                    print("user not logged in!")
                    self.errorLabel.text = ("Invalid Credentials")
                }
            }
        }

    }
    @IBAction func LoginButtonTapped(_ sender: Any) {
            loginUser()
        }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    }
    

