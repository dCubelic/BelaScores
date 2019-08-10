//
//  UITableView+Bela.swift
//  BlokZaBelu
//
//  Created by Dominik Cubelic on 10/08/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(ofType: T.Type, withIdentifier: String? = nil, for indexPath: IndexPath) -> T {
        let identifier = withIdentifier ?? String(describing: ofType)
        
        guard let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T else {
            fatalError("Table view \(self) can't dequeue a cell of type \(ofType) for identifier \(identifier)")
        }
        
        return cell
    }
}
