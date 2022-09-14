//
//  MyWebGroupsViewController.swift
//  VKclient
//
//  Created by Александр Борисов on 11.08.2022.
//

import UIKit
import RealmSwift
import SwiftUI
import FirebaseFirestore


class MyWebGroupsViewController: UIViewController {

    let gateway = GroupsGateway(
        network: NetworkController(),
        dataBase: RealmStorage()
    )

    let database = Firestore.firestore()

    @IBOutlet weak var myGroupsTableView: UITableView!

    let registerNameForNib = "TableViewCell"
    let tableViewCellReuseIdentifier = "tableViewCellReuseIdentifier"

//    let networkService = WebDataRequest()
    var groupsResponse: JSONInfo<ResponseGroups>? = nil
    var groupsFromRealm = [RealmGroupsArrayParam]()
    var usersFromRealm = DataAboutUser()
    var groupsViewPosts = [GroupsPostViewModel]()

    private var realmNotification: NotificationToken?
    private var firstGroupName: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()

        gateway.loadPosts{ [weak self] post in
            guard let self = self else { return }
            self.groupsViewPosts = post
        }



//        getGroupsRequest()

        guard let realm = try? Realm() else { return }
        makeGroupsObserver(realm: realm)
        myGroupsTableView.reloadData()

        firstGroupName = realm
            .objects(RealmGroupsArrayParam.self)
            .first?
            .observe(keyPaths: [], { (changes: ObjectChange<RealmGroupsArrayParam>) in
                switch changes {
                case .error(let error): print(error)
                case .change(let value, let propertiesArray): print("\(value.name) --> \(propertiesArray)")
                case .deleted: print("delited")

                }
            })
    }

//    func getGroupsRequest() {
//        networkService.requestForGroups { [weak self] (result) in
//            guard let self = self else { return }
//            switch result {
//            case .success(let groupsInfo):
//                groupsInfo.response.items.map { (name) in
//
//                    self.groupsResponse = groupsInfo
//                    self.myGroupsTableView.reloadData()
//                }
//            case .failure(let error):
//                print("error: - ", error)
//            }
//        }
//    }

    private func setupTableView() {
        myGroupsTableView.register(UINib(nibName: registerNameForNib, bundle: nil), forCellReuseIdentifier: tableViewCellReuseIdentifier)

        myGroupsTableView.dataSource = self
        myGroupsTableView.delegate = self
    }

    private func makeGroupsObserver(realm: Realm) {
        let objs = realm.objects(RealmGroupsArrayParam.self)

        realmNotification = objs.observe({ changes in
            switch changes {
            case let .initial(objs):
                self.groupsFromRealm = Array(objs)
                self.myGroupsTableView.reloadData()
            case .error(let error): print(error)
            case let .update(groups, deletions, insertions, modifications):

                DispatchQueue.main.async { [self] in
                    self.groupsFromRealm = Array(groups)

                    myGroupsTableView.reloadData()

//                    myGroupsTableView.beginUpdates()
//
//                    myGroupsTableView.deleteRows(at: deletions.map ({IndexPath(row: $0, section: 0)}), with: .automatic)
//                    myGroupsTableView.insertRows(at: insertions.map ({IndexPath(row: $0, section: 0)}), with: .automatic)
//                    myGroupsTableView.reloadRows(at: modifications.map ({IndexPath(row: $0, section: 0)}), with: .automatic)
//
//                    myGroupsTableView.endUpdates()
                }
            }

            let id = Session.sharedInstance.userId

            let user = FBUser.mock(array: self.groupsFromRealm, id: id)
            let data = (try? JSONEncoder().encode(user)) ?? Data()
            let dict = (try? JSONSerialization.jsonObject(with: data) as? [String: Any]) ?? [:]

            self.database
                .collection("CollectionUsersGroup")
                .document("UserParam")
                .setData(dict)
        })
    }
}


extension MyWebGroupsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupsViewPosts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellReuseIdentifier, for: indexPath) as? TableViewCell else { return UITableViewCell() }

        let nameGroup = groupsViewPosts[indexPath.row].name
        let avatarGroup = groupsViewPosts[indexPath.row].avatar 
        
        let url = URL(string: avatarGroup)

        cell.configureCellFriends(name: nameGroup, surname: nil)
        cell.imageView?.showImage(with: url)

        return cell
    }
}

extension MyWebGroupsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}
