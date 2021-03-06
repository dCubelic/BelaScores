//
//  ThemePickerTableViewCell.swift
//  BlokZaBelu
//
//  Created by dominik on 21/10/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import UIKit

protocol ThemePickerDelegate: class {
    func themePickerDidPick(theme: Theme)
}

class ThemePickerTableViewCell: UITableViewCell {

    @IBOutlet weak private var collectionView: UICollectionView!
    
    private var themes = Theme.allCases
    
    weak var delegate: ThemePickerDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()

        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = BelaTheme.shared.backgroundColor2
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        
        collectionView.register(UINib(nibName: "ThemeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ThemeCollectionViewCell")
        
        let index = themes.firstIndex(of: BelaTheme.shared.theme) ?? 0
        collectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: .centeredHorizontally, animated: false)
    }
    
}

extension ThemePickerTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return themes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(ofType: ThemeCollectionViewCell.self, for: indexPath)
        cell.setup(for: themes[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.themePickerDidPick(theme: themes[indexPath.row])
        contentView.backgroundColor = BelaTheme.shared.backgroundColor2
        collectionView.reloadData()
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}
