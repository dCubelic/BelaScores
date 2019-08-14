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
    
    private var addScoreViewController: AddScoreViewController?
    
    private let maxGameScore = 1001
    
    deinit {
        if let keyboardObserver = keyboardObserver {
            NotificationCenter.default.removeObserver(keyboardObserver)
        }
    }
    
    private var scores: [BelaScore] = [] {
        didSet {
            score1Label.text = String(scores.reduce(0) { $0 + $1.totalScoreTeam1 })
            score2Label.text = String(scores.reduce(0) { $0 + $1.totalScoreTeam2 })
            
            save(scores: scores)
            checkForEnd()
        }
    }
    
    var previousScores: [BelaScore]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        
        if let previousScores = previousScores {
            scores = previousScores
        }
        
        tableView.register(UINib(nibName: "ScoreTableViewCell", bundle: nil), forCellReuseIdentifier: "ScoreTableViewCell")
        
        let addScoreViewController = UIStoryboard.main.instantiateViewController(ofType: AddScoreViewController.self)
        addScoreViewController.delegate = self
        addCardViewController(addScoreViewController)
        self.addScoreViewController = addScoreViewController
        
        bottomConstraint = addScoreViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
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
    
    private func setupNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    private func checkForEnd() {
        if (scores.reduce(0) { $0 + $1.totalScoreTeam1 }) >= maxGameScore || // swiftlint:disable:this control_statement
            (scores.reduce(0) { $0 + $1.totalScoreTeam2 }) >= maxGameScore {
            save(scores: nil)
            addScoreViewController?.view.isHidden = true
        }
    }
    
    private func save(scores: [BelaScore]?) {
        let encodedScores = try? JSONEncoder().encode(scores)
        UserDefaults.standard.set(encodedScores, forKey: "scores")
    }

    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}

extension ScoreViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ofType: ScoreTableViewCell.self, for: indexPath)
        cell.setup(for: scores[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let score = scores[indexPath.row]
        let cell = tableView.cellForRow(at: indexPath)
        
        addScoreViewController?.setup(for: score, scoreTableViewCell: cell)
        addScoreViewController?.openCard()
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .destructive, title: "Obriši") { _, _, completionHandler in
            self.scores.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            
            completionHandler(true)
        }
        delete.backgroundColor = .red
        
        let config = UISwipeActionsConfiguration(actions: [delete])
        config.performsFirstActionWithFullSwipe = false
        
        return config
    }
}

extension ScoreViewController: AddScoreViewControllerDelegate {
    
    func addScoreViewControllerDidAdd(addScoreViewController: AddScoreViewController, score: BelaScore) {
        scores.insert(score, at: 0)
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .top)
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
    
    func addScoreViewControllerDidUpdate(addScoreViewController: AddScoreViewController, score: BelaScore, for scoreTableViewCell: UITableViewCell) {
        guard let indexPath = tableView.indexPath(for: scoreTableViewCell) else { return }
        
        scores[indexPath.row] = score
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
}
