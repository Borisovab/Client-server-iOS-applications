//
//  NewsViewController.swift
//  VKclient
//
//  Created by Александр Борисов on 29.06.2022.
//

import UIKit

class NewsViewController: UIViewController {

    @IBOutlet weak var newsTableView: UITableView!

    let anotherNewsTableViewCellReusableIdentifier = "anotherNewsTableViewCellReusableIdentifier"
    let registerNibName = "AnotherNewsTableViewCell"

    let newsTableViewCellReusableIdentifier = "newsTableViewCellReusableIdentifier"
    let registerNibNameForFriends = "NewsTableViewCell"

    var myGroupsArrayForNews = [Group]()

    var indexPath: IndexPath!

    let webFriendsPhotos = WebDataRequest()

    override func viewDidLoad() {
        super.viewDidLoad()

        webFriendsPhotos.sendFriedsPhotoGetRequest()

        newsTableView.register(UINib(nibName: registerNibName, bundle: nil), forCellReuseIdentifier: anotherNewsTableViewCellReusableIdentifier)
        newsTableView.register(UINib(nibName: registerNibNameForFriends, bundle: nil), forCellReuseIdentifier: newsTableViewCellReusableIdentifier)

        newsTableView.dataSource = self
        newsTableView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        myGroupsArrayForNews = Storage.shared.groups.communities
        newsTableView.reloadData()
    }
}


extension NewsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return myGroupsArrayForNews.count
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
            guard let cell = tableView.dequeueReusableCell(withIdentifier: newsTableViewCellReusableIdentifier, for: indexPath) as? NewsTableViewCell else { return UITableViewCell() }


            cell.configureNews()

            return cell

        } else {

            guard let cell = tableView.dequeueReusableCell(withIdentifier: anotherNewsTableViewCellReusableIdentifier, for: indexPath) as? AnotherNewsTableViewCell else { return UITableViewCell() }

            let group = myGroupsArrayForNews[indexPath.row]

            NotificationCenter.default.post(name: Notification.Name("indexForAnotherNewsTVCell"), object: group.id)

            cell.configure(avatar: UIImage(named: group.avatar), name: group.name, album: group.album)

            return cell
        }
    }
}


extension NewsViewController: UITableViewDelegate{

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if indexPath.section == 0 {
            return 70
        } else {

            return 350
        }

    }
}



