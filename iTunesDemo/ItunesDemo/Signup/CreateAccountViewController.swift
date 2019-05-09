//
//  CreateAccountViewController.swift
//  iTunesDemo
//
//  Created by Diana Alejandra Bonilla Granados on 06/05/2019.
//  Copyright © 2019 Diana Bonilla. All rights reserved.
//

import Foundation
import UIKit

protocol CreateAccountDelegate: class
{
  func createAcountDidFinish(login: String?)
}

class CreateAccountViewController: UITableViewController
{
  @IBOutlet private weak var loadingIndicator: UIActivityIndicatorView?
  @IBOutlet private weak var loginTextfield: UITextField?
  @IBOutlet private weak var passwordTextfield: UITextField?
  @IBOutlet private weak var errorLabel: UILabel?
  
  var controller: CreateAccountControllerInput?
  weak var delegate: CreateAccountDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    controller = CreateAccountFactory.createAccountModule(view: self)
    
    let closeKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
    self.view.addGestureRecognizer(closeKeyboardGesture)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.isNavigationBarHidden = false
  }
  
  @objc private func closeKeyboard() {
    loginTextfield?.resignFirstResponder()
    passwordTextfield?.resignFirstResponder()
  }
  
  @IBAction func didTapDoneButton(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }
  
  @IBAction func didTapSignupButton(_ sender: Any) {
    guard let login = loginTextfield?.text, let pwd = passwordTextfield?.text else { return }
    
    guard !login.isEmpty || !pwd.isEmpty else {
      errorLabel?.isHidden = false
      return
    }
    
    loadingIndicator?.startAnimating()
    controller?.createAccount(login: login, password: pwd)
  }
}

extension CreateAccountViewController: UITextFieldDelegate
{
  func textFieldDidBeginEditing(_ textField: UITextField) {
    errorLabel?.isHidden = true
  }
}

extension CreateAccountViewController
{
  override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return CGFloat.leastNonzeroMagnitude
  }
}

extension CreateAccountViewController: CreateAccountControllerOutput
{
  func createAccountSuccess(email: String?) {
    self.loadingIndicator?.stopAnimating()
    self.dismiss(animated: true)
    delegate?.createAcountDidFinish(login: email)
  }
  
  func displayError(_ message: String) {
    self.loadingIndicator?.stopAnimating()
    errorLabel?.isHidden = false
    errorLabel?.text = message
  }
}
