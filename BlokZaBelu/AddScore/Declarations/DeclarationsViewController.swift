//
//  DeclarationsViewController.swift
//  BlokZaBelu
//
//  Created by Dominik Cubelic on 12/08/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import UIKit

class DeclarationsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private(set) var declarationPoints: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        guard let indexPath = tableView.indexPath(for: newDeclarationTableViewCell) else { return }
        
        self.declarationPoints.append(declarationPoints)
        
        tableView.insertRows(at: [indexPath], with: .fade)
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
}

extension DeclarationsViewController: DeclaredValueTableViewCellDelegate {
    
    func declaredValueTableViewCellDidPressRemove(_ declaredValueTableViewCell: DeclaredValueTableViewCell) {
        guard let indexPath = tableView.indexPath(for: declaredValueTableViewCell) else { return }
        
        declarationPoints.remove(at: indexPath.row)
        
        tableView.deleteRows(at: [indexPath], with: .bottom)
    }
    
}
