//
//  BiddingViewController.swift
//  BlokZaBelu
//
//  Created by Dominik Cubelic on 11/08/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import UIKit

protocol BiddingTeamViewControllerDelegate: class {
    func biddingTeamViewControllerDidChangeBidder(_ biddingViewController: BiddingTeamViewController, bidder: BelaTeam)
}

class BiddingTeamViewController: UIViewController {
    
    @IBOutlet weak private var team1Button: UIButton!
    @IBOutlet weak private var team2Button: UIButton!
    
    weak var delegate: BiddingTeamViewControllerDelegate?
    
    private(set) var biddingTeam: BelaTeam? = .team1 {
        didSet {
            guard let biddingTeam = biddingTeam else { return }
            delegate?.biddingTeamViewControllerDidChangeBidder(self, bidder: biddingTeam)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func reset() {
        biddingTeam = .team1
    }
    
    @IBAction private func team1Action(_ sender: Any) {
        team1Button.setTitleColor(UIColor.blue, for: .normal)
        team2Button.setTitleColor(UIColor.darkGray, for: .normal)
        biddingTeam = .team1
    }
    
    @IBAction private func team2Action(_ sender: Any) {
        team1Button.setTitleColor(UIColor.darkGray, for: .normal)
        team2Button.setTitleColor(UIColor.blue, for: .normal)
        biddingTeam = .team2
    }
    
}
