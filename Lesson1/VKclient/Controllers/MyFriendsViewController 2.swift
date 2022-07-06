//
//  MyFriendsViewController.swift
//  VKclient
//
//  Created by Александр Борисов on 03.06.2022.
//

import UIKit

class MyFriendsViewController: UIViewController {

    @IBOutlet weak var myFriendsTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    let tableViewCellReusableIdentifier = "tableViewCellReusableIdentifier"
    let thisIsNibName = "TableViewCell"

    var sourceArrayFriends = [Human]()
    var modelFriend = [Human]()

    override func viewDidLoad() {
        super.viewDidLoad()


        myFriendsTableView.register(UINib(nibName: thisIsNibName, bundle: nil), forCellReuseIdentifier: tableViewCellReusableIdentifier)

        myFriendsTableView.dataSource = self
        myFriendsTableView.delegate = self

        NotificationCenter.default.addObserver(self, selector: #selector(didPressToFriends(_:)), name: Notification.Name("goToMyFriens"), object: nil)

        searchBar.delegate = self
    }


    @objc func didPressToFriends(_ notification: Notification) {

        guard let friend = notification.object as? Human else { return }

        if !modelFriend.contains(where: { peopleItem in
            peopleItem.name == friend.name
        }) {
            modelFriend.append(friend)
            modelFriend.sort(by: {$0.name < $1.name})
            sourceArrayFriends = modelFriend
            myFriendsTableView.reloadData()
        }
    }
}


extension MyFriendsViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        if searchText.isEmpty {
            modelFriend = sourceArrayFriends
        } else {
            modelFriend = sourceArrayFriends.filter({ searchedFriend in
                searchedFriend.name.lowercased().contains(searchText.lowercased())
            })
        }

        myFriendsTableView.reloadData()
    }
}


extension MyFriendsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelFriend.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellReusableIdentifier, for: indexPath) as? TableViewCell else { return UITableViewCell() }

        let friend = modelFriend[indexPath.row]
        cell.configurePeople(avatar: UIImage(named: friend.avatar), name: friend.name, city: friend.city)

        return cell
    }
}


extension MyFriendsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let alert = UIAlertController(title: modelFriend[indexPath.row].name, message: modelFriend[indexPath.row].city, preferredStyle: .actionSheet)

        let friendProfileAction = UIAlertAction(title: "Профиль", style: .default) { (alert) in
            self.performSegue(withIdentifier: "goToFriendProfile", sender: indexPath)
        }

        let deleteFriendProfileAction = UIAlertAction(title: "Удалить из друзей", style: .destructive) { (alert) in
            self.modelFriend.remove(at: indexPath.row)
            self.myFriendsTableView.reloadData()
        }

        alert.addAction(friendProfileAction)
        alert.addAction(deleteFriendProfileAction)

        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToFriendProfile" {
            let vc = segue.destination as! FriendProfileViewController
            let indexPath = sender as! IndexPath

            let friend = modelFriend[indexPath.item]
            vc.friend = friend
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
