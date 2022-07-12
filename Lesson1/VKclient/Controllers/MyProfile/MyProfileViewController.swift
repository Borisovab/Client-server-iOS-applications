//
//  MyProfileViewController.swift
//  VKclient
//
//  Created by Александр Борисов on 03.06.2022.
//

import UIKit

class MyProfileViewController: UIViewController {

    @IBOutlet weak var myAvatarImage: UIImageView! {
        didSet {
            self.myAvatarImage.layer.borderColor = UIColor.systemTeal.cgColor
            self.myAvatarImage.layer.borderWidth = 2
            self.myAvatarImage.layer.cornerRadius = self.myAvatarImage.bounds.width / 2
        }
    }

    @IBOutlet weak var myNameLabel: UILabel! {
        didSet {
            self.myNameLabel.textColor = #colorLiteral(red: 0.3538695574, green: 0, blue: 0.5538253784, alpha: 1)
        }
    }

    @IBOutlet weak var myCityLabel: UILabel! {
        didSet {
            self.myCityLabel.textColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
        }
    }

    @IBOutlet weak var myProfilePhotoView: UIView!
    @IBOutlet weak var myProfileCollectionView: UICollectionView!
    @IBOutlet weak var myFriendsCount: UILabel!
    
    

    let PhotoGalleryCollectionViewCellReuseIdentifier = "PhotoGalleryCollectionViewCellReuseIdentifier"
    let goToMyPhotoGallerySegueIdentifier = "goToMyPhotoGallery"

    let profile = ModelMyProfile()
    var myPhotoGallery = MyPhotoGallery()
    var countOfMyFriends = [Human]()

    override func viewDidLoad() {
        super.viewDidLoad()

        //получил доступ к чтению token и Id из singleton
        ModelMyProfile().settingsAccess()
        print("my token is - \(Session.sharedInstance.token), my Id is - \(Session.sharedInstance.Id)")

        myProfileCollectionView.register(UINib(nibName: "PhotoGalleryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: PhotoGalleryCollectionViewCellReuseIdentifier)

        myProfileCollectionView.dataSource = self
        myProfileCollectionView.delegate = self

        myProfileCollectionView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setupCountOfMyFriendsLabel()
        shadowForAvatar()
        configureProfile()
    }

    func setupCountOfMyFriendsLabel() {

        myFriendsCount.text = String(Storage.shared.friends.count)
        myFriendsCount.textColor = #colorLiteral(red: 0, green: 0.1032822803, blue: 1, alpha: 1)

    }

    
    func shadowForAvatar() {

        myProfilePhotoView.layer.cornerRadius = myAvatarImage.layer.cornerRadius
        myProfilePhotoView.layer.shadowColor = UIColor.gray.cgColor
        myProfilePhotoView.layer.shadowOffset = CGSize(width: 15, height: 15)
        myProfilePhotoView.layer.shadowRadius = 7
        myProfilePhotoView.layer.shadowOpacity = 0.6
    }

    func configureProfile() {

        myAvatarImage.image = UIImage(named: profile.myDataIs.avatar)
        myNameLabel.text = profile.myDataIs.name
        myCityLabel.text = profile.myDataIs.city
    }

}


extension MyProfileViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        myPhotoGallery.photoGallery.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoGalleryCollectionViewCellReuseIdentifier, for: indexPath) as? PhotoGalleryCollectionViewCell else { return UICollectionViewCell() }

        let photo = myPhotoGallery.photoGallery[indexPath.item]
        cell.configureGallery(photo: UIImage(named: photo))


        return cell
    }
}


extension MyProfileViewController: UICollectionViewDelegate {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        if segue.identifier == goToMyPhotoGallerySegueIdentifier,
           let vc = segue.destination as? MyPhotoGalleryViewController,
           let profileArrayIndex = sender as? Int {

            vc.galleryArrayIndex = profileArrayIndex
        }
    }


    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        performSegue(withIdentifier: goToMyPhotoGallerySegueIdentifier, sender: indexPath.item)
    }
}


extension MyProfileViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = collectionView.bounds.width
        let whiteSpaces: CGFloat = 3
        let cellWidth = width / 2 - whiteSpaces

        return CGSize(width: cellWidth, height: cellWidth)
    }
}
