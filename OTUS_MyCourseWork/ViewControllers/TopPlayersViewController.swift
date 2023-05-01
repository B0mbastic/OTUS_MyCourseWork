//
//  TopPlaersViewControllers.swift
//  OTUS_MyCourseWork
//
//  Created by Александр Ковбасин on 10.04.2023.
//

import UIKit
import CoreData

class TopPlayersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var fetchResultController: NSFetchedResultsController<NSFetchRequestResult> = {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TopPlayers")
        let sortDescriptor = NSSortDescriptor(key: "points", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.instance.context, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultController
    }()
    
    let cellID = "cellID"
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
        return view
    }()
    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30.0)
        label.text = "Top players"
        label.textColor = .black
        return label
    }()
    private lazy var topPlayersTableView: UITableView = {
        let table = UITableView(frame: view.bounds, style: .plain)
        table.backgroundColor = .systemGray6
        table.layer.cornerRadius = 20
        table.register(TopPlayersTableCell.self, forCellReuseIdentifier: cellID)
        table.delegate = self
        table.dataSource = self
        table.rowHeight = 100
        return table
    }()
    
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
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(40)
        }
        view.addSubview(topPlayersTableView)
        topPlayersTableView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().offset(-40)
            make.top.equalTo(mainLabel.snp.bottom).offset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        do {
            try fetchResultController.performFetch()
        } catch {
            print(error)
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchResultController.sections {
            return sections[section].numberOfObjects
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = topPlayersTableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? TopPlayersTableCell
        let player = fetchResultController.object(at: indexPath) as! TopPlayers
        cell?.playerNameLabel.text = player.name
        cell?.playerPointsLabel.text = String(player.points)
        cell?.playerAvatarImageView.image = UIImage(data: player.avatar!)
//        let personName: String
//        personName = "\(personsArray[indexPath.row].personFirstName) \(personsArray[indexPath.row].personMiddleName) \(personsArray [indexPath.row].personLastName)"
//        cell?.setPersonName(personName: personName, personPhoto: personsArray[indexPath.row].personPhoto)
        return cell ?? TopPlayersTableCell()
    }
}


//extension TopPlayersViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let personViewController = PersonViewController()
//        personViewController.personFirstName = personsArray[indexPath.row].personFirstName
//        personViewController.personMiddleName = personsArray[indexPath.row].personMiddleName
//        personViewController.personLastName = personsArray[indexPath.row].personLastName
//
//        personViewController.personPhoto = personsArray[indexPath.row].personPhoto
//
//        //present(personViewController, animated: true)
//        self.navigationController?.pushViewController(personViewController, animated: true)
//    }
//}
