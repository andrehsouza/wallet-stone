//
//  LoginViewController.swift
//  WalletStone
//
//  Created by Andre on 11/06/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import UIKit

protocol LoginAccountProtocol {
    func didCreateAccount(email: String)
}

class LoginViewController: WSBaseViewController {
    
    @IBOutlet weak var txfEmail: WSTextField!
    @IBOutlet weak var txfPassword: WSTextField!
    @IBOutlet weak var switchAutomaticLogin: UISwitch!
    @IBOutlet weak var btLogin: UIButton!
    
    fileprivate lazy var presenter: LoginViewPresenter = LoginViewPresenter(view: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func editingChanged(_ sender: Any) {
        btLogin.isEnabled = enabledButton()
    }
    
    @IBAction func touchLogin(_ sender: Any) {
        login()
    }
    
    @IBAction func touchCreateAccount(_ sender: Any) {
        goToAccount()
    }
    
    @IBAction func unwindToLogin(segue: UIStoryboardSegue) {
        clear()
    }
    
    
}

//MARK: - Functions -

extension LoginViewController {
    
    func clear() {
        txfEmail.text = ""
        txfPassword.text = ""
        switchAutomaticLogin.isOn = false
        hideLoader()
    }
    
    func setup() {
        showLoadingView()
        switchAutomaticLogin.isOn = false
        btLogin.isEnabled = false
        checkAutoLogin()
    }
    
    func checkAutoLogin() {
        let userDefaults = UserDefaults.standard
        if userDefaults.bool(forKey: Login.isAutomatic) {
            switchAutomaticLogin.isOn = true
            guard
                let email = userDefaults.object(forKey: Login.email) as? String,
                let password = userDefaults.object(forKey: Login.password) as? String
                else { return }
            txfEmail.text = email
            txfPassword.text = password
            presenter.tryLogin(email: email, password: password, isAutomatic: switchAutomaticLogin.isOn)
        } else {
            hideFenceView()
        }
    }
    
    func login() {
        view.endEditing(true)
        guard let email = txfEmail.text, let password = txfPassword.text else { return }
        presenter.tryLogin(email: email, password: password, isAutomatic: switchAutomaticLogin.isOn)
    }
    
    func enabledButton() -> Bool {
        
        if let email = txfEmail.text, let password = txfPassword.text {
            return !email.isEmpty && !password.isEmpty
        }
        
        return false
    }
    
    func goToAccount() {
        let storyboard = UIStoryboard(type: .login)
        let viewController = storyboard.instantiateViewController() as RegisterViewController
        viewController.loginAccountProtocol = self
        show(viewController, sender: self)
    }
    
}

//MARK: - UITextFieldDelegate -

extension LoginViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let txtf = textField as? WSTextField {
            txtf.errorMessage = ""
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if txfEmail == textField {
            txfPassword.becomeFirstResponder()
        } else {
            login()
        }
        
        return false
    }
}


//MARK: - LoginViewProtocol -

extension LoginViewController: LoginViewProtocol {

    func goToHome(with customer: Customer) {
        WSUtil.shared.customer = customer
        let storyboard = UIStoryboard(type: .home)
        let navigation = storyboard.instantiateViewController() as WSNavigationController
        show(navigation, sender: self)
        
    }
    
    func showAlert(message: String) {
        showWSAlert(with: message)
    }
    
    func showLoader() {
        showLoadingView()
    }
    
    func hideLoader() {
        hideFenceView()
    }

}

//MARK: - LoginAccountProtocol -

extension LoginViewController: LoginAccountProtocol {
    
    func didCreateAccount(email: String) {
        txfEmail.text = email
        txfPassword.becomeFirstResponder()
    }

}
