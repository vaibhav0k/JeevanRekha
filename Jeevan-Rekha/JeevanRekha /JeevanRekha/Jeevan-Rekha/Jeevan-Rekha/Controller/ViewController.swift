//
//  ViewController.swift
//  JeevanRekha
//
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var GSButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        GSButton.layer.cornerRadius = 8
        GSButton.clipsToBounds = true
    }


}

