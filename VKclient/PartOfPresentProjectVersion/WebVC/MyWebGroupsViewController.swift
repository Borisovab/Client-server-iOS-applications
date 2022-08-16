//
//  MyWebGroupsViewController.swift
//  VKclient
//
//  Created by Александр Борисов on 11.08.2022.
//

import UIKit

class MyWebGroupsViewController: UIViewController {


    @IBOutlet weak var myGroupsTableView: UITableView!

    let registerNameForNib = "TableViewCell"
    let tableViewCellReuseIdentifier = "tableViewCellReuseIdentifier"

    let networkService = WebDataRequest()
    var groupsResponse: JSONInfo<ResponseGroups>? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        getGroupsRequest()

    }

    func getGroupsRequest() {
        networkService.requestForGroups { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let groupsInfo):
                groupsInfo.response.items.map { (name) in

                    self.groupsResponse = groupsInfo
                    self.myGroupsTableView.reloadData()
                }
            case .failure(let error):
                print("error: - ", error)
            }
        }
    }

    private func setupTableView() {
        myGroupsTableView.register(UINib(nibName: registerNameForNib, bundle: nil), forCellReuseIdentifier: tableViewCellReuseIdentifier)

        myGroupsTableView.dataSource = self
        myGroupsTableView.delegate = self
    }

}


extension MyWebGroupsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupsResponse?.response.items.map { $0.name }.count ?? 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellReuseIdentifier, for: indexPath) as? TableViewCell else { return UITableViewCell() }

        let nameGroup = groupsResponse?.response.items.map{ $0.name }[indexPath.row]
        let avatarGroup = groupsResponse?.response.items.map({ $0.photo100 })[indexPath.row]

        print("-->-->-->-->-->-->-->-->--> TO CELL <--<--<--<--<--<--<--<--<--<--")
        print("name: - ", nameGroup)
        print("photo: - ", avatarGroup)

        let strUrl = groupsResponse?.response.items.map { $0.photo100 }[indexPath.row] ?? ""
        let url = URL(string: strUrl)

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
