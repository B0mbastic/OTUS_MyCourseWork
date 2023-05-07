//
//  SettingsViewController.swift
//  OTUS_MyCourseWork
//
//  Created by Александр Ковбасин on 09.04.2023.
//

import UIKit
import CoreData

class SettingsViewController: UIViewController { //}, UITableViewDelegate, UITableViewDataSource {tr
    
    

    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
        return view
    }()
    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30.0)
        label.text = NSLocalizedString("settings label", comment: "")
        label.textColor = .black
        return label
    }()
    //    private lazy var settingsTableView: UITableView = {
    //        let table = UITableView(frame: view.bounds, style: .plain)
    //        table.backgroundColor = .systemGray6
    //        table.layer.cornerRadius = 20
    //        table.register(SettingsTableCell.self, forCellReuseIdentifier: cellID)
    //        table.delegate = self
    //        table.dataSource = self
    //        table.rowHeight = 80
    //        return table
    //    }()
    private lazy var audioSettingsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.text = "\(NSLocalizedString("audio label", comment: "")):"
        label.textColor = .black
        return label
    }()
    private lazy var audioSettingsSwitch: UISwitch = {
        let sw = UISwitch()
        //sw.isOn = true
        return sw
    }()
    private lazy var saveSettingsButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
        button.layer.cornerRadius = 15
        button.setTitle(NSLocalizedString("save settings", comment: ""), for: .normal)
        button.addTarget(self, action: #selector(saveSettings), for: .touchUpInside)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        audioSettingsSwitch.isOn = UserDefaultsManager().checkKey(key: "isAudioOnKey") ?  UserDefaultsManager.isAudioOn : true

        
        view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.leading.trailing.equalToSuperview()
        }
        view.addSubview(mainLabel)
        mainLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(100)
        }
        view.addSubview(audioSettingsLabel)
        audioSettingsLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(40)
            make.top.equalTo(mainLabel.snp.bottom).offset(20)
        }
        view.addSubview(audioSettingsSwitch)
        audioSettingsSwitch.snp.makeConstraints { make in
            make.leading.equalTo(audioSettingsLabel.snp.trailing).offset(40)
            make.top.equalTo(mainLabel.snp.bottom).offset(20)
        }
        view.addSubview(saveSettingsButton)
        saveSettingsButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(audioSettingsSwitch.snp.bottom).offset(50)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
        //        view.addSubview(settingsTableView)
        //        settingsTableView.snp.makeConstraints { make in
        //            make.leading.equalToSuperview().offset(40)
        //            make.trailing.equalToSuperview().offset(-40)
        //            make.top.equalTo(mainLabel.snp.bottom).offset(20)
        //            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        //        }
    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 3
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = topPlayersTableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? TopPlayersTableCell
//        let personName: String
//        personName = "\(personsArray[indexPath.row].personFirstName) \(personsArray[indexPath.row].personMiddleName) \(personsArray[indexPath.row].personLastName)"
//        cell?.setPersonName(personName: personName, personPhoto: personsArray[indexPath.row].personPhoto)
//        return cell ?? TopPlayersTableCell()
//    }
    @objc func saveSettings(sender: UIButton!){
        UserDefaultsManager.isAudioOn = audioSettingsSwitch.isOn
        //print("value to save: \(audioSettingsSwitch.isOn)")
        let mainMenuController = MainMenuViewController()
        navigationController?.pushViewController(mainMenuController, animated: true)
    }
}
