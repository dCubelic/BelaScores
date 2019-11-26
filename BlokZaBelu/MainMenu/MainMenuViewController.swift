//
//  MainMenuViewController.swift
//  BlokZaBelu
//
//  Created by Dominik Cubelic on 10/08/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {

    @IBOutlet weak private var appTitleLabel: UILabel!
    @IBOutlet weak private var continueButton: UIButton!
    @IBOutlet weak private var newGameButton: UIButton!
    @IBOutlet weak private var settingsButton: UIButton!
    @IBOutlet weak private var historyButton: UIButton!
    @IBOutlet weak private var logoImageView: UIImageView!
    
    private var continueScores: BelaMatchScore? {
        guard let encodedScores = UserDefaults.standard.data(forKey: "scores") else { return nil }
        return try? JSONDecoder().decode(BelaMatchScore.self, from: encodedScores)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return BelaTheme.shared.statusBarStyle
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        navigationController?.navigationBar.barTintColor = BelaTheme.shared.backgroundColor
        navigationController?.navigationBar.tintColor = BelaTheme.shared.textColor
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupViews()
        setupColors()
    }
    
    private func setupColors() {
        view.backgroundColor = BelaTheme.shared.backgroundColor
        appTitleLabel.textColor = BelaTheme.shared.textColor
        logoImageView.image = UIImage(named: BelaTheme.shared.logoName)
        
        setupButtons()
    }
    
    private func setupButtons() {
        continueButton.tintColor = BelaTheme.shared.textColor
        newGameButton.tintColor = BelaTheme.shared.textColor
        historyButton.tintColor = BelaTheme.shared.textColor
        settingsButton.tintColor = BelaTheme.shared.textColor
        
        if continueScores == nil {
            continueButton.isEnabled = false
            continueButton.alpha = 0.5
        } else {
            continueButton.isEnabled = true
            continueButton.alpha = 1.0
        }
    }
    
    private func setupViews() {
        appTitleLabel.text = "app.title".localized
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
        let settingsViewControler = UIStoryboard.main.instantiateViewController(ofType: SettingsViewController.self)
        navigationController?.pushViewController(settingsViewControler, animated: true)
    }
    
    @IBAction func historyAction(_ sender: Any) {
        
    }
}

extension UINavigationController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
}
