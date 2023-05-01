//
//  ViewController.swift
//  OTUS_MyCourseWork
//
//  Created by Александр Ковбасин on 28.02.2023.
//

import UIKit
import SnapKit
import AVFoundation

class GameViewController: UIViewController {
    let blinkSpeed: Double = 0.5
    //
    var playerSequence: [Int] = []
    var lampNumber: Int = 0
    
    private lazy var lamps = [
        LampModel(
            id: 0,
            view: violetLight,
            sound: "violet.wav"),
        LampModel(
            id: 1,
            view: redLight,
            sound: "red.wav"),
        LampModel(
            id: 2,
            view: yellowLight,
            sound: "yellow.wav"),
        LampModel(
            id: 3,
            view: greenLight,
            sound: "green.wav"),
        LampModel(
            id: 4,
            view: orangeLight,
            sound: "orange.wav"),
        LampModel(
            id: 5,
            view: blueLight,
            sound: "blue.wav")]
    
    var gameSequence: [Int] = Array([0, 1, 2, 3, 4, 5].shuffled().prefix(1))
    
    
    
    var playerPoints: Int = 0
    var gameLevel: Int = 1
    var isAudioOn = UserDefaultsManager.isAudioOn
    
    private var audioPlayer = AudioPlayer()
    private lazy var sizeConstant: CGFloat = view.frame.width * 0.7
    
    var operationQueue = OperationQueue()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.textColor = .black
        label.layer.cornerRadius = 20
        label.backgroundColor = .white
        label.alpha = 0
        label.layer.cornerRadius = 20
        //label.layer.backgroundColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
        label.layer.zPosition = 2
        //label.isHidden = true
        return label
    }()
    
//    private lazy var mainLabel: UILabel = {
//        let label = UILabel()
//        label.textAlignment = .center
//        label.font = UIFont.boldSystemFont(ofSize: 20.0)
//        label.textColor = .black
//        label.layer.cornerRadius = 20
//        label.backgroundColor = .white
//        label.alpha = 0
//        //label.layer.backgroundColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
//        label.layer.zPosition = 2
//        //label.isHidden = true
//        return label
//    }()
    private lazy var pointsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15.0)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "POINTS: 0"
        label.backgroundColor = .systemCyan
        label.layer.cornerRadius = 15
        label.layer.masksToBounds = true
        //label.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        //label.layer.borderWidth = 2
        label.layer.zPosition = 2
        return label
    }()
    private lazy var levelLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15.0)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "LEVEL 1"
        label.backgroundColor = .systemPurple
        label.layer.cornerRadius = 15
        label.layer.masksToBounds = true
//        label.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
//        label.layer.borderWidth = 2
        label.layer.zPosition = 2
        return label
    }()
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
        view.layer.zPosition = 2
        return view
    }()
    private lazy var toyImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "allOff.png")
        image.layer.zPosition = 2
        return image
    }()
    private lazy var yellowLight: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "yellowOn.png")
        image.layer.zPosition = 3
        image.alpha = 0
        return image
    }()
    private lazy var greenLight: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "greenOn.png")
        image.layer.zPosition = 3
        image.alpha = 0
        return image
    }()
    private lazy var violetLight: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "violetOn.png")
        image.layer.zPosition = 3
        image.alpha = 0
        return image
    }()
    private lazy var blueLight: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "blueOn.png")
        image.layer.zPosition = 3
        image.alpha = 0
        return image
    }()
    private lazy var orangeLight: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "orangeOn.png")
        image.layer.zPosition = 3
        image.alpha = 0
        return image
    }()
    private lazy var redLight: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "redOn.png")
        image.layer.zPosition = 3
        image.alpha = 0
        return image
    }()
    private lazy var violetButton: UIButton = {
        let button = UIButton()
        button.tag = 0
        //button.backgroundColor = .systemPurple
        button.layer.cornerRadius = sizeConstant/6
        button.layer.zPosition = 5
        button.isHidden = true
        button.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
        return button
    }()
    private lazy var redButton: UIButton = {
        let button = UIButton()
        button.tag = 1
        //button.backgroundColor = .systemRed
        button.layer.cornerRadius = sizeConstant/6
        button.layer.zPosition = 5
        button.isHidden = true
        button.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
        return button
    }()
    private lazy var yellowButton: UIButton = {
        let button = UIButton()
        button.tag = 2
        //button.backgroundColor = .systemYellow
        button.layer.cornerRadius = sizeConstant/6
        button.layer.zPosition = 5
        button.isHidden = true
        button.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
        return button
    }()
    private lazy var greenButton: UIButton = {
        let button = UIButton()
        button.tag = 3
        //button.backgroundColor = .systemGreen
        button.layer.cornerRadius = sizeConstant/6
        button.layer.zPosition = 5
        button.isHidden = true
        button.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
        return button
    }()
    private lazy var orangeButton: UIButton = {
        let button = UIButton()
        button.tag = 4
        //button.backgroundColor = .systemOrange
        button.layer.cornerRadius = sizeConstant/6
        button.layer.zPosition = 5
        button.isHidden = true
        button.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
        return button
    }()
    private lazy var blueButton: UIButton = {
        let button = UIButton()
        button.tag = 5
        //button.backgroundColor = .systemBlue
        button.layer.cornerRadius = sizeConstant/6
        button.layer.zPosition = 5
        button.isHidden = true
        button.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
        return button
    }()
    private lazy var startButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
//        button.layer.borderWidth = 2
//        button.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        button.layer.cornerRadius = 15
        button.layer.zPosition = 5
        button.setTitle("START", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
        button.addTarget(self, action: #selector(startGame), for: .touchUpInside)
        return button
    }()
    
    private func setupViews() {
        view.addSubview(backgroundView)
        view.addSubview(toyImageView)
        view.addSubview(violetLight)
        view.addSubview(redLight)
        view.addSubview(yellowLight)
        view.addSubview(greenLight)
        view.addSubview(orangeLight)
        view.addSubview(blueLight)
        view.addSubview(violetButton)
        view.addSubview(redButton)
        view.addSubview(yellowButton)
        view.addSubview(greenButton)
        view.addSubview(orangeButton)
        view.addSubview(blueButton)
        view.addSubview(startButton)
        
        backgroundView.snp.makeConstraints { make in
            //make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        view.addSubview(statusLabel)
        statusLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(toyImageView.snp.top).offset(-40)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
        view.addSubview(pointsLabel)
        pointsLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(30)
            make.top.equalToSuperview().offset(150)
            make.width.equalTo(120)
            make.height.equalTo(40)
        }
        view.addSubview(levelLabel)
        levelLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(30)
            make.top.equalToSuperview().offset(150)
            make.width.equalTo(120)
            make.height.equalTo(40)
        }
        toyImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(50)
            make.width.height.equalTo(sizeConstant)
        }
        violetLight.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(50)
            make.width.height.equalTo(sizeConstant)
        }
        redLight.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(50)
            make.width.height.equalTo(sizeConstant)
        }
        yellowLight.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(50)
            make.width.height.equalTo(sizeConstant)
        }
        greenLight.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(50)
            make.width.height.equalTo(sizeConstant)
        }
        orangeLight.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(50)
            make.width.height.equalTo(sizeConstant)
        }
        blueLight.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(50)
            make.width.height.equalTo(sizeConstant)
        }
        violetButton.snp.makeConstraints { make in
            make.centerX.equalTo(toyImageView.snp.centerX)
            make.centerY.equalTo(toyImageView.snp.centerY).offset(-sizeConstant/3)
            make.width.height.equalTo(sizeConstant/3)
        }
        redButton.snp.makeConstraints { make in
            make.centerX.equalTo(toyImageView.snp.centerX).offset(sizeConstant*0.3)
            make.centerY.equalTo(toyImageView.snp.centerY).offset(-sizeConstant/6)
            make.width.height.equalTo(sizeConstant/3)
        }
        yellowButton.snp.makeConstraints { make in
            make.centerX.equalTo(toyImageView.snp.centerX).offset(sizeConstant*0.3)
            make.centerY.equalTo(toyImageView.snp.centerY).offset(sizeConstant/6)
            make.width.height.equalTo(sizeConstant/3)
        }
        greenButton.snp.makeConstraints { make in
            make.centerX.equalTo(toyImageView.snp.centerX)
            make.centerY.equalTo(toyImageView.snp.centerY).offset(sizeConstant/3)
            make.width.height.equalTo(sizeConstant/3)
        }
        orangeButton.snp.makeConstraints { make in
            make.centerX.equalTo(toyImageView.snp.centerX).offset(-sizeConstant*0.3)
            make.centerY.equalTo(toyImageView.snp.centerY).offset(sizeConstant/6)
            make.width.height.equalTo(sizeConstant/3)
        }
        blueButton.snp.makeConstraints { make in
            make.centerX.equalTo(toyImageView.snp.centerX).offset(-sizeConstant*0.3)
            make.centerY.equalTo(toyImageView.snp.centerY).offset(-sizeConstant/6)
            make.width.height.equalTo(sizeConstant/3)
        }
        startButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(toyImageView.snp.bottom).offset(40)
            make.width.equalTo(150)
            make.height.equalTo(40)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
    }
    
    @objc func startGame(sender: UIButton!) {
//        pointsLabel.text = "POINTS: \(playerPoints)"
        levelLabel.text = "LEVEL: \(gameLevel)"
        statusLabel.alpha = 0
        statusLabel.transform = CGAffineTransform(scaleX: 1, y: 1)
        startButton.isHidden = true
        playerSequence = []
        lampNumber = 1
        gameSequence = gameSequence.shuffled()
        operationQueue.maxConcurrentOperationCount = 1
        showSequence(sequence: gameSequence, lampNumber: 1, delayOn: 0, delayOff: 0.3, sound: true)
        operationQueue.addOperation {
            DispatchQueue.main.async {
                self.showButtons()
            }
        }
        
    }
    
    func showSequence(sequence: [Int], lampNumber: Int, delayOn: TimeInterval?, delayOff: TimeInterval?, sound: Bool) {
        operationQueue.isSuspended = true
        for (index, item) in sequence.enumerated() {
            if index >= lampNumber {
                break
            }
            let lampImageView = lamps[item].view
            var lampSound: String? = nil
            if sound {
                lampSound = lamps[item].sound
            }
            let operation = LampOperation(view: lampImageView, sound: lampSound, delayOn: delayOn, delayOff: delayOff)
            operationQueue.addOperation(operation)
        }
        operationQueue.isSuspended = false
    }
    
    @objc func pressButton(sender: UIButton) {
        let buttonTag: Int = sender.tag
        //let lampImageView = lamps[buttonTag].view
        //let lampSound = lamps[buttonTag].sound
        operationQueue.maxConcurrentOperationCount = lampNumber
        //let operation = LampOperation(view: lampImageView, sound: lampSound, delayOn: 0, delayOff: 0.4)
        //operationQueue.addOperation(operation)
        //operationQueue.maxConcurrentOperationCount = 1
        showSequence(sequence: [buttonTag], lampNumber: 1, delayOn: 0, delayOff: 0.4, sound: true)
        playerSequence.append(buttonTag)
        if isEqualArray(playerSequence, with: gameSequence) {
            if playerSequence.count == lampNumber {
                playerPoints += 10
                operationQueue.addOperation {
                    DispatchQueue.main.async {
                        self.hideButtons()
                    }
                }
                if lampNumber == gameSequence.count {
                    gameLevel += 1
                    gameSequence.append(Int.random(in: 0...5))
                    pointsLabel.text = ("POINTS: \(playerPoints)")
                    //levelLabel.text = ("LEVEL: \(gameLevel)")
                    //                    let gameResultsController = GameResultsViewController()
                    //                    gameResultsController.isModalInPresentation = true
                    //                    gameResultsController.showGameResult(didWin: true, playerPoints: playerPoints)
                    //navigationController?.present(gameResultsController, animated: true)
                    statusLabel.text = "Level \(gameLevel - 1) complete!"
                    UIView.animate(withDuration: 0.5, delay: 0) {
                        self.statusLabel.alpha = 1
                        self.statusLabel.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                    }
                    
                    self.audioPlayer.playSound(soundFileName: "win.wav")
                    self.operationQueue.maxConcurrentOperationCount = 3
                    showSequence(sequence: [0, 2, 4, 1, 3, 5, 0, 2, 4, 1, 3, 5, 0, 2, 4, 1, 3, 5], lampNumber: 18, delayOn: 0, delayOff: 0.1, sound: false)
                    self.operationQueue.addOperation {
                        DispatchQueue.main.async {
                            self.startButton.isHidden = false
                        }
                    }
                }
                else {
                    pointsLabel.text = ("POINTS: \(playerPoints)")
                    lampNumber += 1
                    playerSequence = []
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                        self.operationQueue.maxConcurrentOperationCount = 1
                        self.showSequence(sequence: self.gameSequence, lampNumber: self.lampNumber, delayOn: 0, delayOff: 0.4, sound: true)
                        self.operationQueue.addOperation {
                            DispatchQueue.main.async {
                                self.showButtons()
                            }
                        }
                    }
                }
            }
        } else {
            operationQueue.addOperation {
                DispatchQueue.main.async {
                    self.hideButtons()
                }
            }
            //playerPoints = 0
            gameLevel = 1
            gameSequence = Array([0, 1, 2, 3, 4, 5].shuffled().prefix(5))
            statusLabel.text = "YOU LOST!"
            UIView.animate(withDuration: 0.5, delay: 0) {
                self.statusLabel.alpha = 1
                self.statusLabel.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            }
//            audioPlayer.playSound(soundFileName: "loss.wav")
//            operationQueue.maxConcurrentOperationCount = 1
//            showSequence(sequence: [0, 1, 2, 3, 4, 5], lampNumber: 6, delayOn: 0.3, delayOff: nil, sound: false)
//            showSequence(sequence: [5, 4, 3, 2, 1, 0], lampNumber: 6, delayOn: nil, delayOff: 0.3, sound: false)
            operationQueue.addOperation {
                DispatchQueue.main.async {
                    let gameResultsController = GameResultsViewController()
                    gameResultsController.playerPoints = self.playerPoints
                    //gameResultsController.setPlayerPoints(points: self.playerPoints)
                    self.navigationController?.setViewControllers([gameResultsController], animated: true)
                }
                
            }
            //startButton.isHidden = false
        }
    }
    
    func isEqualArray(_ array1: [Int], with array2: [Int]) -> Bool {
        var isEqual: Bool = true
        for (index, item) in array1.enumerated() {
            if index >= lampNumber {
                break
            }
            if item != (array2[index]) {
                isEqual = false
                break
            }
        }
        return isEqual
    }
    func hideButtons() {
        redButton.isHidden = true
        yellowButton.isHidden = true
        greenButton.isHidden = true
        orangeButton.isHidden = true
        blueButton.isHidden = true
        violetButton.isHidden = true
    }
    func showButtons() {
        redButton.isHidden = false
        yellowButton.isHidden = false
        greenButton.isHidden = false
        orangeButton.isHidden = false
        blueButton.isHidden = false
        violetButton.isHidden = false
    }
}


