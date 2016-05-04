//
//  LoginSignupViewController.swift
//  Journal
//
//  Created by Nathan on 5/3/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class LoginSignupViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func loginButtonTapped(sender: AnyObject) {
        UserController.authorizeUser(emailTextField.text!, password: passwordTextField.text!) { (success) in
            if success {
                self.performSegueWithIdentifier("toHomeView", sender: self)
            }
        }
    }
    
    @IBAction func signUpButtonTapped(sender: AnyObject) {
        UserController.createUser(emailTextField.text!, password: passwordTextField.text!) { (success) in
            if success {
                self.performSegueWithIdentifier("toHomeView", sender: self)
            }
        }
    }
}
