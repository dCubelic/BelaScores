//
//  SettingsViewViewController.swift
//  BlokZaBelu
//
//  Created by dominik on 18/10/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    private let settings: [SettingSection] = [
        SettingSection(description: "Change direction", settings: [.invertScores("invertScores".localized)]),
//        SettingSection(description: "Themes", settings: [.themes])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        
        tableView.register(UINib(nibName: "SettingsToggleTableViewCell", bundle: nil), forCellReuseIdentifier: "SettingsToggleTableViewCell")
        tableView.sectionFooterHeight = UITableView.automaticDimension
    }

    private func setupNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
}

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings[section].settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch settings[indexPath.section].settings[indexPath.row] {
        case .invertScores(let title):
            let cell = tableView.dequeueReusableCell(ofType: SettingsToggleTableViewCell.self, for: indexPath)
            cell.delegate = self
            cell.setup(title: title, isOn: BelaSettings.shared.invertScores)
            return cell
        case .themes:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return settings[section].description
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear

        let label = UILabel()
        label.text = settings[section].description
        label.font = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0

        view.addSubview(label)

        label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        return view
    }
    
}

extension SettingsViewController: SettingsToggleTableViewCellDelegate {
    
    func settingsToggleTableViewCellDidSwitch(_ cell: SettingsToggleTableViewCell, to isOn: Bool) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let setting = settings[indexPath.section].settings[indexPath.row]
        
        switch setting {
        case .invertScores:
            BelaSettings.shared.invertScores = isOn
        case .themes:
            break
        }
    }

}
