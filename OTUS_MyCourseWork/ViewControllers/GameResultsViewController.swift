//
//  GameResultController.swift
//  OTUS_MyCourseWork
//
//  Created by Александр Ковбасин on 20.04.2023.
//

import UIKit
import CoreData

class InsetsTextField: UITextField {
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 4)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 4)
    }
}

class GameResultsViewController: UIViewController {
    var imageData: Data? = UIImage(named:"bottts.png")?.pngData()
    var playerPoints: Int = 0
    private let networkService: NetworkService = NetworkServiceImp()
    
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
        label.text = "\(NSLocalizedString("points label", comment: "")): \(playerPoints)"
        label.layer.cornerRadius = 20
        label.backgroundColor = .white
        label.alpha = 0
        label.layer.cornerRadius = 20
        label.layer.zPosition = 1
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
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 20.0)
        label.textColor = .black
        label.text = NSLocalizedString("name label", comment: "")
        label.alpha = 0
        label.layer.zPosition = 2
        return label
    }()
    private lazy var playerAvatarLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 20.0)
        label.textColor = .black
        label.text = NSLocalizedString("avatar label", comment: "")
        label.alpha = 0
        label.layer.zPosition = 2
        return label
    }()
    private lazy var playerNameTextField: InsetsTextField = {
        let textfield = InsetsTextField()
        textfield.placeholder = NSLocalizedString("name placeholder", comment: "")
        textfield.clearButtonMode = .whileEditing
        textfield.backgroundColor = .white
        textfield.layer.cornerRadius = 10
        textfield.alpha = 0
        textfield.layer.zPosition = 2
        textfield.delegate = self
        return textfield
    }()
    private lazy var playerNameError: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 10.0)
        label.textColor = .red
        label.text = NSLocalizedString("name error", comment: "")
        label.alpha = 0
        label.layer.zPosition = 2
        return label
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
    private lazy var generateAvatarButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 210/255, green: 212/255, blue: 246/255, alpha: 1)
        button.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15.0)
        button.setTitle(NSLocalizedString("generate", comment: ""), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(generateAvatar), for: .touchUpInside)
        button.alpha = 0
        button.layer.zPosition = 2
        return button
    }()
    private lazy var saveHighscoreButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.layer.borderColor = UIColor(red: 0/255, green: 0/255, blue: 0/225, alpha: 1).cgColor
        button.layer.cornerRadius = 15
        button.setTitle("\(NSLocalizedString("save highscore", comment: ""))!", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(savePlayer), for: .touchUpInside)
        button.alpha = 0
        button.layer.zPosition = 2
        return button
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        playerNameTextField.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let backgroundTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onBackgroundTap))
        view.addGestureRecognizer(backgroundTapGestureRecognizer)
        setupViews()
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
        
        UIView.animate(withDuration: 0.3, delay: 2) {
            self.playerNameLabel.alpha = 1
            self.playerNameTextField.alpha = 1
            self.playerAvatarLabel.alpha = 1
            self.avatarImageView.alpha = 1
            self.generateAvatarButton.alpha = 1
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
            make.top.equalToSuperview().offset(100)
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
            make.height.equalTo(400)
        }
        view.addSubview(playerNameLabel)
        playerNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(playerDataView.snp.leading).offset(20)
            make.top.equalTo(highScoreImageView.snp.top).offset(100)
            make.width.equalTo(80)
        }
        view.addSubview(playerNameTextField)
        playerNameTextField.snp.makeConstraints { make in
            make.trailing.equalTo(playerDataView.snp.trailing).offset(-20)
            make.centerY.equalTo(playerNameLabel.snp.centerY)
            make.width.equalTo(160)
            make.height.equalTo(40)
        }
        view.addSubview(playerNameError)
        playerNameError.snp.makeConstraints { make in
            make.bottom.equalTo(playerNameTextField.snp.top).offset(-5)
            make.centerX.equalTo(playerNameTextField.snp.centerX)
            make.width.equalTo(160)
            //      make.height.equalTo(30)
        }
        view.addSubview(playerAvatarLabel)
        playerAvatarLabel.snp.makeConstraints { make in
            make.leading.equalTo(playerDataView.snp.leading).offset(20)
            make.centerY.equalTo(playerNameLabel.snp.top).offset(100)
            make.width.equalTo(80)
        }
        view.addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints { make in
            make.centerX.equalTo(playerNameTextField.snp.centerX)
            make.top.equalTo(playerNameLabel.snp.top).offset(60)
            make.width.height.equalTo(80)
        }
        view.addSubview(generateAvatarButton)
        generateAvatarButton.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom).offset(20)
            make.centerX.equalTo(avatarImageView.snp.centerX)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        view.addSubview(saveHighscoreButton)
        saveHighscoreButton.snp.makeConstraints { make in
            make.centerX.equalTo(playerDataView.snp.centerX)
            make.top.equalTo(playerDataView.snp.bottom).offset(40)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
    }
    
    @objc func savePlayer(sender: UIButton!){
        guard let playerName = playerNameTextField.text?.trimmingCharacters(in: .whitespaces) else {
            playerNameError.alpha = 1
            return
        }
        if playerName == "" {
            playerNameError.alpha = 1
        } else {
            playerNameError.alpha = 0
            let managedObject = TopPlayers(entity: CoreDataManager.instance.entityForName(entityName: "TopPlayers"), insertInto: CoreDataManager.instance.context)
            managedObject.name = playerNameTextField.text
            managedObject.points = Int16(playerPoints)
            managedObject.avatar = imageData
            CoreDataManager.instance.saveContext()
            let mainMenuController = MainMenuViewController()
            let gameController = GameViewController()
            self.navigationController?.setViewControllers([mainMenuController, gameController], animated: true)
        }
    }
    
    @objc func exitGame(sender: UIButton!){
        UIView.animate(withDuration: 0, delay: 0.5) {
        }
    }
    
    @objc func generateAvatar(sender: UIButton!){
        self.generateAvatarButton.setTitle(NSLocalizedString("loading", comment: ""), for: .normal)
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
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        self.networkService.request(url: request) { result in
            switch result {
            case .success(let data):
                self.imageData = data
                self.avatarImageView.image = UIImage(data: data)
                self.generateAvatarButton.setTitle(NSLocalizedString("generate", comment: ""), for: .normal)
            case .failure:
                print("error")
                //error handler
                break
            }
        }
    }
    @objc private func onBackgroundTap() {
        view.endEditing(true)
    }
}

extension GameResultsViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else {
            return true
        }
        let resultString = text.replacingCharacters(in: Range(range, in: text)!, with: string)
        return resultString.count < 10
    }
}

