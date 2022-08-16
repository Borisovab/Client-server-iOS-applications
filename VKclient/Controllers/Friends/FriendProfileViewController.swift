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
    @IBOutlet weak var shadowView: UIView!
    

    @IBOutlet weak var friendPhotoGallaryCollectionView: UICollectionView!

    let photoGalleryCollectionViewCellReuseIdentifier = "photoGalleryCollectionViewCellReuseIdentifier"

    let goToFullScreenSegue = "goToFullScreen"

    var friend = ModelPeople()
    var indexPath: IndexPath! 

    var miniGallery = [PhotosForFriendsGallery]()
    var photoArrayIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()


        friendPhotoGallaryCollectionView.register(UINib(nibName: "PhotoGalleryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: photoGalleryCollectionViewCellReuseIdentifier)

        friendPhotoGallaryCollectionView.dataSource = self
        friendPhotoGallaryCollectionView.delegate = self

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        miniGallery = Storage.shared.peopleForSelect.peopleArray[photoArrayIndex].photoGallery

        configureProfile()
        shadowForAvatar()

    }

    func configureProfile() {

        photoFriend.layer.cornerRadius = self.photoFriend.bounds.height / 2
        photoFriend.image = UIImage(named: friend.peopleArray[photoArrayIndex].avatar)
        nameFriend.text = friend.peopleArray[photoArrayIndex].name
        nameFriend.textColor = #colorLiteral(red: 0.3538695574, green: 0, blue: 0.5538253784, alpha: 1)
        cityFriend.text = friend.peopleArray[photoArrayIndex].city
        cityFriend.textColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
    }


    func shadowForAvatar() {

        shadowView.layer.cornerRadius = photoFriend.layer.cornerRadius
        shadowView.layer.borderWidth = 2
        shadowView.layer.borderColor = UIColor.systemTeal.cgColor

        shadowView.layer.shadowRadius = 7
        shadowView.layer.shadowOffset = CGSize(width: 15, height: 15)
        shadowView.layer.shadowOpacity = 0.6
        shadowView.layer.shadowColor = UIColor.gray.cgColor
    }
}


extension FriendProfileViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return miniGallery.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photoGalleryCollectionViewCellReuseIdentifier, for: indexPath) as? PhotoGalleryCollectionViewCell else { return UICollectionViewCell() }

        let photo = miniGallery[indexPath.item].url

        cell.configureGallery(photo: UIImage(named: photo))

        return cell
    }
}


extension FriendProfileViewController: UICollectionViewDelegate {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        if segue.identifier == goToFullScreenSegue,
           let vc = segue.destination as? FriendsPhotoViewController,
           let arrayIndexFriends = sender as? Int {

            vc.indexArray = arrayIndexFriends
        }
    }


    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        performSegue(withIdentifier: goToFullScreenSegue, sender: photoArrayIndex)
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
