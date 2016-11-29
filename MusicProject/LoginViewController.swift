//
//  LoginViewController.swift
//  MusicProject
//
//  Created by Pearson on 27/11/16.
//  Copyright © 2016 Pearson. All rights reserved.
//

import UIKit
import Firebase

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
        if isValid() {
            FIRAuth.auth()?.signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
                if error != nil {
                    
                    var alertMessage = ""
                    switch (error as! NSError).code {
                    case FIRAuthErrorCode.errorCodeWrongPassword.rawValue:
                        alertMessage = "Senha incorreta."
                        break
                    case FIRAuthErrorCode.errorCodeUserDisabled.rawValue:
                        alertMessage = "Sua conta está desativada. Crie uma nova conta."
                        break
                    default:
                        alertMessage = "Um erro inesperado aconteceu. Tente novamente mais tarde."
                        break
                    }
                    let alert = UIAlertController(title: "Erro", message: alertMessage, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                }else{
                    self.performSegue(withIdentifier: "ShowHomeScreenSegue", sender: self)
                }
                
                
            }
        }
    }
    
    @IBAction func registerButtonTouchUpInside(_ sender: UIButton) {
        if isValid() {
            FIRAuth.auth()?.createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
                
                if error != nil {
                    
                    var alertMessage = ""
                    switch (error as! NSError).code {
                    case FIRAuthErrorCode.errorCodeInvalidEmail.rawValue:
                        alertMessage = "E-mail inválido."
                        break
                    case FIRAuthErrorCode.errorCodeEmailAlreadyInUse.rawValue:
                        alertMessage = "E-mail já está em uso."
                        break
                    case FIRAuthErrorCode.errorCodeWeakPassword.rawValue:
                        alertMessage = "Sua senha é muito fraca. Por favor registre outra"
                        break
                    default:
                        alertMessage = "Um erro inesperado aconteceu. Tente novamente mais tarde."
                        break
                    }
                    let alert = UIAlertController(title: "Erro", message: alertMessage, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                }else{
                    let alert = UIAlertController(title: "Sucesso", message: "Você foi cadastrado com sucesso!", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                        self.performSegue(withIdentifier: "ShowHomeScreenSegue", sender: self)
                    }
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                }
                
            }
        }
    }
    
    func isValid() -> Bool {
        if (emailTextField.text?.isEmpty)! || (passwordTextField.text?.isEmpty)! {
            let alert = UIAlertController(title: "Atenção", message: "Todos os campos são obrigatórios. Preencha todos os campos.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
            
            return false
        }
        
        return true
    }
    
    func login() {
        FIRAuth.auth()?.signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error != nil {
                
                var alertMessage = ""
                switch (error as! NSError).code {
                case FIRAuthErrorCode.errorCodeWrongPassword.rawValue:
                    alertMessage = "Senha incorreta."
                    break
                case FIRAuthErrorCode.errorCodeUserDisabled.rawValue:
                    alertMessage = "Sua conta está desativada. Crie uma nova conta."
                    break
                default:
                    alertMessage = "Um erro inesperado aconteceu. Tente novamente mais tarde."
                    break
                }
                let alert = UIAlertController(title: "Erro", message: alertMessage, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            }
        
        
        }
    }
    
    
    


}
