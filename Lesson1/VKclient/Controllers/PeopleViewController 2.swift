//
//  PeopleViewController.swift
//  VKclient
//
//  Created by Александр Борисов on 03.06.2022.
//

import UIKit

class PeopleViewController: UIViewController {

    @IBOutlet weak var peopleTableView: UITableView!
    @IBOutlet weak var searchBarPeople: UISearchBar!

//    var soursePeopleArray = ModelPeople().peopleArray
//    var modellPeople = ModelPeople().peopleArray

    var modellPeople = [Human]()

    let tableViewCellReusableIdentifier = "tableViewCellReusableIdentifier"
    let thisIsNibName = "TableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        modellPeople = Storage.shared.friends.peopleArray

        peopleTableView.register(UINib(nibName: thisIsNibName, bundle: nil), forCellReuseIdentifier: tableViewCellReusableIdentifier)

        peopleTableView.dataSource = self
        peopleTableView.delegate = self

        searchBarPeople.delegate = self
    }
}


extension PeopleViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        if searchText.isEmpty {
            modellPeople = Storage.shared.friends.peopleArray
        } else {
            modellPeople = Storage.shared.friends.peopleArray.filter({ man in
                man.name.lowercased().contains(searchText.lowercased())
            })
        }
        peopleTableView.reloadData()
    }
}


extension PeopleViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modellPeople.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellReusableIdentifier, for: indexPath) as? TableViewCell else { return UITableViewCell() }

        let person = modellPeople[indexPath.row]
        cell.configurePeople(avatar: UIImage(named: person.avatar), name: person.name, city: person.city)

        return cell
    }
}


extension PeopleViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let person = modellPeople[indexPath.row]
        NotificationCenter.default.post(name: Notification.Name("goToMyFriens"), object: person)
        _ = navigationController?.popViewController(animated: true)
        
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

}
