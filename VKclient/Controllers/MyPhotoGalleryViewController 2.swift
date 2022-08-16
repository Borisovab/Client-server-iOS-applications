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

    var fullScreenPhotoGallery = MyPhotoGallery()
    var indexPath: IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()


        myPhotoGalleryCollectionView.register(UINib(nibName: "SelectedPhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: SelectedPhotoCollectionViewCellReuseIdentifier)

        myPhotoGalleryCollectionView.dataSource = self
        myPhotoGalleryCollectionView.delegate = self

        myPhotoGalleryCollectionView.performBatchUpdates(nil) { (result) in
            self.myPhotoGalleryCollectionView.scrollToItem(at: self.indexPath, at: .centeredHorizontally, animated: false)
        }

    }
}

extension MyPhotoGalleryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        fullScreenPhotoGallery.photoGallery.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectedPhotoCollectionViewCellReuseIdentifier, for: indexPath) as? SelectedPhotoCollectionViewCell else { return UICollectionViewCell() }

        let photo = fullScreenPhotoGallery.photoGallery[indexPath.item]

        cell.configureSelectedGallery(photo: UIImage(named: photo), isLiked: false, likeCouter: 0, onLikeClosure: { (isLikePressed, currentCounter) in

            print("counter \(currentCounter)")
            print(isLikePressed ? "true" : "false")



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
