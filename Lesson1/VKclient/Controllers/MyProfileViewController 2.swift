//
//  MyProfileViewController.swift
//  VKclient
//
//  Created by Александр Борисов on 03.06.2022.
//

import UIKit

class MyProfileViewController: UIViewController {

    @IBOutlet weak var myAvatarImage: UIImageView!
    @IBOutlet weak var myNameLabel: UILabel!
    @IBOutlet weak var myCityLabel: UILabel!
    @IBOutlet weak var myProfilePhotoView: UIView!

    @IBOutlet weak var myProfileCollectionView: UICollectionView!

    let PhotoGalleryCollectionViewCellReuseIdentifier = "PhotoGalleryCollectionViewCellReuseIdentifier"

    override func viewDidLoad() {
        super.viewDidLoad()

        myProfilePhotoView.layer.cornerRadius = 75
        myProfilePhotoView.layer.shadowColor = UIColor.gray.cgColor
        myProfilePhotoView.layer.shadowOffset = CGSize(width: 15, height: 15)
        myProfilePhotoView.layer.shadowRadius = 7
        myProfilePhotoView.layer.shadowOpacity = 0.6

        myAvatarImage.image = UIImage(named: "Профиль")
        myNameLabel.text = "Иван Иванович"
        myNameLabel.textColor = #colorLiteral(red: 0.3538695574, green: 0, blue: 0.5538253784, alpha: 1)
        myCityLabel.text = "г.Удачный"
        myCityLabel.textColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)

        myProfileCollectionView.register(UINib(nibName: "PhotoGalleryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: PhotoGalleryCollectionViewCellReuseIdentifier)

        myProfileCollectionView.dataSource = self
        myProfileCollectionView.delegate = self

        myProfileCollectionView.reloadData()
    }

    var myPhotoGallery = MyPhotoGallery()
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

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        guard let vc = storyboard?.instantiateViewController(withIdentifier: "MyPhotoGalleryViewController") as? MyPhotoGalleryViewController else { return }
        vc.fullScreenPhotoGallery.photoGallery = myPhotoGallery.photoGallery
        vc.indexPath = indexPath
        self.navigationController?.pushViewController(vc, animated: true)
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
