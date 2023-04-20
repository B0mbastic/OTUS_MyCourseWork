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
    private lazy var sizeConstant: CGFloat = view.frame.width * 0.7
    
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
        image.layer.zPosition = 1
        return image
    }()
    private lazy var greenLight: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "greenOn.png")
        image.layer.zPosition = 1
        return image
    }()
    private lazy var violetLight: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "violetOn.png")
        image.layer.zPosition = 1
        return image
    }()
    private lazy var blueLight: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "blueOn.png")
        image.layer.zPosition = 1
        return image
    }()
    private lazy var orangeLight: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "orangeOn.png")
        image.layer.zPosition = 1
        return image
    }()
    private lazy var redLight: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "redOn.png")
        image.layer.zPosition = 1
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
    
    var audioPlayer: AVAudioPlayer!
    
    let violetSound = URL(fileURLWithPath: Bundle.main.path(forResource: "violet", ofType: "wav")!)
    let redSound = URL(fileURLWithPath: Bundle.main.path(forResource: "red", ofType: "wav")!)
    let yellowSound = URL(fileURLWithPath: Bundle.main.path(forResource: "yellow", ofType: "wav")!)
    let greenSound = URL(fileURLWithPath: Bundle.main.path(forResource: "green", ofType: "wav")!)
    let orangeSound = URL(fileURLWithPath: Bundle.main.path(forResource: "orange", ofType: "wav")!)
    let blueSound = URL(fileURLWithPath: Bundle.main.path(forResource: "blue", ofType: "wav")!)
    
    let startSound = URL(fileURLWithPath: Bundle.main.path(forResource: "start", ofType: "wav")!)
    let lossSound = URL(fileURLWithPath: Bundle.main.path(forResource: "loss", ofType: "wav")!)
    let winSound = URL(fileURLWithPath: Bundle.main.path(forResource: "win", ofType: "wav")!)
    
    let blinkSpeed: Double = 0.5
//
    var playerSubsequence: [Int] = []
    var lampNumber: Int = 0
    private lazy var lightQueue = [LampModel(id: 0, view: violetLight, sound: violetSound), LampModel(id: 1, view: redLight, sound: redSound), LampModel(id: 2, view: yellowLight, sound: yellowSound), LampModel(id: 3, view: greenLight, sound: greenSound)] //, LampModel(id: 4, view: orangeLight, sound: orangeSound), LampModel(id: 5, view: blueLight, sound: blueSound)]
    var playerPoints: Int = 0
    var gameLevel: Int = 1
    
    
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
            make.centerY.equalTo(toyImageView.snp.centerY).offset(200)
            make.width.equalTo(150)
            make.height.equalTo(40)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        //view.backgroundColor = UIColor(patternImage: UIImage(named: "bg.png")!)
        setupViews()
        
        
        
        
    }
    
    func lightLamp(lampImageView: UIImageView, lampSound: URL) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: lampSound)
            audioPlayer.play()
        } catch {
            // couldn't load file :(
        }
        
        lampImageView.layer.zPosition = 3
        DispatchQueue.main.asyncAfter(deadline: .now() + blinkSpeed) {
            lampImageView.layer.zPosition = 1
        }
    }
    
    @objc func startGame(sender: UIButton!) {
        enum NetworkError: Error {
            case customError
        }
        mainLabel.isHidden = false
        mainLabel.text = "POINTS: \(playerPoints)"
        gameLevelLabel.isHidden = false
        gameLevelLabel.text = "LEVEL: \(gameLevel)"
        startButton.isHidden = true
        playerSubsequence = []
        lampNumber = 1
        lightQueue = lightQueue.shuffled()
        showSequence(lampNumber: 1)
    }
    //queue.addOperation {
    //DispatchQueue.main.async {
    //                do {
    //                    audioPlayer = try AVAudioPlayer(contentsOf: startSound)
    //                    audioPlayer.play()
    //                } catch {
    //                    // couldn't load file :(
    //                }
    //}
    //}
    
    func showSequence(lampNumber: Int) {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        for (index, item) in lightQueue.enumerated() {
            if index >= lampNumber {
                break
            }
            queue.addOperation { [weak self] in
                DispatchQueue.main.async {
                    self?.lightLamp(lampImageView: item.view, lampSound: item.sound)
                }
                queue.isSuspended = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    queue.isSuspended = false
                }
            }
        }
        queue.addOperation {
            DispatchQueue.main.async {
                self.showButtons()
            }
        }
    }
    
    @objc func pressButton(sender: UIButton) {
        let tag: Int = sender.tag
        let lamp: UIImageView
        let sound: URL
        switch tag {
        case 0:
            lamp = violetLight
            sound = violetSound
        case 1:
            lamp = redLight
            sound = redSound
        case 2:
            lamp = yellowLight
            sound = yellowSound
        case 3:
            lamp = greenLight
            sound = greenSound
        case 4:
            lamp = orangeLight
            sound = orangeSound
        case 5:
            lamp = blueLight
            sound = blueSound
        default: return
        }
        lightLamp(lampImageView: lamp, lampSound: sound)
        playerSubsequence.append(sender.tag)
        if isEqualArray(playerSubsequence, with: lightQueue) {
            if playerSubsequence.count == lampNumber {
                hideButtons()
                if lampNumber == lightQueue.count {
                    startButton.isHidden = false
                    gameLevel+=1
                    let gameResultsController = GameResultsViewController()
                    gameResultsController.isModalInPresentation = true
                    gameResultsController.showGameResult(didWin: true, playerPoints: playerPoints)
                    navigationController?.present(gameResultsController, animated: true)
                    //mainLabel.text = "YOU WIN!"
                    do {
                        audioPlayer = try AVAudioPlayer(contentsOf: winSound)
                        audioPlayer.play()
                    } catch {
                        //couldn't load file :(
                    }
                }
                else {
                    playerPoints += 10
                    mainLabel.text = ("POINTS: \(playerPoints)")
                    lampNumber += 1
                    playerSubsequence = []
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                        self.showSequence(lampNumber: self.lampNumber)
                    }
                }
            }
        } else {
            let gameResultsController = GameResultsViewController()
            gameResultsController.isModalInPresentation = true
            gameResultsController.showGameResult(didWin: false, playerPoints: playerPoints)
            navigationController?.present(gameResultsController, animated: true)
            
            hideButtons()
            playerPoints = 0
            gameLevel = 1
            //mainLabel.text = "YOU LOOSE!"
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: lossSound)
                audioPlayer.play()
            } catch {
                //couldn't load file :(
            }
            startButton.isHidden = false
        }
    }
    func isEqualArray(_ array1: [Int], with array2: [LampModel]) -> Bool {
        var isEqual: Bool = true
        for (index, item) in array1.enumerated() {
            if index >= lampNumber {
                break
            }
            if item != (array2[index].id) {
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


