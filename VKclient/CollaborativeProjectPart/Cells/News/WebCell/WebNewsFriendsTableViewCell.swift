//
//  SecondWebNewsTableViewCell.swift
//  VKclient
//
//  Created by Александр Борисов on 12.08.2022.
//

import UIKit
import RealmSwift
import SwiftUI

class WebNewsFriendsTableViewCell: UITableViewCell {

    @IBOutlet weak var friendsInNewsVCCollectionView: UICollectionView!
    
    let registernibName = "PhotoGalleryCollectionViewCell"
    let photoGalleryCollectionViewCellReuseIdentifier = "PhotoGalleryCollectionViewCellReuseIdentifier"

    let networkService = WebDataRequest()
    var friendsFromRealm = [RealmFriendsArrayParam]()

    private var realmNotification: NotificationToken?

    func configureFriendsInNews() {

        friendsInNewsVCCollectionView.dataSource = self
        friendsInNewsVCCollectionView.delegate = self
        friendsInNewsVCCollectionView.register(UINib(nibName: registernibName, bundle: nil), forCellWithReuseIdentifier: photoGalleryCollectionViewCellReuseIdentifier)

        guard let realm = try? Realm() else { return }
        makeFriendsObserver(realm: realm)
        friendsInNewsVCCollectionView.reloadData()
    }

    private func makeFriendsObserver(realm: Realm) {
        let objs = realm.objects(RealmFriendsArrayParam.self)

        realmNotification = objs.observe({ changes in
            switch changes {
            case let .initial(objs):
                DispatchQueue.main.async { [self] in
                    self.friendsFromRealm = Array(objs)
                    self.friendsInNewsVCCollectionView.reloadData()
                }
            case .error(let error): print(error)
            case let .update(friends, _, _, _):

                DispatchQueue.main.async { [self] in
                    self.friendsFromRealm = Array(friends)
                    self.friendsInNewsVCCollectionView.reloadData()

                }
            }
        })
    }


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension WebNewsFriendsTableViewCell: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return friendsFromRealm.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photoGalleryCollectionViewCellReuseIdentifier, for: indexPath) as? PhotoGalleryCollectionViewCell else { return UICollectionViewCell() }

        let avatarFriend = friendsFromRealm[indexPath.row].avatar
        let url = URL(string: avatarFriend)

        cell.photoImage.showImage(with: url)

        cell.layer.cornerRadius = cell.photoImage.bounds.width/2
        cell.layer.borderWidth = 2
        cell.layer.borderColor = #colorLiteral(red: 0.874512732, green: 0.9583994746, blue: 0.9569959044, alpha: 1)

        return cell
    }
}

extension WebNewsFriendsTableViewCell: UICollectionViewDelegate {


}

extension WebNewsFriendsTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let height = collectionView.bounds.height
        let whiteSpaces: CGFloat = 0
        let cellWidth = height / 1 - whiteSpaces

        return CGSize(width: cellWidth, height: cellWidth)
    }
}
