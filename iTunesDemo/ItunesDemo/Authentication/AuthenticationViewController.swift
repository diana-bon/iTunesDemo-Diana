//
//  AuthenticationViewController.swift
//  iTunesDemo
//
//  Created by Diana Alejandra Bonilla Granados on 21/04/2019.
//  Copyright © 2019 Diana Bonilla. All rights reserved.
//

import Foundation
import UIKit

final class AuthenticationViewController: UIViewController
{
    // MARK: - Outlets
    @IBOutlet private weak var emailTextfield: UITextField?
    @IBOutlet private weak var passwordTextfield: UITextField?
    @IBOutlet private weak var loginButton: UIButton?
    @IBOutlet private weak var errorLabel: UILabel?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextfield?.delegate = self
        passwordTextfield?.delegate = self
    }
    
    private func checkAuthentication() -> Bool {
        guard let email = emailTextfield?.text, let password = passwordTextfield?.text else { return false }
        return email.isEmpty || password.isEmpty
    }
    
    // MARK: - Navigation
    @IBAction func onLoginButtonTap(_ sender: Any) {
        if checkAuthentication() {
            performSegue(withIdentifier: "showTrackList", sender: nil)
        } else {
            errorLabel?.isHidden = false
        }
    }
}

// MARK: - Textfields
extension AuthenticationViewController: UITextFieldDelegate
{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        errorLabel?.isHidden = true
    }
}
