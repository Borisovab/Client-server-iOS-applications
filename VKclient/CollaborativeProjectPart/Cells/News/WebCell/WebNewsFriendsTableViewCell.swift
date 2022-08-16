//
//  SecondWebNewsTableViewCell.swift
//  VKclient
//
//  Created by Александр Борисов on 12.08.2022.
//

import UIKit

class WebNewsFriendsTableViewCell: UITableViewCell {

    @IBOutlet weak var friendsInNewsVCCollectionView: UICollectionView!
    
    let registernibName = "PhotoGalleryCollectionViewCell"
    let photoGalleryCollectionViewCellReuseIdentifier = "PhotoGalleryCollectionViewCellReuseIdentifier"

    let networkService = WebDataRequest()
    var friendsFromRealm = [FriendsModel]()


    func configureFriendsInNews() {

        friendsInNewsVCCollectionView.dataSource = self
        friendsInNewsVCCollectionView.delegate = self
        friendsInNewsVCCollectionView.register(UINib(nibName: registernibName, bundle: nil), forCellWithReuseIdentifier: photoGalleryCollectionViewCellReuseIdentifier)

        friendsFromRealm = (try? networkService.restoreFriends()) ?? []
        friendsInNewsVCCollectionView.reloadData()

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
