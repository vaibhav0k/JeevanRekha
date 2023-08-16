//
//  SignInViewController.swift
//  JeevanRekha
//
//

import UIKit


class SignInViewController: UIViewController {

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var phoneNoTextField: UITextField!
    @IBOutlet var PasswordTextField: UITextField!
    @IBOutlet var confirmPassTextField: UITextField!
    @IBOutlet var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameTextField.layer.cornerRadius = 8
        emailTextField.layer.cornerRadius = 8
        phoneNoTextField.layer.cornerRadius = 8
        PasswordTextField.layer.cornerRadius = 8
        confirmPassTextField.layer.cornerRadius = 8
        nextButton.layer.cornerRadius = 8
        nameTextField.clipsToBounds = true
        emailTextField.clipsToBounds = true
        phoneNoTextField.clipsToBounds = true
        PasswordTextField.clipsToBounds = true
        confirmPassTextField.clipsToBounds = true
        nextButton.clipsToBounds = true
        emailTextField.setLeftPadding()
        PasswordTextField.setLeftPadding()
        phoneNoTextField.setLeftPadding()
        nameTextField.setLeftPadding()
        confirmPassTextField.setLeftPadding()
        self.ideKeyboardWhenTappedAround()
    }
    
    func validateEntry()->String{
        
        let userEmail = emailTextField.text
        let userName = nameTextField.text
        let userPassword = PasswordTextField.text
        let phno = phoneNoTextField.text
        let confPass = confirmPassTextField.text
        
        if (userName!.isEmpty || userPassword!.isEmpty || userEmail!.isEmpty || phno!.isEmpty){
            return("Empty Textfield")
        }
        if !(userEmail?.contains("@") ?? true){
            return("Invalid E-Mail ID")
        }
        
        if phno?.count ?? 10 != 10{
            return("Invalid Phone number")
        }
        
        if userPassword?.count ?? 9 < 7{
            return("Invalid Password")
        }
        
        if confPass != userPassword{
            return("Password and confirm password are not matching")
        }
        return("No Issues")
        
    }

    @IBAction func NextButton(_ sender: Any) {
        let message = validateEntry()
        if message != "No Issues"{
            showPopUp(title: "", message: message)
        }
        else{
            UserDefaults.standard.set(emailTextField.text, forKey: Constants.DefaultKeys.mail)
            UserDefaults.standard.set(PasswordTextField.text,forKey: Constants.DefaultKeys.password)
            UserDefaults.standard.set(phoneNoTextField.text, forKey: Constants.DefaultKeys.phno)
            UserDefaults.standard.set(nameTextField.text, forKey: Constants.DefaultKeys.name)
            UserDefaults.standard.set("100001",forKey: Constants.DefaultKeys.id)
            UserDefaults.standard.set(true,forKey: Constants.DefaultKeys.loginStatus)
        }
    }
    
    
    
}



extension UIViewController {
    func ideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.hideKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}
