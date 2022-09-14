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

    let gateWay = FriendsGateway(
        network: NetworkController(),
        dataBase: RealmStorage()
    )

    @IBOutlet weak var myWebFriendsTableView: UITableView!

    let registerNameForNib = "TableViewCell"
    let tableViewCellReuseIdentifier = "tableViewCellReuseIdentifier"

    var friendsResponse: JSONInfo<ResponseFriends>? = nil
    var friendsFromRealm = [RealmFriendsArrayParam]()
    var friendsViewPosts = [FriendsPostViewModel]()

    private var realmNotification: NotificationToken?
    private var firstFriendsName: NotificationToken?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        setupTableView()

        gateWay.loadPosts { [weak self] post in
            guard let self = self else { return }
            self.friendsViewPosts = post
        }

        guard let realm = try? Realm() else { return }
        makeFriendsObserver(realm: realm)
        myWebFriendsTableView.reloadData()

        firstFriendsName = realm
            .objects(RealmFriendsArrayParam.self)
            .first?
            .observe(keyPaths: [], { (changes: ObjectChange<RealmFriendsArrayParam>) in
                switch changes {
                case .error(let error): print(error)
                case .change(let value, let propertiesArray): print("\(value.firstName) --> \(propertiesArray)")
                case .deleted: print("delited")
                }
            })
    }

    private func setupTableView() {
        myWebFriendsTableView.register(UINib(nibName: registerNameForNib, bundle: nil), forCellReuseIdentifier: tableViewCellReuseIdentifier)

        myWebFriendsTableView.dataSource = self
        myWebFriendsTableView.delegate = self
    }

    private func makeFriendsObserver(realm: Realm) {
        let objs = realm.objects(RealmFriendsArrayParam.self)

        realmNotification = objs.observe({ changes in
            switch changes {
            case let .initial(objs):
                self.friendsFromRealm = Array(objs)
                self.myWebFriendsTableView.reloadData()
            case .error(let error): print(error)
            case let .update(friends, deletions, insertions, modifications):

                DispatchQueue.main.async { [self] in
                    self.friendsFromRealm = Array(friends)

                    myWebFriendsTableView.reloadData()

//                    myWebFriendsTableView.beginUpdates()
//
//                    myWebFriendsTableView.deleteRows(at: deletions.map ({IndexPath(row: $0, section: 0)}), with: .automatic)
//                    myWebFriendsTableView.insertRows(at: insertions.map ({IndexPath(row: $0, section: 0)}), with: .automatic)
//                    myWebFriendsTableView.reloadRows(at: modifications.map ({IndexPath(row: $0, section: 0)}), with: .automatic)
//
//                    myWebFriendsTableView.endUpdates()


                }
            }
        })
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            do {
                let realm = try Realm()

                try realm.write{
                    realm.delete(friendsFromRealm[indexPath.row])

                    friendsFromRealm.remove(at: indexPath.row)
                    myWebFriendsTableView.deleteRows(at: [indexPath], with: .fade)
                }
            } catch {
                print(error)
            }
            myWebFriendsTableView.reloadData()
        }
    }


}


extension MyWebFriendsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsViewPosts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellReuseIdentifier, for: indexPath) as? TableViewCell else { return UITableViewCell() }

        let nameFriend = friendsViewPosts[indexPath.row].firstName
        let lastNameFriend = friendsViewPosts[indexPath.row].lastName
        let avatarFriend = friendsViewPosts[indexPath.row].avatar

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
