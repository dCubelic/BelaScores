//
//  BiddingViewController.swift
//  BlokZaBelu
//
//  Created by Dominik Cubelic on 11/08/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import UIKit

protocol BiddingTeamViewControllerDelegate: class {
    func biddingTeamViewControllerDidChangeBidder(_ biddingTeamViewController: BiddingTeamViewController, bidder: BelaTeam)
}

class BiddingTeamViewController: UIViewController {
    
    @IBOutlet weak private var team1Button: UIButton!
    @IBOutlet weak private var team2Button: UIButton!
    @IBOutlet weak private var team1DidntPassView: UIView!
    @IBOutlet weak private var team2DidntPassView: UIView!
    
    weak var delegate: BiddingTeamViewControllerDelegate?
    
    var biddingTeam: BelaTeam? = .team1 {
        didSet {
            guard let biddingTeam = biddingTeam else { return }
            
            updateColors()
            delegate?.biddingTeamViewControllerDidChangeBidder(self, bidder: biddingTeam)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        updateColors()
    }
    
    func setDidntPass(team: BelaTeam?) {
        guard let team = team else {
            team1DidntPassView.isHidden = true
            team2DidntPassView.isHidden = true
            return
        }
        
        switch team {
        case .team1:
            team1DidntPassView.isHidden = false
            team2DidntPassView.isHidden = true
        default:
            team1DidntPassView.isHidden = true
            team2DidntPassView.isHidden = false
        }
    }
    
    func reset() {
        setDidntPass(team: nil)
        team1Action(self)
    }
    
    private func setupViews() {
        setDidntPass(team: nil)
        team1DidntPassView.layer.cornerRadius = team1DidntPassView.frame.height / 2
        team2DidntPassView.layer.cornerRadius = team2DidntPassView.frame.height / 2
    }
    
    private func updateColors() {
        guard let biddingTeam = biddingTeam else { return }
        
        switch biddingTeam {
        case .team1:
            team1Button.setTitleColor(UIColor.blue, for: .normal)
            team2Button.setTitleColor(UIColor.darkGray, for: .normal)
        case .team2:
            team1Button.setTitleColor(UIColor.darkGray, for: .normal)
            team2Button.setTitleColor(UIColor.blue, for: .normal)
        }
    }
    
    @IBAction private func team1Action(_ sender: Any) {
        biddingTeam = .team1
    }
    
    @IBAction private func team2Action(_ sender: Any) {
        biddingTeam = .team2
    }
    
}
