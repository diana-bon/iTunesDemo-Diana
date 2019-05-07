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
    @IBOutlet private weak var loadingIndicator: UIActivityIndicatorView?
  
    var controller: AuthenticationControllerInput?
  
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextfield?.delegate = self
        passwordTextfield?.delegate = self
      
        self.controller = AuthenticationFactory.createAuthModule(view: self)
    }
  
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      self.navigationController?.isNavigationBarHidden = true
    }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "createAccountSegue" {
      if let nav = segue.destination as? UINavigationController,
        let destination = nav.children.first as? CreateAccountViewController  {
        destination.delegate = self
      }
    }
  }
    
  private func checkAuthentication(login: String, password: String) -> Bool {
      return !login.isEmpty && !password.isEmpty
    }
    
    // MARK: - Navigation
    @IBAction func onLoginButtonTap(_ sender: Any) {
      guard let login = emailTextfield?.text, let password = passwordTextfield?.text else { return }
      
      if !checkAuthentication(login: login, password: password) {
        errorLabel?.isHidden = false
      } else {
        loadingIndicator?.startAnimating()
        controller?.login(login: login, password: password)
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

extension AuthenticationViewController: AuthenticationControllerOutput
{
  func loginSuccess() {
    loadingIndicator?.stopAnimating()
    self.performSegue(withIdentifier: "showTrackList", sender: nil)
  }
  
  func displayError(_ message: String) {
    self.loadingIndicator?.stopAnimating()
    self.errorLabel?.text = message
  }
}

extension AuthenticationViewController: CreateAccountDelegate
{
  func createAcountDidFinish(login: String?) {
    self.emailTextfield?.text = login
  }
}
