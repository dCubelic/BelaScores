//
//  TrumpSuitPickerViewController.swift
//  BelaDetector
//
//  Created by Dominik Cubelic on 05/08/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import UIKit

protocol TrumpSuitPickerViewControllerDelegate: class {
    func trumpSuitPickerViewControllerDidChoose(trumpSuitPickerViewController: TrumpSuitPickerViewController, trumpSuit: BelaSuit)
}

class TrumpSuitPickerViewController: UIViewController {

    weak var delegate: TrumpSuitPickerViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.layer.cornerRadius = 30
    }

    @IBAction func heartsAction(_ sender: Any) {
        delegate?.trumpSuitPickerViewControllerDidChoose(trumpSuitPickerViewController: self, trumpSuit: .hearts)
    }
    
    @IBAction func diamondsAction(_ sender: Any) {
        delegate?.trumpSuitPickerViewControllerDidChoose(trumpSuitPickerViewController: self, trumpSuit: .diamonds)
    }
    
    @IBAction func spadesAction(_ sender: Any) {
        delegate?.trumpSuitPickerViewControllerDidChoose(trumpSuitPickerViewController: self, trumpSuit: .spades)
    }
    
    @IBAction func clubsAction(_ sender: Any) {
        delegate?.trumpSuitPickerViewControllerDidChoose(trumpSuitPickerViewController: self, trumpSuit: .clubs)
    }
}
