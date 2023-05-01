//
//  TopPlayersTableCell.swift
//  OTUS_MyCourseWork
//
//  Created by Александр Ковбасин on 15.04.2023.
//

import Foundation
import UIKit


class TopPlayersTableCell: UITableViewCell {
    let playerAvatarImageView = UIImageView()
    
    lazy var playerNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()
    
    lazy var playerPointsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemGray6

        addSubview(playerAvatarImageView)
        playerAvatarImageView.frame = CGRect(x: 10, y: 10, width: 80, height: 80)
        playerAvatarImageView.contentMode = .scaleAspectFill
        playerAvatarImageView.clipsToBounds = true
        
        addSubview(playerNameLabel)
        playerNameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(120)
            make.centerY.equalTo(self)
        }
        addSubview(playerPointsLabel)
        playerPointsLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(200)
            make.centerY.equalTo(self)
        }
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
