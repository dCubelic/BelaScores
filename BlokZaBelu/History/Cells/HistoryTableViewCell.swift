//
//  HistoryTableViewCell.swift
//  BlokZaBelu
//
//  Created by dominik on 28/11/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak private var team1NameLabel: UILabel!
    @IBOutlet weak private var team2NameLabel: UILabel!
    @IBOutlet weak private var team1PointsLabel: UILabel!
    @IBOutlet weak private var team2PointsLabel: UILabel!
    @IBOutlet weak private var dateLabel: UILabel!
    @IBOutlet weak private var separatorView: UIView!
    
    private final let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "dd.MM."
        return df
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()

        selectionStyle = .none
        setupColors()
    }
    
    private func setupColors() {
        backgroundColor = BelaTheme.shared.backgroundColor
        contentView.backgroundColor = BelaTheme.shared.backgroundColor
        separatorView.backgroundColor = BelaTheme.shared.backgroundColor2
        
        team1NameLabel.textColor = BelaTheme.shared.textColor
        team2NameLabel.textColor = BelaTheme.shared.textColor
        dateLabel.textColor = BelaTheme.shared.textColor
        team1PointsLabel.textColor = BelaTheme.shared.textColor
        team2PointsLabel.textColor = BelaTheme.shared.textColor
    }
    
    func setup(with matchScore: BelaMatchScore) {
        team1NameLabel.text = matchScore.team1Name.string
        team2NameLabel.text = matchScore.team2Name.string
        team1PointsLabel.text = String(matchScore.team1Score)
        team2PointsLabel.text = String(matchScore.team2Score)
        dateLabel.text = dateFormatter.string(from: matchScore.date)
        
        if matchScore.winningTeam == .team1 {
            team1PointsLabel.textColor = BelaTheme.shared.themeColor
            team2PointsLabel.textColor = BelaTheme.shared.textColor
        } else if matchScore.winningTeam == .team2 {
            team1PointsLabel.textColor = BelaTheme.shared.textColor
            team2PointsLabel.textColor = BelaTheme.shared.themeColor
        }
    }
    
}
