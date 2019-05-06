//
//  CreateAccountViewController.swift
//  iTunesDemo
//
//  Created by Anou on 06/05/2019.
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
  @IBOutlet weak var loginTextfield: UITextField!
  @IBOutlet weak var passwordTextfield: UITextField!
  
  var controller: CreateAccountControllerInput?
  weak var delegate: CreateAccountDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    controller = CreateAccountFactory.createAccountModule(view: self)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.isNavigationBarHidden = false
  }
  
  private func checkCreateAccount(login: String, password: String) -> Bool {
    return !login.isEmpty || !password.isEmpty
  }
  
  @IBAction func didTapDoneButton(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }
  
  @IBAction func didTapSignupButton(_ sender: Any) {
    guard let login = loginTextfield.text, let pwd = passwordTextfield.text else { return }
    
    if !checkCreateAccount(login: login, password: pwd) {
      controller?.createAccount(login: login, password: pwd)
    }
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
  func createAccountSuccess() {
    self.dismiss(animated: true)
    delegate?.createAcountDidFinish(login: loginTextfield.text)
  }
  
  func displayError(_ message: String) {
    print(message)
  }
}
