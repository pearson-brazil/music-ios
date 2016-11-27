//
//  LoginViewController.swift
//  MusicProject
//
//  Created by Pearson on 27/11/16.
//  Copyright © 2016 Pearson. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        
        let attributes = [NSForegroundColorAttributeName: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)]

        emailTextField.attributedPlaceholder = NSMutableAttributedString(string: "Digite seu e-mail", attributes: attributes)
        passwordTextField.attributedPlaceholder = NSMutableAttributedString(string: "Digite sua senha", attributes: attributes)
        
        loginButton.layer.cornerRadius = loginButton.bounds.height/2
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        
        registerButton.layer.cornerRadius = registerButton.bounds.height/2
        registerButton.layer.borderWidth = 1
        registerButton.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
    }
    
    
    @IBAction func loginButtonTouchUpInside(_ sender: UIButton) {
        
    }
    
    @IBAction func registerButtonTouchUpInside(_ sender: UIButton) {
        
    }
    


}
