//
//  RegisterViewController.swift
//  WalletStone
//
//  Created by Andre on 11/06/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import UIKit

class RegisterViewController: WSBaseViewController {
    
    @IBOutlet weak var txfName: WSTextField!
    @IBOutlet weak var txfEmail: WSTextField!
    @IBOutlet weak var txfPassword: WSTextField!
    @IBOutlet weak var txfConfirmPassword: WSTextField!
    @IBOutlet weak var btRegister: UIButton!
    
    private var registerFields: [UITextField] = []
    var loginAccountProtocol: LoginAccountProtocol?
    
    fileprivate lazy var presenter: RegisterViewPresenter = RegisterViewPresenter(view: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initFieldArrays()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func touchRegister(_ sender: Any) {
        register()
    }
    

}

//MARK: - Functions -

extension RegisterViewController {
    
    func initFieldArrays() {
        registerFields = [txfName, txfEmail, txfPassword, txfConfirmPassword]
    }
    
    func isFormOk() -> Bool {
        
        var isValid: Bool = true
        
        registerFields.forEach() { txtf in
            if let text = txtf.text, text.isEmpty {
                isValid = false
                (txtf as! WSTextField).errorMessage = "Campo obrigatório"
            }
        }
        
        if let email = txfEmail.text, !email.isValidEmail() {
            txfEmail.errorMessage = "E-mail inválido"
            isValid = false
        } else if txfPassword.text != txfConfirmPassword.text {
            txfPassword.errorMessage = "As senhas precisam ser iguais"
            txfConfirmPassword.errorMessage = "As senhas precisam ser iguais"
            isValid = false
        }
        
        return isValid
    }
    
}

//MARK: - UITextFieldDelegate -

extension RegisterViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let txtf = textField as? WSTextField {
            txtf.errorMessage = ""
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let pos = registerFields.index(of: textField) ?? 0
        if pos < registerFields.count - 1 {
            registerFields[pos+1].becomeFirstResponder()
        } else {
            register()
        }
        
        return false
    }
    
}

//MARK: - RegisterViewProtocol -

extension RegisterViewController: RegisterViewProtocol {
    
    func register() {
        
        view.endEditing(true)
        
        if isFormOk() {
            guard
                let name = txfName.text,
                let email = txfEmail.text,
                let password = txfPassword.text
                else { return }
            
            showLoadingView()
            presenter.register(name, email, password)
        }
    }
    
    func goToLogin(with email: String) {
        loginAccountProtocol?.didCreateAccount(email: email)
        navigationController?.popViewController(animated: true)
    }
    
}
