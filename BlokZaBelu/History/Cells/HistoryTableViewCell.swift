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
        df.dateFormat = "dd.MM. HH:mm"
        return df
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()

        selectionStyle = .none
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
        separatorView.backgroundColor = BelaTheme.shared.backgroundColor2
        
        team1NameLabel.textColor = BelaTheme.shared.textColor
        team2NameLabel.textColor = BelaTheme.shared.textColor
        dateLabel.textColor = BelaTheme.shared.textColor
        team1PointsLabel.textColor = BelaTheme.shared.textColor
        team2PointsLabel.textColor = BelaTheme.shared.textColor
    }
    
    func setup(with matchScore: BelaMatch) {
        team1NameLabel.text = matchScore.matchSettings.team1Name.string
        team2NameLabel.text = matchScore.matchSettings.team2Name.string
        team1PointsLabel.text = String(matchScore.team1Score)
        team2PointsLabel.text = String(matchScore.team2Score)
        dateLabel.text = dateFormatter.string(from: matchScore.dateCreated)
        
        if matchScore.matchSettings.team1Name.string.split(separator: " ").count > 1 {
            team1NameLabel.numberOfLines = 2
        } else {
            team1NameLabel.numberOfLines = 1
        }
        
        if matchScore.matchSettings.team2Name.string.split(separator: " ").count > 1 {
            team2NameLabel.numberOfLines = 2
        } else {
            team2NameLabel.numberOfLines = 1
        }
        
        team1PointsLabel.textColor = BelaTheme.shared.textColor
        team2PointsLabel.textColor = BelaTheme.shared.textColor
        if matchScore.winningTeam == .team1 {
            team1PointsLabel.textColor = BelaTheme.shared.themeColor
        } else if matchScore.winningTeam == .team2 {
            team2PointsLabel.textColor = BelaTheme.shared.themeColor
        }
    }
    
}
