//
//  WebGroupNewsViewController.swift
//  VKclient
//
//  Created by Александр Борисов on 12.08.2022.
//

import UIKit

class WebGroupNewsViewController: UIViewController {

    @IBOutlet weak var webGroupNewsTableView: UITableView!

    let nameNibIdentifier = "WebNewsTableViewCell"
    let webNewsTableViewCellReuseIdentifier = "webNewsTableViewCellReuseIdentifier"


    let registerNameForNib = "TableViewCell"
    let tableViewCellReuseIdentifier = "tableViewCellReuseIdentifier"

    let networkService = WebDataRequest()
    var friendsResponse: JSONInfo<ResponseFriends>? = nil


    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        getRequest()

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
        webGroupNewsTableView.register(UINib(nibName: nameNibIdentifier, bundle: nil), forCellReuseIdentifier: webNewsTableViewCellReuseIdentifier)

        webGroupNewsTableView.register(UINib(nibName: registerNameForNib, bundle: nil), forCellReuseIdentifier: tableViewCellReuseIdentifier)

        webGroupNewsTableView.dataSource = self
        webGroupNewsTableView.delegate = self
    }

}


extension WebGroupNewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 10
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
            guard let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellReuseIdentifier, for: indexPath) as? TableViewCell else { return UITableViewCell() }

            let nameFriend = friendsResponse?.response.items.map{ $0.firstName }[indexPath.row]
            let lastNameFriend = friendsResponse?.response.items.map{ $0.lastName }[indexPath.row]

            let strUrl = friendsResponse?.response.items.map { $0.avatar }[indexPath.row] ?? ""
            let url = URL(string: strUrl)

            cell.configureCellFriends(name: nameFriend, surname: lastNameFriend)
            cell.imageView?.showImage(with: url)

            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: webNewsTableViewCellReuseIdentifier, for: indexPath) as? AnotherNewsTableViewCell else { return UITableViewCell() }


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

