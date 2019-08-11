//
//  MainMenuViewController.swift
//  BlokZaBelu
//
//  Created by Dominik Cubelic on 10/08/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {

    @IBOutlet weak private var continueButton: UIButton!
    @IBOutlet weak private var newGameButton: UIButton!
    @IBOutlet weak private var settingsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    private func setupViews() {
        continueButton.layer.cornerRadius = continueButton.frame.height / 2
        newGameButton.layer.cornerRadius = newGameButton.frame.height / 2
        settingsButton.layer.cornerRadius = settingsButton.frame.height / 2
    }

    @IBAction private func continueAction(_ sender: Any) {
        
    }
    
    @IBAction private func newGameAction(_ sender: Any) {
        let scoreViewController = UIStoryboard.main.instantiateViewController(ofType: ScoreViewController.self)
        navigationController?.pushViewController(scoreViewController, animated: true)
    }
    
    @IBAction private func settingsAction(_ sender: Any) {
        
    }
    
}
