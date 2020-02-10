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
    
    override func layoutSubviews() {
        setupColors()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        contentView.backgroundColor = selected ? BelaTheme.shared.backgroundColor2 : BelaTheme.shared.backgroundColor
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        contentView.backgroundColor = highlighted ? BelaTheme.shared.backgroundColor2 : BelaTheme.shared.backgroundColor
    }
    
    private func setupColors() {
        backgroundColor = BelaTheme.shared.backgroundColor
        contentView.backgroundColor = BelaTheme.shared.backgroundColor
        score1Label.textColor = BelaTheme.shared.textColor
        score2Label.textColor = BelaTheme.shared.textColor
    }
    
    func setup(for score: BelaScore, matchSettings: BelaMatchSettings) {
        score1Label.text = String(score.totalScoreTeam1(tieBreaker: matchSettings.tieBreaker))
        score2Label.text = String(score.totalScoreTeam2(tieBreaker: matchSettings.tieBreaker))
        team1BidView.isHidden = !(score.biddingTeam == .team1)
        team2BidView.isHidden = !(score.biddingTeam == .team2)
        
        team1BidView.backgroundColor = score.team1Passed(tieBreaker: matchSettings.tieBreaker) ? BelaTheme.shared.themeColor : BelaTheme.shared.themeContrastColor
        team2BidView.backgroundColor = score.team2Passed(tieBreaker: matchSettings.tieBreaker) ? BelaTheme.shared.themeColor : BelaTheme.shared.themeContrastColor
    }
    
}
