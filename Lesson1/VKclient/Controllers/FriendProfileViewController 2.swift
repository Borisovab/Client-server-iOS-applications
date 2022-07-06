//
//  FriendProfileViewController.swift
//  VKclient
//
//  Created by Александр Борисов on 03.06.2022.
//

import UIKit

class FriendProfileViewController: UIViewController {

    @IBOutlet weak var photoFriend: UIImageView!
    @IBOutlet weak var nameFriend: UILabel!
    @IBOutlet weak var cityFriend: UILabel!

    @IBOutlet weak var friendPhotoGallaryCollectionView: UICollectionView!

    let photoGalleryCollectionViewCellReuseIdentifier = "photoGalleryCollectionViewCellReuseIdentifier"

    let goToFullScreenSegue = "goToFullScreen"

    var indexPath: IndexPath!
    var friend: Human!

    override func viewDidLoad() {
        super.viewDidLoad()

        photoFriend.image = UIImage(named: friend.avatar)
        nameFriend.text = friend.name
        nameFriend.textColor = #colorLiteral(red: 0.3538695574, green: 0, blue: 0.5538253784, alpha: 1)
        cityFriend.text = friend.city
        cityFriend.textColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)

        friendPhotoGallaryCollectionView.register(UINib(nibName: "PhotoGalleryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: photoGalleryCollectionViewCellReuseIdentifier)

        friendPhotoGallaryCollectionView.dataSource = self
        friendPhotoGallaryCollectionView.delegate = self


    }
}


extension FriendProfileViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return friend.photoGallery.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photoGalleryCollectionViewCellReuseIdentifier, for: indexPath) as? PhotoGalleryCollectionViewCell else { return UICollectionViewCell() }

        let photo = friend.photoGallery[indexPath.item].url

        cell.configureGallery(photo: UIImage(named: photo))

        return cell
    }
}


extension FriendProfileViewController: UICollectionViewDelegate {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        if segue.identifier == goToFullScreenSegue,
           let destinationController = segue.destination as? FriendsPhotoViewController,
           let photo = sender as? Human {

            destinationController.photoAlbum = photo.photoGallery
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedPhoto = friend.photoGallery[indexPath.item]
        performSegue(withIdentifier: goToFullScreenSegue, sender: selectedPhoto)
    }


}


extension FriendProfileViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = collectionView.bounds.width
        let whiteSpaces: CGFloat = 3
        let cellWidth = width / 2 - whiteSpaces

        return CGSize(width: cellWidth, height: cellWidth)
    }
}
