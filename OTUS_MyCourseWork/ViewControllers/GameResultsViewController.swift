//
//  GameResultController.swift
//  OTUS_MyCourseWork
//
//  Created by Александр Ковбасин on 20.04.2023.
//

import UIKit

class GameResultsViewController: UIViewController {
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
        return view
    }()
    lazy var highScoreImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "highscore.png")
        image.alpha = 0
        return image
    }()
//    private lazy var highScoreLabel: UILabel = {
//        let label = UILabel()
//        //label.font = UIFont.boldSystemFont(ofSize: 30.0)
//        label.font = UIFont(name: "Futura", size: 30.0)
//        label.text = "New highscore!"
//        label.backgroundColor = .systemRed
//        label.layer.cornerRadius = 30
//        label.textColor = .white
//        return label
//    }()
    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30.0)
        label.text = "GAME OVER!"
        label.textColor = .white
        return label
    }()
    private lazy var pointsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30.0)
        label.text = ""
        label.textColor = .white
        return label
    }()
    private lazy var restartButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor(red: 0/255, green: 0/255, blue: 0/225, alpha: 1).cgColor
        button.layer.cornerRadius = 20
        button.layer.zPosition = 5
        button.setTitle("Play again", for: .normal)
        button.setTitleColor(.black, for: .normal)
        //button.titleLabel?.font =  UIFont(name: "", size: 40)
        button.addTarget(self, action: #selector(playGame), for: .touchUpInside)
        return button
    }()
    private lazy var exitButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemYellow
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor(red: 0/255, green: 0/255, blue: 0/225, alpha: 1).cgColor
        button.layer.cornerRadius = 20
        button.layer.zPosition = 5
        button.setTitle("Back to main menu", for: .normal)
        button.setTitleColor(.black, for: .normal)
        //button.titleLabel?.font =  UIFont(name: "", size: 40)
        button.addTarget(self, action: #selector(exitGame), for: .touchUpInside)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
    }
    
    func setupViews() {
        view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        view.addSubview(highScoreImageView)
        highScoreImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(50)
            make.width.equalTo(250)
            make.height.equalTo(70)
            
        }
        view.addSubview(mainLabel)
        mainLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(200)
        }
        
        view.addSubview(pointsLabel)
        pointsLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(mainLabel.snp.bottom).offset(20)
        }
        view.addSubview(restartButton)
        restartButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(pointsLabel.snp.bottom).offset(50)
            make.width.equalTo(150)
            make.height.equalTo(50)
        }
        view.addSubview(exitButton)
        exitButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(restartButton.snp.bottom).offset(10)
            make.width.equalTo(150)
            make.height.equalTo(50)
        }
    }
    func showGameResult(didWin: Bool, playerPoints: Int){
        if didWin {
            mainLabel.text = "Level complete!"
            pointsLabel.text = "Your points are: \(playerPoints)"
            restartButton.setTitle("PLAY NEXT!", for: .normal)
        }
        else {
            mainLabel.text = "GAME OVER"
            pointsLabel.text = "Your points are: \(playerPoints)"
            restartButton.setTitle("TRY AGAIN!", for: .normal)
        }

    }
    @objc func playGame(sender: UIButton!){
        DispatchQueue.main.async {
            let gameController = GameViewController()
            self.navigationController?.setViewControllers([gameController], animated: true)
        }
    }
    @objc func exitGame(sender: UIButton!){
        //self.dismiss(animated: true, completion: nil)

        UIView.animate(withDuration: 1) {
            self.highScoreImageView.alpha = 1
        }
    }
}

