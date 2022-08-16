//
//  WebGroupNewsViewController.swift
//  VKclient
//
//  Created by Александр Борисов on 12.08.2022.
//

import UIKit

class WebGroupNewsViewController: UIViewController {

    @IBOutlet weak var webGroupNewsTableView: UITableView!

    let nameNibIdentifier = "WebNewsFriendsTableViewCell"
    let webNewsFriendsTableViewCellReuseIdentifier = "webNewsFriendsTableViewCellReuseIdentifier"


    let registerNameForNib = "WebNewsTableViewCell"
    let webNewsTableViewCellReuseIdentifier = "webNewsTableViewCellReuseIdentifier"

    let networkService = WebDataRequest()
    var friendsResponse: JSONInfo<ResponseFriends>? = nil
    var groupsResponse: JSONInfo<ResponseGroups>? = nil


    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        getRequest()
        getGroupsRequest()

    }

    func getGroupsRequest() {
        networkService.requestForGroups { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let groupsInfo):
                groupsInfo.response.items.map { (name) in

                    self.groupsResponse = groupsInfo
                    self.webGroupNewsTableView.reloadData()
                }
            case .failure(let error):
                print("error: - ", error)
            }
        }
    }

    func getRequest() {
        networkService.request() { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let friendsInfo):
                friendsInfo.response.items.map { (name) in

                    self.friendsResponse = friendsInfo
                    self.webGroupNewsTableView.reloadData()
                }
            case .failure(let error):
                print("error: - ", error)
            }
        }
    }

    private func setupTableView() {
        webGroupNewsTableView.register(UINib(nibName: nameNibIdentifier, bundle: nil), forCellReuseIdentifier: webNewsFriendsTableViewCellReuseIdentifier)

        webGroupNewsTableView.register(UINib(nibName: registerNameForNib, bundle: nil), forCellReuseIdentifier: webNewsTableViewCellReuseIdentifier)

        webGroupNewsTableView.dataSource = self
        webGroupNewsTableView.delegate = self
    }
}


extension WebGroupNewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return groupsResponse?.response.items.map { $0.id }.count ?? 1
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        if section == 0 {
            return "Мои друзья"
        } else {
            return "Новости групп"
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: webNewsFriendsTableViewCellReuseIdentifier, for: indexPath) as? WebNewsFriendsTableViewCell else { return UITableViewCell() }

            cell.configureFriendsInNews()

            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: webNewsTableViewCellReuseIdentifier, for: indexPath) as? WebNewsTableViewCell else { return UITableViewCell() }

            let groupName = groupsResponse?.response.items.map {$0.name}[indexPath.row]
            let strUrl = groupsResponse?.response.items.map { $0.photo100 }[indexPath.row] ?? ""
            let url = URL(string: strUrl)
            cell.avatarImage.showImage(with: url)
            cell.configureNews()
            cell.configureName(name: groupName)


            
            return cell
        }
    }
}

extension WebGroupNewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if indexPath.section == 0 {
            return 130
        } else {

            return 350
        }

    }
}

