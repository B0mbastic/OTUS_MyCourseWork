//
//  SettingsViewController.swift
//  OTUS_MyCourseWork
//
//  Created by Александр Ковбасин on 09.04.2023.
//

import UIKit
import CoreData

class SettingsViewController: UIViewController { //}, UITableViewDelegate, UITableViewDataSource {
    var isAudioOn: Bool = UserDefaultsManager.isAudioOn
    //print("\(isAudioOn)")
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
        return view
    }()
    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30.0)
        label.text = "Settings"
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
        label.text = "Audio:"
        label.textColor = .black
        return label
    }()
    private lazy var audioSettingsSwitch: UISwitch = {
        let sw = UISwitch()
        sw.isOn = isAudioOn
        return sw
    }()
    private lazy var languageSettingsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.text = "Language:"
        label.textColor = .black
        return label
    }()
    private lazy var languageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        //label.text = gameSettings.language.rawValue
        label.textColor = .black
        return label
    }()
    private lazy var saveSettingsButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor(red: 0/255, green: 0/255, blue: 0/225, alpha: 1).cgColor
        button.layer.cornerRadius = 15
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(saveSettings), for: .touchUpInside)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        //        let entityDescription = NSEntityDescription.entity(forEntityName: "Settings", in: context)
        //        let managedObject = NSManagedObject(entity: entityDescription!, insertInto: context)
        //        //        managedObject.setValue("ru", forKey: "language")
        //        //        managedObject.setValue("eng", forKey: "language")
        //
        //        //        let language = managedObject.value(forKey: "language")
        //        //        print (language)
        //
        //        //appDelegate.saveContext()
        //
        //        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Settings")
        //        do{
        //            let results = try context.fetch(fetchRequest)
        //            for result in results as! [NSManagedObject]{
        //                print(result.value(forKey: "language"))
        //            }
        //        } catch {
        //            print(error)
        //        }
        
        //        UINavigationBar.appearance().backIndicatorImage = UIImage(named: "custom-back")
        //        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(named: "custom-back")
        
        view.backgroundColor = .white
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
        view.addSubview(languageSettingsLabel)
        languageSettingsLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(40)
            make.top.equalTo(audioSettingsLabel.snp.bottom).offset(20)
        }
        view.addSubview(languageLabel)
        languageLabel.snp.makeConstraints { make in
            make.leading.equalTo(languageSettingsLabel.snp.trailing).offset(40)
            make.top.equalTo(audioSettingsLabel.snp.bottom).offset(20)
        }
        view.addSubview(saveSettingsButton)
        saveSettingsButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(languageSettingsLabel.snp.bottom).offset(50)
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
        let topMainMenuController = MainMenuViewController()
        navigationController?.pushViewController(topMainMenuController, animated: true)
    }
}
