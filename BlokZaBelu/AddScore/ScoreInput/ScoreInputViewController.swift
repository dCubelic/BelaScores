//
//  ScoreInputViewController.swift
//  BlokZaBelu
//
//  Created by Dominik Cubelic on 12/08/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import BelaDetectorFramework
import UIKit

class ScoreInputViewController: UIViewController {
    
    @IBOutlet weak private var points1TextField: UITextField!
    @IBOutlet weak private var points2TextField: UITextField!
    @IBOutlet weak private var points1UnderlineView: UIView!
    @IBOutlet weak private var points2UnderlineView: UIView!
    
    private var activeDetectorTeam: BelaTeam?
    
    var score: BelaGameScore? {
        didSet {
            guard let score = score else {
                points1TextField.text = ""
                points2TextField.text = ""
                return
            }
            points1TextField.text = String(score.score1)
            points2TextField.text = String(score.score2)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    func reset() {
        score = nil
    }
    
    private func setupViews() {
        points1TextField.delegate = self
        points2TextField.delegate = self
        points1TextField.attributedPlaceholder = NSAttributedString(string: "0", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        points2TextField.attributedPlaceholder = NSAttributedString(string: "0", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
        points1UnderlineView.layer.cornerRadius = points1UnderlineView.frame.height / 2
        points2UnderlineView.layer.cornerRadius = points2UnderlineView.frame.height / 2
    }
    
    @IBAction private func camera1Action(_ sender: Any) {
        runDetector(for: .team1)
    }
    
    @IBAction private func camera2Action(_ sender: Any) {
        runDetector(for: .team2)
    }
    
    private func runDetector(for team: BelaTeam) {
        let detector = BelaDetectorViewController.instantiateFromStoryboard()
        detector.delegate = self
        
        activeDetectorTeam = team
        
        present(detector, animated: true, completion: nil)
    }
    
    private func setScore(points: Int, for team: BelaTeam) {
        if score == nil {
            score = BelaGameScore()
        }
        
        switch team {
        case .team1:
            score?.score1 = points
            score?.score2 = max(0, BelaGameScore.total - points)
        case .team2:
            score?.score2 = points
            score?.score1 = max(0, BelaGameScore.total - points)
        }
    }
}

extension ScoreInputViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text as NSString? else { return true }
        
        let newText = text.replacingCharacters(in: range, with: string)
        
        let intValue = max(0, Int(newText) ?? 0)
        
        if textField == points1TextField {
            setScore(points: intValue, for: .team1)
        } else if textField == points2TextField {
            setScore(points: intValue, for: .team2)
        }
        
        return false
    }
    
}

extension ScoreInputViewController: BelaDetectorViewControllerDelegate {
    
    func belaDetectorViewControllerDidFinishScanning(_ belaDetectorViewController: BelaDetectorViewController, points: Int) {
        guard let team = activeDetectorTeam else { return }
        
        setScore(points: points, for: team)
    }

}
