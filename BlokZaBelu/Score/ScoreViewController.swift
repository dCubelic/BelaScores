//
//  ScoreViewController.swift
//  BlokZaBelu
//
//  Created by Dominik Cubelic on 10/08/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {

    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var score1Label: UILabel!
    @IBOutlet weak private var score2Label: UILabel!
    
    private var keyboardObserver: NSObjectProtocol?
    private var bottomConstraint: NSLayoutConstraint?
    
    deinit {
        if let keyboardObserver = keyboardObserver {
            NotificationCenter.default.removeObserver(keyboardObserver)
        }
    }
    
    var scores: [BelaScore] = [] {
        didSet {
            score1Label.text = String(scores.reduce(0) { $0 + $1.score1 })
            score2Label.text = String(scores.reduce(0) { $0 + $1.score2 })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scores = [BelaScore(score1: 120, score2: 52, trumpSuit: .hearts), BelaScore(score1: 54, score2: 124, trumpSuit: .diamonds), BelaScore(score1: 0, score2: 162, trumpSuit: .clubs)]
        
        tableView.register(UINib(nibName: "ScoreTableViewCell", bundle: nil), forCellReuseIdentifier: "ScoreTableViewCell")
        
        let cardViewController = addCardViewController(ofType: AddScoreCardViewController.self)
        
        bottomConstraint = cardViewController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        bottomConstraint?.isActive = true
        
        keyboardObserver = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillChangeFrameNotification, object: nil, queue: nil) { notification in
            if let userInfo = notification.userInfo,
                let durationValue = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber,
                let endFrameValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
                let curve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber {
                
                var responderBottomPoint = self.view.firstResponder?.convert(self.view.firstResponder?.frame.origin ?? .zero, to: self.view) ?? CGPoint.zero
                let responderHeight = self.view.firstResponder?.frame.height ?? 0
                responderBottomPoint.y += responderHeight + 15
                
                self.bottomConstraint?.constant = -max(0, responderBottomPoint.y - endFrameValue.cgRectValue.minY - (self.bottomConstraint?.constant ?? 0))
                
                UIView.animate(withDuration: durationValue.doubleValue, delay: 0, options: UIView.AnimationOptions(rawValue: UInt(curve.intValue << 16)), animations: {
                    self.view.layoutIfNeeded()
                }, completion: nil)
            }
        }
    }

    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}

extension ScoreViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ofType: ScoreTableViewCell.self, for: indexPath)
        cell.setup(for: scores[indexPath.row])
        
        return cell
    }
    
}
