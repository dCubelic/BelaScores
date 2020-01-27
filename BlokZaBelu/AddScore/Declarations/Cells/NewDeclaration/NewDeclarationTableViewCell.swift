//
//  NewDeclarationTableViewCell.swift
//  BlokZaBelu
//
//  Created by Dominik Cubelic on 12/08/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import UIKit

protocol NewDeclarationTableViewCellDelegate: class {
    func newDeclarationTableViewCellDidAddNewDeclarationPoints(newDeclarationTableViewCell: NewDeclarationTableViewCell, declarationPoints: Int)
    
    var declarationValues: [Int] { get }
}

class NewDeclarationTableViewCell: UITableViewCell {

    private var plusButton: UIButton?
    private var collectionView: UICollectionView?
    
    weak var delegate: NewDeclarationTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()

        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        setupPlusButton()
    }
    
    public func reset() {
        plusButton?.isHidden = false
        collectionView?.isHidden = true
    }
    
    private func setupPlusButton() {
        let button = UIButton()
        button.setImage(UIImage(named: "plus"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = BelaTheme.shared.transparentBackgroundColor
        button.addTarget(self, action: #selector(plusAction), for: .touchUpInside)
        
        contentView.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        button.layoutIfNeeded()
        
        button.layer.masksToBounds = true
        button.layer.cornerRadius = button.frame.height / 2
        
        self.plusButton = button
    }
    
    @objc private func plusAction() {
        plusButton?.isHidden = true
        
        if collectionView == nil {
            setupCollectionView()
        }
        collectionView?.reloadData()
        collectionView?.isHidden = false
    }
    
    private func setupCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        flowLayout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = BelaTheme.shared.transparentBackgroundColor
        
        collectionView.register(UINib(nibName: "ValueCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ValueCollectionViewCell")
        
        contentView.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        collectionView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 35).isActive = true

        layoutIfNeeded()
        
        collectionView.layer.cornerRadius = collectionView.frame.height / 2
        
        self.collectionView = collectionView
    }
    
}

extension NewDeclarationTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let delegate = delegate else { fatalError("Delegate needs to be implemented.") }
        return delegate.declarationValues.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 40, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let delegate = delegate else { fatalError("Delegate needs to be implemented.") }

        let cell = collectionView.dequeueReusableCell(ofType: ValueCollectionViewCell.self, for: indexPath)
        cell.setup(for: String(delegate.declarationValues[indexPath.row]))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let delegate = delegate else { fatalError("Delegate needs to be implemented.") }

        delegate.newDeclarationTableViewCellDidAddNewDeclarationPoints(newDeclarationTableViewCell: self, declarationPoints: delegate.declarationValues[indexPath.row])
        
        collectionView.isHidden = true
        plusButton?.isHidden = false
    }

}
