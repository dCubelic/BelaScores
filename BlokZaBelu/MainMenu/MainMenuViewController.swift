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
    
    private var continueScores: [BelaScore]? {
        guard let encodedScores = UserDefaults.standard.data(forKey: "scores") else { return nil }
        return try? JSONDecoder().decode([BelaScore].self, from: encodedScores)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupButtons()
    }
    
    private func setupButtons() {
        settingsButton.isHidden = true
        
        if continueScores == nil {
            continueButton.isEnabled = false
            continueButton.backgroundColor = .darkGray2
        } else {
            continueButton.isEnabled = true
            continueButton.backgroundColor = .lightGray
        }
    }
    
    private func setupViews() {
        continueButton.layer.cornerRadius = continueButton.frame.height / 2
        newGameButton.layer.cornerRadius = newGameButton.frame.height / 2
        settingsButton.layer.cornerRadius = settingsButton.frame.height / 2
    }

    @IBAction private func continueAction(_ sender: Any) {
        if let scores = continueScores {
            
            let scoreViewController = UIStoryboard.main.instantiateViewController(ofType: ScoreViewController.self)
            scoreViewController.previousScores = scores
            
            navigationController?.pushViewController(scoreViewController, animated: true)
        }
    }
    
    @IBAction private func newGameAction(_ sender: Any) {
        let scoreViewController = UIStoryboard.main.instantiateViewController(ofType: ScoreViewController.self)
        navigationController?.pushViewController(scoreViewController, animated: true)
    }
    
    @IBAction private func settingsAction(_ sender: Any) {
        
    }
    
}
