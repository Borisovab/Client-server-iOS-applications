//
//  MyGroupsViewController.swift
//  VKclient
//
//  Created by Александр Борисов on 03.06.2022.
//

import UIKit

class MyGroupsViewController: UIViewController {

    @IBOutlet weak var myGroupsTableView: UITableView!
    @IBOutlet weak var searchBarGroup: UISearchBar!
    @IBOutlet weak var searchGroupsButton: UIBarButtonItem!
    
    
    let tableViewCellReusableIdentifier = "tableViewCellReusableIdentifier"
    let thisIsNibName = "TableViewCell"
    let goToGroupProfileSegueIdentifier = "goToGroupProfile"

    var searchGroup = [Group]()
    var myFriendGroup = [Group]()

    let webGroups = WebDataRequest()

    override func viewDidLoad() {
        super.viewDidLoad()

        webGroups.sendGroupsGetRequest()

        myGroupsTableView.register(UINib(nibName: thisIsNibName, bundle: nil), forCellReuseIdentifier: tableViewCellReusableIdentifier)

        myGroupsTableView.dataSource = self
        myGroupsTableView.delegate = self

        searchBarGroup.delegate = self

        NotificationCenter.default.addObserver(self, selector: #selector(didPressToGroup(_:)), name: Notification.Name("goToGroup"), object: nil)

        myGroupsTableView.reloadData()
    }

    @objc func didPressToGroup(_ notification: Notification) {

        guard let group = notification.object as? Group else { return }

        if !myFriendGroup.contains(where: { groupItem in
            groupItem.name == group.name
        }) {
            myFriendGroup.append(group)
            searchGroup = myFriendGroup
            myGroupsTableView.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            myFriendGroup.remove(at: indexPath.row)
            myGroupsTableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}


extension MyGroupsViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        if searchText.isEmpty {
            myFriendGroup = searchGroup
        } else {
            myFriendGroup = searchGroup.filter({ group in
                group.name.lowercased().contains(searchText.lowercased())
            })
        }
        myGroupsTableView.reloadData()
    }
}


extension MyGroupsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myFriendGroup.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellReusableIdentifier, for: indexPath) as? TableViewCell else { return UITableViewCell() }

        let group = myFriendGroup[indexPath.row]
        cell.configureTableViewCell(avatar: UIImage(named: group.avatar), name: group.name, description: group.description, closure: { [weak self] in

            //осуществляем переход с анимацией по нажатию на ячейку
            guard let self = self else { return }
            self.performSegue(withIdentifier: self.goToGroupProfileSegueIdentifier, sender: group.id)
            
        })

        return cell
    }
}


extension MyGroupsViewController: UITableViewDelegate {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == goToGroupProfileSegueIdentifier,
           let vc = segue.destination as? GroupProfileViewController,
//           let groupArray = sender as? [Group],
           let arrayIndex = sender as? Int {

            vc.photoArrayIndex = arrayIndex
//            vc.myGroupsArray = groupArray
        }
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
