//
//  DeclarationsViewController.swift
//  BlokZaBelu
//
//  Created by Dominik Cubelic on 12/08/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import UIKit

protocol DeclarationsViewControllerDelegate: class {
    func declarationsViewControllerDidUpdateDeclarationPoints(_ declarationsViewController: DeclarationsViewController, declarationPoints: [Int])
}

class DeclarationsViewController: UIViewController {

    @IBOutlet weak private var tableView: UITableView!
    
    private(set) var declarationPoints: [Int] = [] {
        didSet {
            delegate?.declarationsViewControllerDidUpdateDeclarationPoints(self, declarationPoints: declarationPoints)
        }
    }
    
    weak var delegate: DeclarationsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        tableView.backgroundView = UIView()
        tableView.backgroundView?.addGestureRecognizer(tapGesture)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "NewDeclarationTableViewCell", bundle: nil), forCellReuseIdentifier: "NewDeclarationTableViewCell")
        tableView.register(UINib(nibName: "DeclaredValueTableViewCell", bundle: nil), forCellReuseIdentifier: "DeclaredValueTableViewCell")
    }
    
    func reset() {
        declarationPoints = []
        tableView.reloadData()
    }
    
    func setup(for declarationPoints: [Int]) {
        self.declarationPoints = declarationPoints
        tableView.reloadData()
    }
    
    func addAllPointsBonus() {
        if !declarationPoints.contains(90) {
            insertDeclarationPoints(90)
        }
    }
    
    func removeAllPointsBonus() {
        guard let index = declarationPoints.firstIndex(of: 90) else { return }
        
        declarationPoints.remove(at: index)
        
        tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .bottom)
    }
    
    private func insertDeclarationPoints(_ declarationPoints: Int) {
        let indexPath = IndexPath(row: self.declarationPoints.count, section: 0)
        
        self.declarationPoints.append(declarationPoints)
        
        tableView.insertRows(at: [indexPath], with: .fade)
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
    @objc private func tapAction() {
        let lastIndexPath = IndexPath(row: declarationPoints.count, section: 0)
        if let cell = tableView.cellForRow(at: lastIndexPath) as? NewDeclarationTableViewCell {
            cell.reset()
        }
    }
}

extension DeclarationsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return declarationPoints.count + 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == declarationPoints.count {
            let cell = tableView.dequeueReusableCell(ofType: NewDeclarationTableViewCell.self, for: indexPath)
            cell.delegate = self
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(ofType: DeclaredValueTableViewCell.self, for: indexPath)
        cell.delegate = self
        cell.setup(for: declarationPoints[indexPath.row])
        
        return cell
    }
    
}

extension DeclarationsViewController: NewDeclarationTableViewCellDelegate {
    
    func newDeclarationTableViewCellDidAddNewDeclarationPoints(newDeclarationTableViewCell: NewDeclarationTableViewCell, declarationPoints: Int) {
        insertDeclarationPoints(declarationPoints)
    }
    
}

extension DeclarationsViewController: DeclaredValueTableViewCellDelegate {
    
    func declaredValueTableViewCellDidPressRemove(_ declaredValueTableViewCell: DeclaredValueTableViewCell) {
        guard let indexPath = tableView.indexPath(for: declaredValueTableViewCell) else { return }
        
        declarationPoints.remove(at: indexPath.row)
        
        tableView.deleteRows(at: [indexPath], with: .bottom)
    }
    
}
