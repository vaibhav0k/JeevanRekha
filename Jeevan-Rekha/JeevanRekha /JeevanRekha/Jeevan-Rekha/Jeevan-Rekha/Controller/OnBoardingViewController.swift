//
//  OnBoardingViewController.swift
//  JeevanRekha
//
//

import UIKit

class OnBoardingViewController: UIViewController {

    @IBOutlet var logInButton: UIButton!
    @IBOutlet var signInButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        logInButton.layer.cornerRadius = 8
        signInButton.layer.cornerRadius = 8
        logInButton.clipsToBounds = true
        signInButton.clipsToBounds = true
    }
    

}
