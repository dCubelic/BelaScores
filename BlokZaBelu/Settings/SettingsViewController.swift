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
    
    private var updatingColors = false
    
    private let settings: [SettingSection] = [
        SettingSection(description: "invert.description".localized, settings: [.invertScores("invert.title".localized)]),
        SettingSection(description: "change_theme.description".localized, settings: [.themes]),
        SettingSection(description: "delete_history.description".localized, settings: [.deleteHistory])
    ]
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return BelaTheme.shared.statusBarStyle
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupColors()
        
        tableView.register(UINib(nibName: "SettingsToggleTableViewCell", bundle: nil), forCellReuseIdentifier: "SettingsToggleTableViewCell")
        tableView.register(UINib(nibName: "ThemePickerTableViewCell", bundle: nil), forCellReuseIdentifier: "ThemePickerTableViewCell")
        tableView.register(UINib(nibName: "DeleteHistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "DeleteHistoryTableViewCell")
    }

    private func setupNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    private func setupColors() {
        self.setNeedsStatusBarAppearanceUpdate()
        
        navigationController?.navigationBar.barTintColor = BelaTheme.shared.backgroundColor
        navigationController?.navigationBar.tintColor = BelaTheme.shared.textColor
        
        tableView.backgroundColor = BelaTheme.shared.backgroundColor
        
        tableView.reloadData()
    }
    
}

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings[section].settings.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch settings[indexPath.section].settings[indexPath.row] {
        case .invertScores:
            return 44
        case .themes:
            return 66
        case .deleteHistory:
            return 44
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch settings[indexPath.section].settings[indexPath.row] {
        case .invertScores(let title):
            let cell = tableView.dequeueReusableCell(ofType: SettingsToggleTableViewCell.self, for: indexPath)
            cell.delegate = self
            cell.setup(title: title, isOn: BelaSettings.shared.invertScores)
            return cell
        case .themes:
            let cell = tableView.dequeueReusableCell(ofType: ThemePickerTableViewCell.self, for: indexPath)
            cell.delegate = self
            return cell
        case .deleteHistory:
            let cell = tableView.dequeueReusableCell(ofType: DeleteHistoryTableViewCell.self, for: indexPath)
            cell.setup()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch settings[indexPath.section].settings[indexPath.row] {
        case .deleteHistory:
            let alert = UIAlertController(title: "are_you_sure".localized, message: "remove_all_data".localized, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "yes".localized, style: .destructive, handler: { _ in
                UserDefaults.standard.removeObject(forKey: "matches")
            }))
            alert.addAction(UIAlertAction(title: "no".localized, style: .cancel, handler: nil))
            
            present(alert, animated: true, completion: nil)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear

        let label = UILabel()
        label.text = settings[section].description
        label.font = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        label.textColor = BelaTheme.shared.textColor
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0

        view.addSubview(label)

        label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 8).isActive = true
        label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60
    }
    
}

extension SettingsViewController: SettingsToggleTableViewCellDelegate {
    
    func settingsToggleTableViewCellDidSwitch(_ cell: SettingsToggleTableViewCell, to isOn: Bool) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let setting = settings[indexPath.section].settings[indexPath.row]
        
        switch setting {
        case .invertScores:
            BelaSettings.shared.invertScores = isOn
        default:
            break
        }
    }

}

extension SettingsViewController: ThemePickerDelegate {
    
    func themePickerDidPick(theme: Theme) {
        BelaTheme.shared.theme = theme
        setupColors()
    }
    
}
