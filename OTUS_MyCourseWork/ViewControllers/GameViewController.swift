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
    
    var gameSequence: [Int] = Array([0, 1, 2, 3, 4, 5].shuffled().prefix(5))
    
    
    
    var playerPoints: Int = 0
    var gameLevel: Int = 1
    var isAudioOn = UserDefaultsManager.isAudioOn
    
    private var audioPlayer = AudioPlayer()
    private lazy var sizeConstant: CGFloat = view.frame.width * 0.7
    
    var operationQueue = OperationQueue()
    
    //    var operationQueue: OperationQueue = {
    //        let operationQueue = OperationQueue()
    //        operationQueue.maxConcurrentOperationCount = 1
    //        return operationQueue
    //    }()
    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 30.0)
        label.textColor = .black
        label.layer.cornerRadius = 20
        label.layer.backgroundColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
        label.layer.zPosition = 2
        label.isHidden = true
        return label
    }()
    private lazy var gameLevelLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 30.0)
        label.textColor = .black
        label.layer.cornerRadius = 20
        label.layer.backgroundColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
        label.layer.zPosition = 2
        label.isHidden = true
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
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor(red: 0/255, green: 0/255, blue: 0/225, alpha: 1).cgColor
        button.layer.cornerRadius = 15
        button.layer.zPosition = 5
        button.setTitle("START", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(startGame), for: .touchUpInside)
        return button
    }()
    
    
    //    let violetSound = URL(fileURLWithPath: Bundle.main.path(forResource: "violet", ofType: "wav")!)
    //    let redSound = URL(fileURLWithPath: Bundle.main.path(forResource: "red", ofType: "wav")!)
    //    let yellowSound = URL(fileURLWithPath: Bundle.main.path(forResource: "yellow", ofType: "wav")!)
    //    let greenSound = URL(fileURLWithPath: Bundle.main.path(forResource: "green", ofType: "wav")!)
    //    let orangeSound = URL(fileURLWithPath: Bundle.main.path(forResource: "orange", ofType: "wav")!)
    //    let blueSound = URL(fileURLWithPath: Bundle.main.path(forResource: "blue", ofType: "wav")!)
    //
    //    let startSound = URL(fileURLWithPath: Bundle.main.path(forResource: "start", ofType: "wav")!)
    //    let lossSound = URL(fileURLWithPath: Bundle.main.path(forResource: "loss", ofType: "wav")!)
    //    let winSound = URL(fileURLWithPath: Bundle.main.path(forResource: "win", ofType: "wav")!)
    
    
    
    
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
        view.addSubview(mainLabel)
        view.addSubview(gameLevelLabel)
        
        backgroundView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.leading.trailing.equalToSuperview()
        }
        mainLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(gameLevelLabel.snp.top).offset(-40)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
        
        gameLevelLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(toyImageView.snp.top).offset(-40)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
        toyImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(sizeConstant)
        }
        violetLight.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(sizeConstant)
        }
        redLight.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(sizeConstant)
        }
        yellowLight.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(sizeConstant)
        }
        greenLight.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(sizeConstant)
        }
        orangeLight.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(sizeConstant)
        }
        blueLight.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
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
        // navigationController?.navigationBar.isHidden = false
        //view.backgroundColor = UIColor(patternImage: UIImage(named: "bg.png")!)
        setupViews()
        
    }
    
    //    func lightLamp(lampImageView: UIImageView, lampSound: String) {
    //        lampImageView.alpha = 1.0
    //        DispatchQueue.main.asyncAfter(deadline: .now() + blinkSpeed) {
    //            lampImageView.alpha = 0
    //        }
    //        audioPlayer.playSound(soundFileName: lampSound)
    //    }
    
    @objc func startGame(sender: UIButton!) {
        enum NetworkError: Error {
            case customError
        }
        mainLabel.isHidden = false
        mainLabel.text = "POINTS: \(playerPoints)"
        gameLevelLabel.isHidden = false
        gameLevelLabel.text = "LEVEL: \(gameLevel)"
        startButton.isHidden = true
        playerSequence = []
        lampNumber = 1
        gameSequence = gameSequence.shuffled()
        showSequence(sequence: gameSequence, lampNumber: 1, duration: 0, delay: 0.4, type: "blink")
    }
    
    func showSequence(sequence: [Int], lampNumber: Int, duration: TimeInterval, delay: TimeInterval, type: String) {
        operationQueue.maxConcurrentOperationCount = 1
        operationQueue.isSuspended = true
        for (index, item) in sequence.enumerated() {
            if index >= lampNumber {
                break
            }
            let lampImageView = lamps[item].view
            let lampSound = lamps[item].sound
            var operation: AsyncOperation
            switch type {
//            case "blink":
//                operation = BlinkOperation(view: lampImageView, sound: lampSound, delayOn: delayOn, delayOff: delayOff)
            case "lighton":
                operation = LightOperation(view: lampImageView, duration: duration, delay: delay, sound: lampSound)
                operationQueue.addOperation(operation)
            case "lightoff":
                operation = LightOffOperation(view: lampImageView, duration: duration, delay: delay)
                operationQueue.addOperation(operation)
            case "blink":
                operation = LightOperation(view: lampImageView, duration: duration, delay: delay, sound: lampSound)
                operationQueue.addOperation(operation)
                operation = LightOffOperation(view: lampImageView, duration: duration, delay: delay)
                operationQueue.addOperation(operation)
            default:
                operation = LightOperation(view: lampImageView, duration: duration, delay: delay, sound: lampSound)
                operationQueue.addOperation(operation)
                //operation = BlinkOperation(view: lampImageView, sound: lampSound, delayOn: 0, delayOff: delay)
            }
            
            //            queue.addOperation { [weak self] in
            //                DispatchQueue.main.async {
            //
            //                    self?.lightLamp(lampImageView: item.view, lampSound: item.sound)
            //                }
            //                queue.isSuspended = true
            //                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            //                    queue.isSuspended = false
            //                }
            //            }
        }
        
        operationQueue.addOperation {
            DispatchQueue.main.async {
                self.showButtons()
            }
        }
        operationQueue.isSuspended = false
    }
    
    @objc func pressButton(sender: UIButton) {
        let buttonTag: Int = sender.tag
        
        //lightLamp(lampImageView: lampImageView, lampSound: lampSound)
        //operationQueue.maxConcurrentOperationCount = 6
        //let operation = BlinkOperation(view: lampImageView, sound: lampSound, delayOn: 0, delayOff: 0.4)
        //operationQueue.addOperation(operation)
        showSequence(sequence: [buttonTag], lampNumber: 1, duration: 0.1, delay: 0, type: "blink")
        //            queue.addOperation { [weak self] in
        //                DispatchQueue.main.async {
        //
        //                    self?.lightLamp(lampImageView: item.view, lampSound: item.sound)
        //                }
        //                queue.isSuspended = true
        //                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
        //                    queue.isSuspended = false
        //                }
        //            }
        
        playerSequence.append(buttonTag)
        if isEqualArray(playerSequence, with: gameSequence) {
            if playerSequence.count == lampNumber {
                hideButtons()
                if lampNumber == gameSequence.count {
                    startButton.isHidden = false
                    gameLevel+=1
                    let rnd: Int = Int.random(in: 0...5)
                    print (rnd)
                    gameSequence.append(rnd)
                    gameLevelLabel.text = ("LEVEL: \(gameLevel)")
                    let gameResultsController = GameResultsViewController()
                    gameResultsController.isModalInPresentation = true
                    gameResultsController.showGameResult(didWin: true, playerPoints: playerPoints)
                    navigationController?.present(gameResultsController, animated: true)
                    //mainLabel.text = "YOU WIN!"
                    audioPlayer.playSound(soundFileName: "win.wav")
                }
                else {
                    playerPoints += 10
                    mainLabel.text = ("POINTS: \(playerPoints)")
                    lampNumber += 1
                    playerSequence = []
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                        self.showSequence(sequence: self.gameSequence, lampNumber: self.lampNumber, duration: 0.1, delay: 0.1, type: "blink")
                    }
                }
            }
        } else {
            //let gameResultsController = GameResultsViewController()
            //            gameResultsController.isModalInPresentation = true
            //            gameResultsController.showGameResult(didWin: false, playerPoints: playerPoints)
            //            UIView.animate(withDuration: 2) {
            //                gameResultsController.highScoreImageView.alpha = 1
            //            }
            // navigationController?.present(gameResultsController, animated: true)
            //let mainMenuController = MainMenuViewController()
            //self.navigationController?.setViewControllers([gameResultsController], animated: true)
            //navigationController?.pushViewController(gameResultsController, animated: false)
            
            hideButtons()
            playerPoints = 0
            gameLevel = 1
            //gameSequence = Array([0, 1, 2, 3, 4, 5].shuffled().prefix(5))
            //mainLabel.text = "YOU LOOSE!"
            audioPlayer.playSound(soundFileName: "loss.wav")
            showSequence(sequence: [0, 1, 2, 3, 4, 5], lampNumber: 6, duration: 0, delay: 0.3, type: "light")
            showSequence(sequence: [5, 4, 3, 2, 1, 0], lampNumber: 6, duration: 0, delay: 0.3, type: "lightoff")
            operationQueue.addOperation {
                DispatchQueue.main.async {
                    let gameResultsController = GameResultsViewController()
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


