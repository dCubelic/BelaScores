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
    func addScoreViewControllerDidUpdate(addScoreViewController: AddScoreViewController, score: BelaScore, for scoreTableViewCell: UITableViewCell)
}

class AddScoreViewController: UIViewController {
    
    enum AddScoreViewControllerMode {
        case new
        case update
    }

    @IBOutlet weak private var addButton: UIButton!
    @IBOutlet weak private var touchView: UIView!
    
    private var keyboardObserver: NSObjectProtocol?
    
    private var belaScore: BelaScore? {
        guard let biddingTeam = biddingTeamViewController?.biddingTeam,
            let gameScore = scoreInputViewController?.score,
            let declarationsTeam1 = declarationsViewController?.declarationPoints,
            let declarationsTeam2 = declarationsViewController2?.declarationPoints
            else { return nil }
        
        return BelaScore(biddingTeam: biddingTeam, gameScore: gameScore, declarationsTeam1: declarationsTeam1, declarationsTeam2: declarationsTeam2)
    }
    
    private var mode: AddScoreViewControllerMode = .new {
        didSet {
            switch mode {
            case .new:
                addButton.setTitle("Unesi", for: .normal)
            case .update:
                addButton.setTitle("Ažuriraj", for: .normal)
            }
        }
    }
    
    var biddingTeamViewController: BiddingTeamViewController?
    var scoreInputViewController: ScoreInputViewController?
    var declarationsViewController: DeclarationsViewController?
    var declarationsViewController2: DeclarationsViewController?
    
    var scoreTableViewCell: UITableViewCell?
    var updateBelaScore: BelaScore?
    
    weak var delegate: AddScoreViewControllerDelegate?
    
    deinit {
        if let keyboardObserver = keyboardObserver {
            NotificationCenter.default.removeObserver(keyboardObserver)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        if let updateBelaScore = updateBelaScore {
            setup(for: updateBelaScore, scoreTableViewCell: scoreTableViewCell)
        }
        
        setupKeyboardObserver()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "BiddingTeamViewController":
            biddingTeamViewController = segue.destination as? BiddingTeamViewController
            biddingTeamViewController?.delegate = self
        case "ScoreInputViewController":
            scoreInputViewController = segue.destination as? ScoreInputViewController
            scoreInputViewController?.delegate = self
        case "DeclarationsViewController":
            declarationsViewController = segue.destination as? DeclarationsViewController
            declarationsViewController?.delegate = self
        case "Declarations2ViewController":
            declarationsViewController2 = segue.destination as? DeclarationsViewController
            declarationsViewController2?.delegate = self
        default:
            break
        }
    }
    
    private func setupKeyboardObserver() {
        keyboardObserver = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillChangeFrameNotification, object: nil, queue: nil) { notification in
            if let userInfo = notification.userInfo,
                let durationValue = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber,
                let endFrameValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
                let curve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber {
                
                guard let presentingView = self.presentingViewController?.view else { return }
                
                var responderBottomPoint = self.view.firstResponder?.convert(self.view.firstResponder?.frame.origin ?? .zero, to: presentingView) ?? CGPoint.zero
                let responderHeight = self.view.firstResponder?.frame.height ?? 0
                responderBottomPoint.y += responderHeight + 75
                
                let originalOriginY = UIScreen.main.bounds.height - self.view.frame.height
                let currentOffset = originalOriginY - self.view.frame.origin.y
                self.view.frame.origin.y = min(originalOriginY, originalOriginY - (responderBottomPoint.y - endFrameValue.cgRectValue.minY) - currentOffset)
                
                UIView.animate(withDuration: durationValue.doubleValue, delay: 0, options: UIView.AnimationOptions(rawValue: UInt(curve.intValue << 16)), animations: {
                    self.view.layoutIfNeeded()
                }, completion: nil)
            }
        }
    }
    
    private func setup(for score: BelaScore, scoreTableViewCell: UITableViewCell?) {
        self.scoreTableViewCell = scoreTableViewCell
        
        biddingTeamViewController?.biddingTeam = score.biddingTeam
        scoreInputViewController?.score = score.gameScore
        declarationsViewController?.setup(for: score.declarationsTeam1)
        declarationsViewController2?.setup(for: score.declarationsTeam2)
        
        mode = .update
    }
    
    private func setupViews() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        touchView.addGestureRecognizer(tapGesture)
        
        addButton.layer.cornerRadius = addButton.frame.height / 2
        
        roundCorners()
    }
    
    private func roundCorners() {
        let layer = CAShapeLayer()
        let path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: [UIRectCorner.topLeft, UIRectCorner.topRight], cornerRadii: CGSize(width: 10, height: 10))
        
        layer.path = path.cgPath
        view.layer.mask = layer
    }
    
    @objc private func tapAction() {
        view.endEditing(true)
    }
    
    private func updateDidntPassViews() {
        if belaScore?.team1Passed == false {
            biddingTeamViewController?.setDidntPass(team: .team1)
        } else if belaScore?.team2Passed == false {
            biddingTeamViewController?.setDidntPass(team: .team2)
        } else {
            biddingTeamViewController?.setDidntPass(team: nil)
        }
    }
    
    @IBAction private func addAction(_ sender: Any) {
        guard let belaScore = belaScore, belaScore.isValidScore else {
            scoreInputViewController?.shakeInputs()
            return
        }
        
        switch mode {
        case .new:
            delegate?.addScoreViewControllerDidAdd(addScoreViewController: self, score: belaScore)
        case .update:
            if let scoreTableViewCell = scoreTableViewCell {
                delegate?.addScoreViewControllerDidUpdate(addScoreViewController: self, score: belaScore, for: scoreTableViewCell)
            }
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func cancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension AddScoreViewController: BiddingTeamViewControllerDelegate {
    
    func biddingTeamViewControllerDidChangeBidder(_ biddingTeamViewController: BiddingTeamViewController, bidder: BelaTeam) {
        updateDidntPassViews()
    }

}

extension AddScoreViewController: ScoreInputViewControllerDelegate {
    
    func ScoreInputViewControllerDidUpdateScore(_ scoreInputViewController: ScoreInputViewController, score: BelaGameScore) {
        updateDidntPassViews()
    }
    
}

extension AddScoreViewController: DeclarationsViewControllerDelegate {
    
    func declarationsViewControllerDidUpdateDeclarationPoints(_ declarationsViewController: DeclarationsViewController, declarationPoints: [Int]) {
        updateDidntPassViews()
    }
    
}
