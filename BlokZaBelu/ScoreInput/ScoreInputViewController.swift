//
//  ScoreInputViewController.swift
//  BlokZaBelu
//
//  Created by Dominik Cubelic on 12/08/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import UIKit

struct Score {
    var score1: Int = 0
    var score2: Int = 0
    
    static let total = 162
}

class ScoreInputViewController: UIViewController {
    
    @IBOutlet weak private var points1TextField: UITextField!
    @IBOutlet weak private var points2TextField: UITextField!
    @IBOutlet weak private var points1UnderlineView: UIView!
    @IBOutlet weak private var points2UnderlineView: UIView!
    
    var score = Score() {
        didSet {
            points1TextField.text = String(score.score1)
            points2TextField.text = String(score.score2)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    private func setupViews() {
        points1TextField.delegate = self
        points2TextField.delegate = self
        points1TextField.attributedPlaceholder = NSAttributedString(string: "0", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        points2TextField.attributedPlaceholder = NSAttributedString(string: "0", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
        points1UnderlineView.layer.cornerRadius = points1UnderlineView.frame.height / 2
        points2UnderlineView.layer.cornerRadius = points2UnderlineView.frame.height / 2
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
        
        let intValue = Int(newText) ?? 0
        
        if textField == points1TextField {
            score.score1 = intValue
            score.score2 = max(0, Score.total - intValue)
        } else if textField == points2TextField {
            score.score2 = intValue
            score.score1 = max(0, Score.total - intValue)
        }
        
        return false
    }
}
