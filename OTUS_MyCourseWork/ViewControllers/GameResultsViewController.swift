//
//  GameResultController.swift
//  OTUS_MyCourseWork
//
//  Created by Александр Ковбасин on 20.04.2023.
//

import UIKit

class InsetsTextField: UITextField {
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 4)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 4)
    }
}

class GameResultsViewController: UIViewController {
    
    private let networkService: NetworkService = NetworkServiceImp()
    
    private lazy var imageData: Data = Data()
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
        return view
    }()
    private lazy var highScoreImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "highscore.png")
        image.alpha = 0
        image.layer.zPosition = 2
        return image
    }()
    private lazy var pointsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.textColor = .black
        label.layer.cornerRadius = 20
        label.backgroundColor = .white
        label.alpha = 0
        label.layer.cornerRadius = 20
        //label.layer.backgroundColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
        label.layer.zPosition = 1
        //label.isHidden = true
        return label
    }()
    private lazy var playerDataView: UIView = {
        let view = UIView()
        view.alpha = 0
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 20
        //view.layer.borderWidth = 1
        view.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        view.layer.zPosition = 1
        return view
    }()
    private lazy var playerNameLabel: UILabel = {
        let label = UILabel()
        //label.backgroundColor = .systemGreen
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 20.0)
        label.textColor = .black
        label.text = "Name:"
        label.alpha = 0
        label.layer.zPosition = 2
        return label
    }()
    private lazy var playerAvatarLabel: UILabel = {
        let label = UILabel()
        //label.backgroundColor = .systemGreen
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 20.0)
        label.textColor = .black
        label.text = "Aavatar:"
        label.alpha = 0
        label.layer.zPosition = 2
        return label
    }()
    private lazy var playerNameTextField: InsetsTextField = {
        let textfield = InsetsTextField()
        textfield.backgroundColor = .white
        textfield.layer.cornerRadius = 10
       // textfield.layer.borderWidth = 1
        textfield.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        textfield.alpha = 0
        textfield.layer.zPosition = 2
        return textfield
    }()
    private lazy var avatarImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "bottts.png")
        image.alpha = 0
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.layer.zPosition = 2
        return image
    }()
    private lazy var loadButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 210/255, green: 212/255, blue: 246/255, alpha: 1)
        //button.layer.borderWidth = 1
        button.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15.0)
        button.setTitle("Generate", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(loadImage), for: .touchUpInside)
        button.alpha = 0
        button.layer.zPosition = 2
        return button
    }()
        private lazy var saveHighscoreButton: UIButton = {
            let button = UIButton()
            button.backgroundColor = .systemGreen
            //button.layer.borderWidth = 1
            button.layer.borderColor = UIColor(red: 0/255, green: 0/255, blue: 0/225, alpha: 1).cgColor
            button.layer.cornerRadius = 15
            button.setTitle("Save my highscore!", for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
            button.setTitleColor(.white, for: .normal)
            button.addTarget(self, action: #selector(playGame), for: .touchUpInside)
            button.alpha = 0
            button.layer.zPosition = 2
            return button
        }()
    //    private lazy var restartButton: UIButton = {
    //        let button = UIButton()
    //        button.backgroundColor = .systemGreen
    //        button.layer.borderWidth = 2
    //        button.layer.borderColor = UIColor(red: 0/255, green: 0/255, blue: 0/225, alpha: 1).cgColor
    //        button.layer.cornerRadius = 20
    //        button.layer.zPosition = 5
    //        button.setTitle("Play again", for: .normal)
    //        button.setTitleColor(.black, for: .normal)
    //        //button.titleLabel?.font =  UIFont(name: "", size: 40)
    //        button.addTarget(self, action: #selector(playGame), for: .touchUpInside)
    //        return button
    //    }()
    //    private lazy var exitButton: UIButton = {
    //        let button = UIButton()
    //        button.backgroundColor = .systemYellow
    //        button.layer.borderWidth = 2
    //        button.layer.borderColor = UIColor(red: 0/255, green: 0/255, blue: 0/225, alpha: 1).cgColor
    //        button.layer.cornerRadius = 20
    //        button.layer.zPosition = 5
    //        button.setTitle("Back to main menu", for: .normal)
    //        button.setTitleColor(.black, for: .normal)
    //        //button.titleLabel?.font =  UIFont(name: "", size: 40)
    //        button.addTarget(self, action: #selector(exitGame), for: .touchUpInside)
    //        return button
    //    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        pointsLabel.text = "YOUR POINTS: 1000"
        
        UIView.animate(withDuration: 0.5, delay: 0.2) {
            self.pointsLabel.alpha = 1
            self.pointsLabel.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }
        
        UIView.animate(withDuration: 0.5, delay: 0.5) {
            self.playerDataView.alpha = 1
        }
        
        UIView.animate(withDuration: 1, delay: 0.5) {
            self.highScoreImageView.alpha = 1
            self.highScoreImageView.transform = CGAffineTransform(scaleX: 3, y: 3)
        }
        
        UIView.animate(withDuration: 0.3, delay: 1.5) {
            self.highScoreImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
        
        UIView.animate(withDuration: 0, delay: 2) {
            self.playerNameLabel.alpha = 1
            self.playerNameTextField.alpha = 1
            self.playerAvatarLabel.alpha = 1
            self.avatarImageView.alpha = 1
            self.loadButton.alpha = 1
            self.saveHighscoreButton.alpha = 1
        }
    }
    
    func setupViews() {
        view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        view.addSubview(pointsLabel)
        pointsLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(200)
        }
        view.addSubview(highScoreImageView)
        highScoreImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(pointsLabel.snp.bottom).offset(80)
            make.width.equalTo(220)
            make.height.equalTo(60)
        }
        view.addSubview(playerDataView)
        playerDataView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().offset(-40)
            make.top.equalTo(pointsLabel.snp.bottom).offset(40)
            make.height.equalTo(450)
        }
        view.addSubview(playerNameLabel)
        playerNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(playerDataView.snp.leading).offset(40)
            make.top.equalTo(highScoreImageView.snp.top).offset(100)
            make.width.equalTo(80)
        }
        view.addSubview(playerNameTextField)
        playerNameTextField.snp.makeConstraints { make in
            make.leading.equalTo(playerNameLabel.snp.trailing).offset(40)
            //make.top.equalTo(playerDataView.snp.top).offset(40)
            make.centerY.equalTo(playerNameLabel.snp.centerY)
            make.width.equalTo(150)
            make.height.equalTo(40)
        }
        view.addSubview(playerAvatarLabel)
        playerAvatarLabel.snp.makeConstraints { make in
            make.leading.equalTo(playerDataView.snp.leading).offset(40)
            make.centerY.equalTo(playerNameLabel.snp.top).offset(100)
            make.width.equalTo(80)
        }
        view.addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints { make in
            //make.centerX.equalToSuperview()
            make.leading.equalTo(playerAvatarLabel.snp.trailing).offset(40)
            make.top.equalTo(playerNameLabel.snp.top).offset(60)
            make.width.height.equalTo(80)
        }
        view.addSubview(loadButton)
        loadButton.snp.makeConstraints { make in
            //make.leading.equalTo(playerDataView.snp.leading).offset(40)
            make.top.equalTo(avatarImageView.snp.bottom).offset(20)
            make.centerX.equalTo(avatarImageView.snp.centerX)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        view.addSubview(saveHighscoreButton)
        saveHighscoreButton.snp.makeConstraints { make in
            //make.leading.equalTo(playerDataView.snp.leading).offset(40)
            //make.top.equalTo(avatarImageView.snp.bottom).offset(20)
            make.centerX.equalTo(playerDataView.snp.centerX)
            make.top.equalTo(playerDataView.snp.bottom).offset(40)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
    }
    @objc func playGame(sender: UIButton!){
        DispatchQueue.main.async {
            let gameController = GameViewController()
            self.navigationController?.setViewControllers([gameController], animated: true)
        }
    }
    @objc func exitGame(sender: UIButton!){
        UIView.animate(withDuration: 0, delay: 0.5) {
        }
    }
    
    @objc func loadImage(sender: UIButton!){
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.dicebear.com"
        components.path = "/6.x/bottts/png"
        components.queryItems = [
            URLQueryItem(name: "seed", value: "\(Int.random(in: 0...100))"),
            URLQueryItem(name: "size", value: "80"),
            URLQueryItem(name: "backgroundColor", value: "d1d4f9")
        ]
        
        guard let url = components.url else { return }
        
        print(url)
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        self.networkService.request(url: request) { result in
            switch result {
            case .success(let data):
//                print(data)
//                self.imageData = data
                self.avatarImageView.image = UIImage(data: data)
            case .failure:
                //error handler
                break
            }
        }
        

    }
}

