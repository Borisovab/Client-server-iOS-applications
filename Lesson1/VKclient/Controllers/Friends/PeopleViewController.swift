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

    var soursePeopleArray = [Human]()
    var modellPeople = [Human]()

    let tableViewCellReusableIdentifier = "tableViewCellReusableIdentifier"
    let thisIsNibName = "TableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        peopleTableView.register(UINib(nibName: thisIsNibName, bundle: nil), forCellReuseIdentifier: tableViewCellReusableIdentifier)

        peopleTableView.dataSource = self
        peopleTableView.delegate = self

        searchBarPeople.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        modellPeople = ModelPeople().peopleArray
        soursePeopleArray = modellPeople

    }
}


extension PeopleViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        if searchText.isEmpty {
            modellPeople = soursePeopleArray
        } else {
            modellPeople = soursePeopleArray.filter({ man in
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
        cell.configurePeople(avatar: UIImage(named: person.avatar), name: person.name, city: person.city, closure: { [weak self] in

            //осуществляем переход с анимацией по нажатию на ячейку
            guard let self = self else { return }

            let person = self.modellPeople[indexPath.row]
            NotificationCenter.default.post(name: Notification.Name("goToMyFriens"), object: person)
            _ = self.navigationController?.popViewController(animated: true)

        })

        return cell
    }
}


extension PeopleViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let person = modellPeople[indexPath.row]
//        NotificationCenter.default.post(name: Notification.Name("goToMyFriens"), object: person)
//        _ = navigationController?.popViewController(animated: true)
        
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

}
