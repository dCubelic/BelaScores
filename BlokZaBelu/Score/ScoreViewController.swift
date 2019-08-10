//
//  ScoreViewController.swift
//  BlokZaBelu
//
//  Created by Dominik Cubelic on 10/08/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var score1Label: UILabel!
    @IBOutlet weak var score2Label: UILabel!
    
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
        
        addCardViewController(ofType: AddScoreViewController.self)
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
