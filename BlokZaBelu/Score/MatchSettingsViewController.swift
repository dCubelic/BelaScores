//
//  MatchSettingsViewController.swift
//  BlokZaBelu
//
//  Created by dominik on 31/01/2020.
//  Copyright © 2020 Dominik Cubelic. All rights reserved.
//

import UIKit

protocol MatchSettingsViewControllerDelegate: class {
    func matchSettingsViewControllerDidSave(_ matchSettingsViewController: MatchSettingsViewController, matchSettings: BelaMatchSettings)
}

class MatchSettingsViewController: UIViewController {
    
    @IBOutlet weak private var team1TextField: UITextField!
    @IBOutlet weak private var team2TextField: UITextField!
    @IBOutlet weak private var maxPointsSegmentedControl: UISegmentedControl!
    @IBOutlet weak private var tieBreakerSegmentedControl: UISegmentedControl!
    @IBOutlet weak private var saveButton: UIButton!
    
    var matchSettings: BelaMatchSettings?
    weak var delegate: MatchSettingsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSettings()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupColors()
        roundCorners()
    }
    
    private func roundCorners() {
        let layer = CAShapeLayer()
        let path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: [UIRectCorner.topLeft, UIRectCorner.topRight], cornerRadii: CGSize(width: 10, height: 10))
        
        layer.path = path.cgPath
        view.layer.mask = layer
    }
    
    private func setupColors() {
        view.backgroundColor = BelaTheme.shared.backgroundColor2

        maxPointsSegmentedControl.backgroundColor = BelaTheme.shared.backgroundColor2
        
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        maxPointsSegmentedControl.setTitleTextAttributes(titleTextAttributes, for: .selected)

        let titleTextAttributes2 = [NSAttributedString.Key.foregroundColor: BelaTheme.shared.textColor]
        maxPointsSegmentedControl.setTitleTextAttributes(titleTextAttributes2, for: .normal)
    }
    
    private func setupSettings() {
        guard let matchSettings = matchSettings else { return }
        switch matchSettings.maxGameScore {
        case .fiveHundredOne:
            maxPointsSegmentedControl.selectedSegmentIndex = 0
        case .thousandOne:
            maxPointsSegmentedControl.selectedSegmentIndex = 1
        default:
            break
        }
        
        switch matchSettings.tieBreaker {
        case .moreOrEqual:
            tieBreakerSegmentedControl.selectedSegmentIndex = 0
        case .moreThan:
            tieBreakerSegmentedControl.selectedSegmentIndex = 1
        }
    }

    @IBAction private func maxPointsChanged(_ sender: Any) {
        var maxScore: BelaMaxMatchScore = .fiveHundredOne
        switch maxPointsSegmentedControl.selectedSegmentIndex {
        case 0:
            maxScore = .fiveHundredOne
        case 1:
            maxScore = .thousandOne
        default:
            break
        }
        matchSettings?.maxGameScore = maxScore
    }
    
    @IBAction private func tieBreakerChanged(_ sender: Any) {
        var tieBreaker: BelaTieBreaker = .moreOrEqual
        switch tieBreakerSegmentedControl.selectedSegmentIndex {
        case 0:
            tieBreaker = .moreOrEqual
        case 1:
            tieBreaker = .moreThan
        default:
            break
        }
        matchSettings?.tieBreaker = tieBreaker
    }
    
    @IBAction private func saveAction(_ sender: Any) {
        guard let matchSettings = matchSettings else { return }
        delegate?.matchSettingsViewControllerDidSave(self, matchSettings: matchSettings)
        dismiss(animated: true, completion: nil)
    }
}
