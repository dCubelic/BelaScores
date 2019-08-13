//
//  ScoreTableViewCell.swift
//  BlokZaBelu
//
//  Created by Dominik Cubelic on 10/08/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import UIKit

class ScoreTableViewCell: UITableViewCell {

    @IBOutlet weak private var score1Label: UILabel!
    @IBOutlet weak private var score2Label: UILabel!
    var team1BidView = UIView()
    var team2BidView = UIView()
    
    override func awakeFromNib() {
        super.awakeFromNib()

        selectionStyle = .none
        
        contentView.addSubview(team1BidView)
        contentView.addSubview(team2BidView)
        
        //Xib is drunk
        team1BidView.translatesAutoresizingMaskIntoConstraints = false
        team1BidView.widthAnchor.constraint(equalToConstant: 8).isActive = true
        team1BidView.heightAnchor.constraint(equalToConstant: 8).isActive = true
        team1BidView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        team1BidView.trailingAnchor.constraint(equalTo: score1Label.leadingAnchor, constant: -4).isActive = true
        team1BidView.layer.masksToBounds = true
        team1BidView.layer.cornerRadius = 4
        
        team2BidView.translatesAutoresizingMaskIntoConstraints = false
        team2BidView.widthAnchor.constraint(equalToConstant: 8).isActive = true
        team2BidView.heightAnchor.constraint(equalToConstant: 8).isActive = true
        team2BidView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        team2BidView.leadingAnchor.constraint(equalTo: score2Label.trailingAnchor, constant: 4).isActive = true
        team2BidView.layer.masksToBounds = true
        team2BidView.layer.cornerRadius = 4
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        contentView.backgroundColor = selected ? UIColor.darkGray2 : UIColor.darkGray
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        contentView.backgroundColor = highlighted ? UIColor.darkGray2 : UIColor.darkGray
    }
    
    func setup(for score: BelaScore) {
        score1Label.text = String(score.totalScore)
        score2Label.text = String(score.totalScore2)
        team1BidView.isHidden = !(score.biddingTeam == .team1)
        team2BidView.isHidden = !(score.biddingTeam == .team2)
        
        team1BidView.backgroundColor = score.team1Passed ? UIColor.blue : UIColor.red
        team2BidView.backgroundColor = score.team2Passed ? UIColor.blue : UIColor.red
        
    }
    
}
