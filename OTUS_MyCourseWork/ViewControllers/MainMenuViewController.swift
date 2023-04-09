//
//  mainMenuViewController.swift
//  OTUS_MyCourseWork
//
//  Created by Александр Ковбасин on 09.04.2023.
//

import UIKit

class MainMenuViewController: UIViewController {
    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30.0)
        label.text = "Repeat-a-color"
        return label
    }()
    private lazy var loadCharactersButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor(red: 0/255, green: 0/255, blue: 0/225, alpha: 1).cgColor
        button.layer.cornerRadius = 15
        button.setTitle("PLAY GAME", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(playGame), for: .touchUpInside)
        return button
    }()
    
    private lazy var loadLocationsButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemYellow
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor(red: 0/255, green: 0/255, blue: 0/225, alpha: 1).cgColor
        button.layer.cornerRadius = 15
        button.setTitle("SETTINGS", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(openSettings), for: .touchUpInside)
        return button
    }()
    
    private lazy var loadEpisodesButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemPurple
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor(red: 0/255, green: 0/255, blue: 0/225, alpha: 1).cgColor
        button.layer.cornerRadius = 15
        button.setTitle("TOP PLAYERS", for: .normal)
        button.setTitleColor(.black, for: .normal)
        //button.addTarget(self, action: #selector(openTopPlayers), for: .touchUpInside)
        return button
    }()
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(mainLabel)
        mainLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(100)
        }
        view.addSubview(loadCharactersButton)
        loadCharactersButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(mainLabel.snp.bottom).offset(50)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
        
        view.addSubview(loadLocationsButton)
        loadLocationsButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(loadCharactersButton.snp.bottom).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
        
        view.addSubview(loadEpisodesButton)
        loadEpisodesButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(loadLocationsButton.snp.bottom).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
    }
    @objc func playGame(sender: UIButton!){
        let gameController = GameViewController()
        navigationController?.pushViewController(gameController, animated: true)
    }
    @objc func openSettings(sender: UIButton!){
        let settingsController = SettingsViewController()
        navigationController?.pushViewController(settingsController, animated: false)
    }
}
