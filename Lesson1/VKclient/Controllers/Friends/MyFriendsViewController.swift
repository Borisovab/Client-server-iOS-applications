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

    var searchFriends = [Human]()
    var modelFriend = [Human]()

    let webFriends = WebDataRequest()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        webFriends.sendFriendsGetRequest()
        print("\(Session.sharedInstance.token)")

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
//            modelFriend.sort(by: {$0.name < $1.name})
            searchFriends = modelFriend
            
            Storage.shared.friends = modelFriend
            print("\(Storage.shared.friends.count)")


            myFriendsTableView.reloadData()
        }
    }

    
}


extension MyFriendsViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        if searchText.isEmpty {
            modelFriend = searchFriends
        } else {
            modelFriend = searchFriends.filter({ searchedFriend in
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
        cell.configurePeople(avatar: UIImage(named: friend.avatar), name: friend.name, city: friend.city, closure: { [weak self] in

            //осуществляем переход с анимацией по нажатию на ячейку
            guard let self = self else { return }


            let alert = UIAlertController(title: self.modelFriend[indexPath.row].name, message: self.modelFriend[indexPath.row].city, preferredStyle: .actionSheet)

            let friendProfileAction = UIAlertAction(title: "Профиль", style: .default) { (alert) in
                self.performSegue(withIdentifier: "goToFriendProfile", sender: self.modelFriend[indexPath.item].id)
            }

            let deleteFriendProfileAction = UIAlertAction(title: "Удалить из друзей", style: .destructive) { (alert) in
                self.modelFriend.remove(at: indexPath.row)
                self.myFriendsTableView.reloadData()
            }

            alert.addAction(friendProfileAction)
            alert.addAction(deleteFriendProfileAction)

            alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        })

        return cell
    }
}


extension MyFriendsViewController: UITableViewDelegate {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToFriendProfile",
           let vc = segue.destination as? FriendProfileViewController,
           let arrayIndex = sender as? Int {

            vc.photoArrayIndex = arrayIndex
        }
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
