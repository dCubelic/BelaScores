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

class AddScoreViewController: CardViewController {

    @IBOutlet weak private var addButton: UIButton!
    @IBOutlet weak var touchView: UIView!
    
    var biddingTeamViewController: BiddingTeamViewController?
    var scoreInputViewController: ScoreInputViewController?
    var declarationsViewController: DeclarationsViewController?
    var declarationsViewController2: DeclarationsViewController?
    
    var belaScore: BelaScore? {
        guard let biddingTeam = biddingTeamViewController?.biddingTeam,
            let gameScore = scoreInputViewController?.score,
            let declarationsTeam1 = declarationsViewController?.declarationPoints,
            let declarationsTeam2 = declarationsViewController2?.declarationPoints
            else { return nil }
        
        return BelaScore(biddingTeam: biddingTeam, gameScore: gameScore, declarationsTeam1: declarationsTeam1, declarationsTeam2: declarationsTeam2)
    }
    
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
            declarationsViewController = segue.destination as? DeclarationsViewController
        case "Declarations2ViewController":
            declarationsViewController2 = segue.destination as? DeclarationsViewController
        default:
            break
        }
    }
    
    public func reset() {
        biddingTeamViewController?.reset()
        scoreInputViewController?.reset()
        declarationsViewController?.reset()
        declarationsViewController2?.reset()
    }
    
    public func setup(for score: BelaScore) {
        biddingTeamViewController?.biddingTeam = score.biddingTeam
        scoreInputViewController?.score = score.gameScore
        declarationsViewController?.declarationPoints = score.declarationsTeam1
        declarationsViewController2?.declarationPoints = score.declarationsTeam2
    }
    
    private func setupViews() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        touchView.addGestureRecognizer(tapGesture)
        
        addButton.layer.cornerRadius = addButton.frame.height / 2
    }
    
    @objc private func tapAction() {
        view.endEditing(true)
    }
    
    private func check() {
        
    }
    
    @IBAction private func addAction(_ sender: Any) {
        guard let belaScore = belaScore else { return }
        
        delegate?.addScoreViewControllerDidAdd(addScoreViewController: self, score: belaScore)
        
        reset()
        closeCard()
    }
    
}
