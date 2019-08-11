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
    @IBOutlet weak var team1BidView: UIView!
    @IBOutlet weak var team2BidView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        team1BidView.layer.cornerRadius = team1BidView.frame.height / 2
        team2BidView.layer.cornerRadius = team2BidView.frame.height / 2
        
        contentView.backgroundColor = selected ? UIColor.darkGray2 : UIColor.darkGray
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        contentView.backgroundColor = highlighted ? UIColor.darkGray2 : UIColor.darkGray
    }
    
    func setup(for score: BelaScore) {
        score1Label.text = String(score.score1)
        score2Label.text = String(score.score2)
        team1BidView.isHidden = false
        team2BidView.isHidden = true
    }
    
}
