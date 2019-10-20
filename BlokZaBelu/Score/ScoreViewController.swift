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
    @IBOutlet weak private var addButton: UIBarButtonItem!
    
    private let maxGameScore = 1001
    
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
        
        //For Fastlane screenshots
        #if targetEnvironment(simulator)
        scores = [
            BelaScore(biddingTeam: .team2, gameScore: BelaGameScore(score1: 32), declarationsTeam1: [], declarationsTeam2: [20]),
            BelaScore(biddingTeam: .team1, gameScore: BelaGameScore(score1: 110), declarationsTeam1: [], declarationsTeam2: [50]),
            BelaScore(biddingTeam: .team2, gameScore: BelaGameScore(score1: 120), declarationsTeam1: [], declarationsTeam2: []),
            BelaScore(biddingTeam: .team1, gameScore: BelaGameScore(score1: 82), declarationsTeam1: [], declarationsTeam2: []),
            BelaScore(biddingTeam: .team2, gameScore: BelaGameScore(score1: 100), declarationsTeam1: [], declarationsTeam2: [50])
        ]
        #endif
        
        setupNavigationBar()
        
        if let previousScores = previousScores {
            scores = previousScores
        }
        
        tableView.register(UINib(nibName: "ScoreTableViewCell", bundle: nil), forCellReuseIdentifier: "ScoreTableViewCell")
    }
    
    private func setupNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    private func checkForEnd() {
        let team1Score = scores.reduce(0) { $0 + $1.totalScoreTeam1 }
        let team2Score = scores.reduce(0) { $0 + $1.totalScoreTeam2 }
        
        if team1Score >= maxGameScore && team1Score > team2Score {
            score1Label.flash()
            score2Label.stopFlash()
            addButton.isEnabled = false
        } else if team2Score >= maxGameScore && team2Score > team1Score {
            score1Label.stopFlash()
            score2Label.flash()
            addButton.isEnabled = false
        } else {
            score1Label.stopFlash()
            score2Label.stopFlash()
            addButton.isEnabled = true
        }
    }
    
    private func save(scores: [BelaScore]?) {
        let encodedScores = try? JSONEncoder().encode(scores)
        UserDefaults.standard.set(encodedScores, forKey: "scores")
    }
    
    private func presentAddScoreViewController(score: BelaScore? = nil, scoreTableViewCell: UITableViewCell? = nil) {
        let addScoreViewController = UIStoryboard.main.instantiateViewController(ofType: AddScoreViewController.self)
        addScoreViewController.delegate = self
        
        if let score = score, let scoreTableViewCell = scoreTableViewCell {
            addScoreViewController.updateBelaScore = score
            addScoreViewController.scoreTableViewCell = scoreTableViewCell
        }
        
        let presentationController = CardPresentationController(presentedViewController: addScoreViewController, presenting: self)
        presentationController.presentationDelegate = self
        addScoreViewController.modalPresentationStyle = .custom
        addScoreViewController.transitioningDelegate = presentationController
        
        present(addScoreViewController, animated: true, completion: nil)
    }
    
    private func scoresIndexFor(_ indexPath: IndexPath) -> Int {
        return BelaSettings.shared.invertScores ? scores.count - indexPath.row - 1 : indexPath.row
    }

    @IBAction private func addAction(_ sender: Any) {
        presentAddScoreViewController()
    }
    
}

extension ScoreViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ofType: ScoreTableViewCell.self, for: indexPath)
        cell.setup(for: scores[scoresIndexFor(indexPath)])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let score = scores[scoresIndexFor(indexPath)]
        let cell = tableView.cellForRow(at: indexPath)
        
        //There's sometimes a delay if I don't to this. http://openradar.appspot.com/19563577
        DispatchQueue.main.async {
            self.presentAddScoreViewController(score: score, scoreTableViewCell: cell)
        }
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .destructive, title: "delete".localized) { _, _, completionHandler in
            self.scores.remove(at: self.scoresIndexFor(indexPath))
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
        var indexPath: IndexPath
        if BelaSettings.shared.invertScores {
            indexPath = IndexPath(row: scores.count - 1, section: 0)
        } else {
            indexPath = IndexPath(row: 0, section: 0)
        }
        tableView.insertRows(at: [indexPath], with: .top)
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
    func addScoreViewControllerDidUpdate(addScoreViewController: AddScoreViewController, score: BelaScore, for scoreTableViewCell: UITableViewCell) {
        guard let indexPath = tableView.indexPath(for: scoreTableViewCell) else { return }
        
        scores[scoresIndexFor(indexPath)] = score
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
}

extension ScoreViewController: CardPresentationControllerDelegate {
    
    func cardPresentationControllerDidReceiveTapOnDimmingView(_ cardPresentationController: CardPresentationController, dimmingView: DimmingView) {
        dismiss(animated: true, completion: nil)
    }
    
}
