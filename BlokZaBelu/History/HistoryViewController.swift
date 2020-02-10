//
//  HistoryViewController.swift
//  BlokZaBelu
//
//  Created by dominik on 28/11/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {
    
    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var noScoresLabel: UILabel!
    
    var matches: [BelaMatch] = []
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return BelaTheme.shared.statusBarStyle
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupViews()
                
        tableView.register(UINib(nibName: "HistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "HistoryTableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        matches = loadMatches().sorted { $0.dateCreated > $1.dateCreated }
        noScoresLabel.isHidden = !matches.isEmpty
        tableView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupColors()
    }
    
    private func loadMatches() -> [BelaMatch] {
//        //For Fastlane screenshots
//        #if targetEnvironment(simulator)
//        return [
//            BelaMatch.randomDummyMatch(team1Name: .custom("Ted Joey"), team2Name: .custom("Russ Michael")),
//            BelaMatch.randomDummyMatch(team1Name: .custom("Mike Gina"), team2Name: .custom("Monica Robin")),
//            BelaMatch.randomDummyMatch(team1Name: .custom("Phoebe Harvey"), team2Name: .custom("Elliot Chandler")),
//            BelaMatch.randomDummyMatch(team1Name: .custom("Darlene Richard"), team2Name: .custom("Jake Angela")),
//            BelaMatch.randomDummyMatch()
//        ]
//        #endif
        
        guard let encodedMatches = UserDefaults.standard.data(forKey: "matches"),
            let matches = try? JSONDecoder().decode([BelaMatch].self, from: encodedMatches) else { return [] }
        return matches
    }
    
    private func setupNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    private func setupColors() {
        view.backgroundColor = BelaTheme.shared.backgroundColor
        tableView.backgroundColor = BelaTheme.shared.backgroundColor
        noScoresLabel.textColor = BelaTheme.shared.textColor
    }
    
    private func setupViews() {
        noScoresLabel.text = "no.scores".localized
    }

}

extension HistoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ofType: HistoryTableViewCell.self, for: indexPath)
        cell.setup(with: matches[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let scoreViewController = UIStoryboard.main.instantiateViewController(ofType: ScoreViewController.self)
        scoreViewController.previousScores = matches[indexPath.row]
        
        navigationController?.pushViewController(scoreViewController, animated: true)
    }
}
