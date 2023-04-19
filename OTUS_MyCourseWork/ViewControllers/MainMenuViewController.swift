//
//  mainMenuViewController.swift
//  OTUS_MyCourseWork
//
//  Created by Александр Ковбасин on 09.04.2023.
//

import UIKit

class MainMenuViewController: UIViewController {
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
        return view
    }()
    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 30.0)
        label.textColor = .black
        label.layer.cornerRadius = 20
        label.layer.backgroundColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
        label.text = "Repeat-a-color"
        label.textColor = .black
        return label
    }()
    private lazy var gameButton: UIButton = {
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
    
    private lazy var settingsButton: UIButton = {
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
    
    private lazy var topPlayersButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemPurple
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor(red: 0/255, green: 0/255, blue: 0/225, alpha: 1).cgColor
        button.layer.cornerRadius = 15
        button.setTitle("TOP PLAYERS", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(openTopPlayers), for: .touchUpInside)
        return button
    }()
    
    var lang: String = "ru"
    
    private func setupViews() {
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
            make.height.equalTo(40)
        }
        view.addSubview(gameButton)
        gameButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(mainLabel.snp.bottom).offset(50)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
        
        view.addSubview(settingsButton)
        settingsButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(gameButton.snp.bottom).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
        
        view.addSubview(topPlayersButton)
        topPlayersButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(settingsButton.snp.bottom).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        //print(StartLabel.lang.rawValue)
        
    }
    @objc func playGame(sender: UIButton!){
        let gameController = GameViewController()
        navigationController?.pushViewController(gameController, animated: true)
    }
    @objc func openSettings(sender: UIButton!){
        let settingsController = SettingsViewController()
        navigationController?.pushViewController(settingsController, animated: true)
    }
    @objc func openTopPlayers(sender: UIButton!){
        let topPlayersController = TopPlayersViewController()
        navigationController?.pushViewController(topPlayersController, animated: true)
    }
}
