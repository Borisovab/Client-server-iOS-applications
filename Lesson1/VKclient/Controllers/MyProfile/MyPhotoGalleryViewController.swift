//
//  MyPhotoGalleryViewController.swift
//  VKclient
//
//  Created by Александр Борисов on 07.06.2022.
//

import UIKit

class MyPhotoGalleryViewController: UIViewController {

    @IBOutlet weak var myPhotoGalleryCollectionView: UICollectionView!

    let SelectedPhotoCollectionViewCellReuseIdentifier = "SelectedPhotoCollectionViewCellReuseIdentifier"

    var fullScreenPhotoGallery = [ForMyGallery]()

    var galleryArrayIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        myPhotoGalleryCollectionView.register(UINib(nibName: "SelectedPhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: SelectedPhotoCollectionViewCellReuseIdentifier)

        myPhotoGalleryCollectionView.dataSource = self
        myPhotoGalleryCollectionView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        fullScreenPhotoGallery = Storage.shared.myData.myDataIs.photoGallery

        myPhotoGalleryCollectionView.reloadData()
    }
}

extension MyPhotoGalleryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        fullScreenPhotoGallery.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectedPhotoCollectionViewCellReuseIdentifier, for: indexPath) as? SelectedPhotoCollectionViewCell else { return UICollectionViewCell() }


        let indexCellConfigure = Storage.shared.myData.myDataIs.photoGallery[indexPath.item]

        let photo = UIImage(named: indexCellConfigure.url)

        cell.configureSelectedGallery(photo: photo, isLiked: indexCellConfigure.isLiked, likeCouter: indexCellConfigure.likeCounter, onLikeClosure: { (isLikePressed, currentCounter) in

            print("counter \(currentCounter)")
            print(isLikePressed ? "true" : "false")

            Storage.shared.myData.myDataIs.photoGallery[indexPath.item].isLiked = isLikePressed
            Storage.shared.myData.myDataIs.photoGallery[indexPath.item].likeCounter = currentCounter
        })
        
        return cell
    }
}


extension MyPhotoGalleryViewController: UICollectionViewDelegate {

}


extension MyPhotoGalleryViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = collectionView.bounds.width
        let whiteSpaces: CGFloat = 0
        let cellWidth = width / 1 - whiteSpaces

        return CGSize(width: cellWidth, height: cellWidth)
    }
}
