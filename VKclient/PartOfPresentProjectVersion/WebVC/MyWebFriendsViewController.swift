//
//  MyWebFriendsViewController.swift
//  VKclient
//
//  Created by Александр Борисов on 04.08.2022.
//

import UIKit
import RealmSwift
import SwiftUI

class MyWebFriendsViewController: UIViewController {

    @IBOutlet weak var myWebFriendsTableView: UITableView!

    let registerNameForNib = "TableViewCell"
    let tableViewCellReuseIdentifier = "tableViewCellReuseIdentifier"

    let networkService = WebDataRequest()
    var friendsResponse: JSONInfo<ResponseFriends>? = nil
    var friendsFromRealm = [FriendsModel]()


    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.hidesBackButton = true

        setupTableView()
        getRequest()
        friendsFromRealm = (try? networkService.restoreFriends()) ?? []

    }

    func getRequest() {
        networkService.request() { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let friendsInfo):
                friendsInfo.response.items.map { (name) in

                    self.friendsResponse = friendsInfo
                    self.myWebFriendsTableView.reloadData()
                }
            case .failure(let error):
                print("error: - ", error)
            }
        }
    }

    private func setupTableView() {
        myWebFriendsTableView.register(UINib(nibName: registerNameForNib, bundle: nil), forCellReuseIdentifier: tableViewCellReuseIdentifier)

        myWebFriendsTableView.dataSource = self
        myWebFriendsTableView.delegate = self
    }
}


extension MyWebFriendsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsFromRealm.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellReuseIdentifier, for: indexPath) as? TableViewCell else { return UITableViewCell() }

        let nameFriend = friendsFromRealm[indexPath.row].firstName
        let lastNameFriend = friendsFromRealm[indexPath.row].lastName
        let avatarFriend = friendsFromRealm[indexPath.row].avatar

        let url = URL(string: avatarFriend)

        cell.configureCellFriends(name: nameFriend, surname: lastNameFriend)
        cell.imageView?.showImage(with: url)

        return cell
    }
}

extension MyWebFriendsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}
