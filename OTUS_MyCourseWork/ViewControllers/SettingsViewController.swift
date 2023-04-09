//
//  SettingsViewController.swift
//  OTUS_MyCourseWork
//
//  Created by Александр Ковбасин on 09.04.2023.
//

import UIKit

class SettingsViewController: UIViewController {
    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30.0)
        label.text = "Settings"
        label.textColor = .black
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        UINavigationBar.appearance().backIndicatorImage = UIImage(named: "custom-back")
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(named: "custom-back")
        
        view.backgroundColor = .white
        view.addSubview(mainLabel)
        mainLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(100)
        }
        
    }
}
