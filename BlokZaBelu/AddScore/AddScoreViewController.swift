//
//  AddScoreViewController.swift
//  BlokZaBelu
//
//  Created by dominik on 10/08/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import UIKit

protocol AddScoreViewControllerDelegate: class {
    func addScoreViewControllerDidAdd(addScoreViewController: AddScoreViewController, score: BelaScore)
}

class AddScoreViewController: UIViewController {

    @IBOutlet weak private var addButton: UIButton!
    @IBOutlet weak var touchView: UIView!
    
    var biddingTeamViewController: BiddingTeamViewController?
    var scoreInputViewController: ScoreInputViewController?
    var declarationViewController: DeclarationsViewController?
    var declarationsViewController2: DeclarationsViewController?
    
    weak var delegate: AddScoreViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "BiddingTeamViewController":
            biddingTeamViewController = segue.destination as? BiddingTeamViewController
        case "ScoreInputViewController":
            scoreInputViewController = segue.destination as? ScoreInputViewController
        case "DeclarationsViewController":
            declarationViewController = segue.destination as? DeclarationsViewController
        case "Declarations2ViewController":
            declarationsViewController2 = segue.destination as? DeclarationsViewController
        default:
            break
        }
    }
    
    private func setupViews() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        touchView.addGestureRecognizer(tapGesture)
        
        addButton.layer.cornerRadius = addButton.frame.height / 2
    }
    
    @objc private func tapAction() {
        view.endEditing(true)
    }
    
    @IBAction private func addAction(_ sender: Any) {
        guard let biddingTeam = biddingTeamViewController?.biddingTeam,
            let gameScore = scoreInputViewController?.score,
            let declarationsTeam1 = declarationViewController?.declarationPoints,
            let declarationsTeam2 = declarationsViewController2?.declarationPoints
            else { return }
        
        let belaScore = BelaScore(biddingTeam: biddingTeam, gameScore: gameScore, declarationsTeam1: declarationsTeam1, declarationsTeam2: declarationsTeam2)
        print(belaScore)
        delegate?.addScoreViewControllerDidAdd(addScoreViewController: self, score: belaScore)
    }
    
}
