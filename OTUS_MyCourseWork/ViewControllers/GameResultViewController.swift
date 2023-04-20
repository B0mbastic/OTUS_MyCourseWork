//
//  GameResultController.swift
//  OTUS_MyCourseWork
//
//  Created by Александр Ковбасин on 20.04.2023.
//

import UIKit

class GameResultsViewController: UIViewController {
    //var didWin: Bool = false
//    private lazy var backgroundView: UIView = {
//        let view = UIView()
//        view.layer.backgroundColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.9)
//        //view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
//        return view
//    }()
    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30.0)
        label.text = ""
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
        button.setTitle("", for: .normal)
        button.setTitleColor(.black, for: .normal)
        //button.titleLabel?.font =  UIFont(name: "", size: 40)
        button.addTarget(self, action: #selector(playGame), for: .touchUpInside)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.backgroundColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.9)
        //view.isHidden = true
        //view.addSubview(backgroundView)
//        backgroundView.snp.makeConstraints { make in
//            make.top.equalToSuperview()
//            make.leading.equalToSuperview().offset(50)
//            make.trailing.equalToSuperview().offset(-50)
//            make.bottom.equalToSuperview().offset(-50)
//        }
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
    }
    func showGameResult(didWin: Bool, playerPoints: Int){
        if didWin {
            mainLabel.text = "Congrats! You won this!"
            pointsLabel.text = "Your points are: \(playerPoints)"
            restartButton.setTitle("PLAY NEXT!", for: .normal)
        }
        else {
            mainLabel.text = "Sorry! You lost!"
            pointsLabel.text = "Your points are: \(playerPoints)"
            restartButton.setTitle("TRY AGAIN!", for: .normal)
            
        }
    }
    @objc func playGame(sender: UIButton!){
       // _ = navigationController?.popToRootViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
}

