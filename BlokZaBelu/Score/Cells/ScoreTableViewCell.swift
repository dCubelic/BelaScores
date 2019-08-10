//
//  ScoreTableViewCell.swift
//  BlokZaBelu
//
//  Created by Dominik Cubelic on 10/08/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import UIKit

class ScoreTableViewCell: UITableViewCell {

    @IBOutlet weak var score1Label: UILabel!
    @IBOutlet weak var score2Label: UILabel!
    @IBOutlet weak var trumpSuitImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        selectionStyle = .none
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
        score1Label.text = String(score.score1)
        score2Label.text = String(score.score2)
        trumpSuitImageView.image = UIImage(named: score.trumpSuit.imageName)
    }
    
}
