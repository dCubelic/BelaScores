//
//  AddScoreViewController.swift
//  BlokZaBelu
//
//  Created by dominik on 10/08/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import UIKit

class AddScoreViewController: UIViewController {

    @IBOutlet weak private var points1TextField: UITextField!
    @IBOutlet weak private var points2TextField: UITextField!
    @IBOutlet weak private var points1UnderlineView: UIView!
    @IBOutlet weak private var points2UnderlineView: UIView!
    @IBOutlet weak private var addButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    private func setupViews() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        view.addGestureRecognizer(tapGesture)
        
        points1TextField.delegate = self
        points2TextField.delegate = self
        points1TextField.attributedPlaceholder = NSAttributedString(string: "0", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        points2TextField.attributedPlaceholder = NSAttributedString(string: "0", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
        points1UnderlineView.layer.cornerRadius = points1UnderlineView.frame.height / 2
        points2UnderlineView.layer.cornerRadius = points2UnderlineView.frame.height / 2
        addButton.layer.cornerRadius = addButton.frame.height / 2
    }
    
    @objc private func tapAction() {
        view.endEditing(true)
    }
    
    @IBAction private func addAction(_ sender: Any) {
        
    }
    
}

extension AddScoreViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}
