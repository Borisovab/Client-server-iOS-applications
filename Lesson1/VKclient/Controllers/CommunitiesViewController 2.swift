//
//  CommunitiesViewController.swift
//  VKclient
//
//  Created by Александр Борисов on 03.06.2022.
//

import UIKit

class CommunitiesViewController: UIViewController {

    @IBOutlet weak var communitiesTableView: UITableView!
    @IBOutlet weak var searchBarCommunity: UISearchBar!
    
    let tableViewCellReusableIdentifier = "tableViewCellReusableIdentifier"
    let thisIsNibName = "TableViewCell"

    var searchCommunity = [Group]()
    var communities = [Group]()

    func setupCommunity() -> [Group] {
        var communities = [Group]()

        let group1 = Group(avatar: "Community1", name: "Железо", description: "Спорт")
        let group2 = Group(avatar: "Community2", name: "Боевые искуства", description: "Спорт")
        let group3 = Group(avatar: "Community3", name: "Занимательная наука", description: "Наука")
        let group4 = Group(avatar: "Community4", name: "Познаем мир", description: "Наука")
        let group5 = Group(avatar: "Community5", name: "Swift", description: "IT")
        let group6 = Group(avatar: "Community6", name: "Swiftbook", description: "IT")
        let group7 = Group(avatar: "Community7", name: "Наука и факты", description: "Наука")
        let group8 = Group(avatar: "Community8", name: "САМБО", description: "Спорт")
        let group9 = Group(avatar: "Community9", name: "Sputnik", description: "Новости")
        let group10 = Group(avatar: "Community10", name: "СоловьевLIVE", description: "Новости")

        communities.append(group1)
        communities.append(group2)
        communities.append(group3)
        communities.append(group4)
        communities.append(group5)
        communities.append(group6)
        communities.append(group7)
        communities.append(group8)
        communities.append(group9)
        communities.append(group10)

        return communities
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        communities = setupCommunity()
        searchCommunity = communities

        communitiesTableView.register(UINib(nibName: thisIsNibName, bundle: nil), forCellReuseIdentifier: tableViewCellReusableIdentifier)

        communitiesTableView.dataSource = self
        communitiesTableView.delegate = self

        searchBarCommunity.delegate = self
    }
}


extension CommunitiesViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        if searchText.isEmpty {
            communities = searchCommunity
        } else {
            communities = searchCommunity.filter({ group in
                group.name.lowercased().contains(searchText.lowercased())
            })
        }
        communitiesTableView.reloadData()
    }
}


extension CommunitiesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return communities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellReusableIdentifier, for: indexPath) as? TableViewCell else { return UITableViewCell() }

        let community = communities[indexPath.row]
        cell.configureTableViewCell(avatar: UIImage(named: community.avatar), name: community.name, description: community.description)

        return cell
    }
}


extension CommunitiesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let community = communities[indexPath.row]
        NotificationCenter.default.post(name: Notification.Name("goToGroup"), object: community)
        _ = navigationController?.popViewController(animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
