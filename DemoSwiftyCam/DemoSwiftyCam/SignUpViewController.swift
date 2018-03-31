//
//  SignUpController.swift
//  DemoSwiftyCam
//
//  Created by Josh Graef on 3/29/18.
//  Copyright © 2018 Cappsule. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

//check if email is legit
extension String {
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}

class SignUpViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        errorLabel.text = nil
    }
    
    func loginUser () {
        // Do some form validation on the email and password
        if let email = emailTextField.text, let password = passwordTextField.text {
            // Email seems legit, password strong enough?
            
            Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                
                if let u = user {
                    print("\(u) user made!")
                    self.performSegue(withIdentifier: "goToReturnAddress", sender: self)
                }
                else {
                    print("user not made!")
                    if password.count > 5{
                        // make a text label that says password must be 6 characters
                        print("Password is Good!")
                    }
                    else {
                        self.errorLabel.text = "Password must be 6+ characters."
                        print("Password must be at least 6 characters")
                    }
                    
                    if email.isValidEmail() {
                        print("email is legit!")
                    }
                    else {
                        // make the error text label say "Please provide a real email"
                        self.errorLabel.text = "Please check your email."
                        print("email is bullshit!")
                    }
                }
            }
        }
    }
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        loginUser()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        loginUser()
        return false
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
}

