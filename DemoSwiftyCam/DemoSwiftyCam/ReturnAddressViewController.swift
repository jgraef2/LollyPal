//
//  ReturnAddressViewController.swift
//  DemoSwiftyCam
//
//  Created by Josh Graef on 3/31/18.
//  Copyright © 2018 Cappsule. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth

class ReturnAddressViewController: UIViewController, UITextFieldDelegate {
    // on Submit button, check for valid looking info, if valid: Create a database document with the individuals name (inside the "users" collection). Inside the document with their name, add a field for their UID, address line 1, address line 2, email, and name.
    
    // WHEN WE DO PALS LIST --> A collection will be created called "pals" inside their "Name" document. Inside that collection, a document will be created for each pal using their first and last name. Inside that document there will be a field for their full name, address line 1, and address line 2.
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addressOneTextField: UITextField!
    @IBOutlet weak var addressTwoTextField: UITextField!
    
    let db = Firestore.firestore()
    
    @IBAction func submitButtonTapped(_ sender: UIButton) {
        var infoIsValid = true
        func checkValidInfo () {
            //check that name contains first and last name
            //check that addressOne contains necessary components
            //check that addressTwo has city, state, zip
        }
        
        if infoIsValid == true {
            let user = Auth.auth().currentUser
            let uid = user?.uid
            let email = user?.email
            let name = nameTextField.text
            let addressOne = addressOneTextField.text
            let addressTwo = addressTwoTextField.text
            
            db.collection("users").document("\(String(describing: email!))").setData([
                "UID": "\(String(describing: uid!))",
                "EMAIL": "\(String(describing: email!))",
                "Zname": "\(String(describing: name!))",
                "addressOne": "\(String(describing: addressOne!))",
                "addressTwo": "\(String(describing: addressTwo!))"
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
            }
            // [END set_document]

            self.performSegue(withIdentifier: "goToViewController", sender: self)
            
            print("dicks")
        }
        else {
            //print("Please check your shit")
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nameTextField.resignFirstResponder()
        addressOneTextField.resignFirstResponder()
        addressTwoTextField.resignFirstResponder()
    }
    
}
