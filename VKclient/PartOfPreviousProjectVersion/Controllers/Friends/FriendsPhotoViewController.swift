//
//  FriendsPhotoViewController.swift
//  VKclient
//
//  Created by Александр Борисов on 06.06.2022.
//

import UIKit

class FriendsPhotoViewController: UIViewController {

    @IBOutlet weak var friendsPhotoCollectionView: UICollectionView!

    let SelectedPhotoCollectionViewCellReuseIdentifier = "SelectedPhotoCollectionViewCellReuseIdentifier"

    var friend: Human!
    var friendsGallery = ModelPeople()
    var photoAlbum = [PhotosForFriendsGallery]()
    var indexArray = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        friendsPhotoCollectionView.register(UINib(nibName: "SelectedPhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: SelectedPhotoCollectionViewCellReuseIdentifier)

        friendsPhotoCollectionView.dataSource = self
        friendsPhotoCollectionView.delegate = self

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        photoAlbum = Storage.shared.peopleForSelect.peopleArray[indexArray].photoGallery

        friendsPhotoCollectionView.reloadData()
    }
}


extension FriendsPhotoViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoAlbum.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectedPhotoCollectionViewCellReuseIdentifier, for: indexPath) as? SelectedPhotoCollectionViewCell else { return UICollectionViewCell() }

        let localIndexArray = indexArray
        let currentPhotoAlbum = Storage.shared.peopleForSelect.peopleArray[localIndexArray].photoGallery
        let indexForCellConfigure = currentPhotoAlbum[indexPath.item]

        let photo = UIImage(named: indexForCellConfigure.url)

        cell.configureSelectedGallery(photo: photo, isLiked: indexForCellConfigure.isLiked, likeCouter: indexForCellConfigure.likeCounter, onLikeClosure: { (isLikePressed, currentCounter) in

            print("counter \(currentCounter)")
            print(isLikePressed ? "true" : "false")
            Storage.shared.peopleForSelect.peopleArray[localIndexArray].photoGallery[indexPath.item].isLiked = isLikePressed
            Storage.shared.peopleForSelect.peopleArray[localIndexArray].photoGallery[indexPath.item].likeCounter = currentCounter

        })

        return cell
    }
}


extension FriendsPhotoViewController: UICollectionViewDelegate {

}


extension FriendsPhotoViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = collectionView.bounds.width
        let whiteSpaces: CGFloat = 0
        let cellWidth = width / 1 - whiteSpaces

        return CGSize(width: cellWidth, height: cellWidth)
    }
}
