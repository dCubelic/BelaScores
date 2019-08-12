//
//  AddScoreViewController.swift
//  BlokZaBelu
//
//  Created by dominik on 10/08/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import UIKit

class AddScoreViewController: UIViewController {

    @IBOutlet weak private var addButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    private func setupViews() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        view.addGestureRecognizer(tapGesture)
        
        addButton.layer.cornerRadius = addButton.frame.height / 2
    }
    
    @objc private func tapAction() {
        view.endEditing(true)
    }
    
    @IBAction private func addAction(_ sender: Any) {
        
    }
    
}
