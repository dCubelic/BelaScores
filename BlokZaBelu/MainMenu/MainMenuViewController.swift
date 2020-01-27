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
    @IBOutlet weak private var newGameButton: UIButton!
    @IBOutlet weak private var settingsButton: UIButton!
    @IBOutlet weak private var historyButton: UIButton!
    @IBOutlet weak private var logoImageView: UIImageView!
    
    private var historyMatches: [BelaMatch]? {
        guard let encodedMatches = UserDefaults.standard.data(forKey: "matches") else { return nil }
        return try? JSONDecoder().decode([BelaMatch].self, from: encodedMatches)
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
        logoImageView.tintColor = BelaTheme.shared.themeColor
        
        setupButtons()
    }
    
    private func setupButtons() {
        newGameButton.tintColor = BelaTheme.shared.textColor
        historyButton.tintColor = BelaTheme.shared.textColor
        settingsButton.tintColor = BelaTheme.shared.textColor
    }
    
    private func setupViews() {
        appTitleLabel.text = "app.title".localized
        newGameButton.layer.cornerRadius = newGameButton.frame.height / 2
        settingsButton.layer.cornerRadius = settingsButton.frame.height / 2
    }
    
    @IBAction private func newGameAction(_ sender: Any) {
        let scoreViewController = UIStoryboard.main.instantiateViewController(ofType: ScoreViewController.self)
        navigationController?.pushViewController(scoreViewController, animated: true)
    }
    
    @IBAction private func settingsAction(_ sender: Any) {
        let settingsViewControler = UIStoryboard.main.instantiateViewController(ofType: SettingsViewController.self)
        navigationController?.pushViewController(settingsViewControler, animated: true)
    }
    
    @IBAction private func historyAction(_ sender: Any) {
        let historyViewController = UIStoryboard.main.instantiateViewController(ofType: HistoryViewController.self)
        navigationController?.pushViewController(historyViewController, animated: true)
    }
}

extension UINavigationController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
}
