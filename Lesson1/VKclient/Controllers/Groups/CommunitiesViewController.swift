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

    override func viewDidLoad() {
        super.viewDidLoad()

        communitiesTableView.register(UINib(nibName: thisIsNibName, bundle: nil), forCellReuseIdentifier: tableViewCellReusableIdentifier)

        communitiesTableView.dataSource = self
        communitiesTableView.delegate = self

        searchBarCommunity.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        communities = ModelGroup().communities
        searchCommunity = communities
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
        cell.configureTableViewCell(avatar: UIImage(named: community.avatar), name: community.name, description: community.description, closure: { [weak self] in
            
            //осуществляем переход с анимацией по нажатию на ячейку
            guard let self = self else { return }

            let community = self.communities[indexPath.row]
            NotificationCenter.default.post(name: Notification.Name("goToGroup"), object: community)
            _ = self.navigationController?.popViewController(animated: true)
        })

        return cell
    }
}


extension CommunitiesViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
