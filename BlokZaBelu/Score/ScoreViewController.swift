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
    @IBOutlet weak private var weLabel: UILabel!
    @IBOutlet weak private var theyLabel: UILabel!
    @IBOutlet weak private var separatorView: UIView!
        
    private var matchScore: BelaMatchScore = BelaMatchScore.newMatch {
        didSet {
            score1Label.text = String(matchScore.team1Score)
            score2Label.text = String(matchScore.team2Score)
            
            save(matchScore: matchScore)
            checkForEnd()
        }
    }
    
    var previousScores: BelaMatchScore?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return BelaTheme.shared.statusBarStyle
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //For Fastlane screenshots
        #if targetEnvironment(simulator)
        matchScore = BelaMatchScore.dummyMatch
        #endif
        
        setupNavigationBar()
        
        if let previousScores = previousScores {
            matchScore = previousScores
        }
        
        tableView.register(UINib(nibName: "ScoreTableViewCell", bundle: nil), forCellReuseIdentifier: "ScoreTableViewCell")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupColors()
    }
    
    private func setupNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    private func setupColors() {
        view.backgroundColor = BelaTheme.shared.backgroundColor
        tableView.backgroundColor = BelaTheme.shared.backgroundColor
        addButton.tintColor = BelaTheme.shared.textColor
        score1Label.textColor = BelaTheme.shared.themeColor
        score2Label.textColor = BelaTheme.shared.themeColor
        weLabel.textColor = BelaTheme.shared.textColor
        theyLabel.textColor = BelaTheme.shared.textColor
        separatorView.backgroundColor = BelaTheme.shared.themeColor
    }
    
    private func checkForEnd() {
        let team1Score = matchScore.team1Score
        let team2Score = matchScore.team2Score
        
        if team1Score >= matchScore.maxGameScore && team1Score > team2Score {
            score1Label.flash()
            score2Label.stopFlash()
            addButton.isEnabled = false
        } else if team2Score >= matchScore.maxGameScore && team2Score > team1Score {
            score1Label.stopFlash()
            score2Label.flash()
            addButton.isEnabled = false
        } else {
            score1Label.stopFlash()
            score2Label.stopFlash()
            addButton.isEnabled = true
        }
    }
    
    private func save(matchScore: BelaMatchScore?) {
        let encodedScores = try? JSONEncoder().encode(matchScore)
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
        return BelaSettings.shared.invertScores ? matchScore.scores.count - indexPath.row - 1 : indexPath.row
    }

    @IBAction private func addAction(_ sender: Any) {
        presentAddScoreViewController()
    }
    
}

extension ScoreViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchScore.scores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ofType: ScoreTableViewCell.self, for: indexPath)
        cell.setup(for: matchScore.scores[scoresIndexFor(indexPath)])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let score = matchScore.scores[scoresIndexFor(indexPath)]
        let cell = tableView.cellForRow(at: indexPath)
        
        //There's sometimes a delay if I don't to this. http://openradar.appspot.com/19563577
        DispatchQueue.main.async {
            self.presentAddScoreViewController(score: score, scoreTableViewCell: cell)
        }
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .destructive, title: "delete".localized) { _, _, completionHandler in
            self.matchScore.scores.remove(at: self.scoresIndexFor(indexPath))
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
        matchScore.scores.insert(score, at: 0)
        var indexPath: IndexPath
        if BelaSettings.shared.invertScores {
            indexPath = IndexPath(row: matchScore.scores.count - 1, section: 0)
        } else {
            indexPath = IndexPath(row: 0, section: 0)
        }
        tableView.insertRows(at: [indexPath], with: .top)
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
    func addScoreViewControllerDidUpdate(addScoreViewController: AddScoreViewController, score: BelaScore, for scoreTableViewCell: UITableViewCell) {
        guard let indexPath = tableView.indexPath(for: scoreTableViewCell) else { return }
        
        matchScore.scores[scoresIndexFor(indexPath)] = score
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
}

extension ScoreViewController: CardPresentationControllerDelegate {
    
    func cardPresentationControllerDidReceiveTapOnDimmingView(_ cardPresentationController: CardPresentationController, dimmingView: DimmingView) {
        dismiss(animated: true, completion: nil)
    }
    
}
