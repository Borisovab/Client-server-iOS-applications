//
//  GroupProfileViewController.swift
//  VKclient
//
//  Created by Александр Борисов on 20.06.2022.
//

import UIKit

class GroupProfileViewController: UIViewController {

    @IBOutlet weak var groupAvatarImage: UIImageView!
    @IBOutlet weak var groupNameLabel: UILabel!
    
    @IBOutlet weak var groupPhotoGalleryCollectionView: UICollectionView!

    let PhotoGalleryCollectionViewCellReuseIdentifier = "PhotoGalleryCollectionViewCellReuseIdentifier"

    let goToGroupGallerySegueIdentifier = "goToGroupGallery"


    var group = ModelGroup()
    var myGroupsArray = [Group]()

    var groupPhotoGallery = [PhotosForFriendsGallery]()
    var photoArrayIndex = 0


    override func viewDidLoad() {
        super.viewDidLoad()

        groupPhotoGalleryCollectionView.register(UINib(nibName: "PhotoGalleryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: PhotoGalleryCollectionViewCellReuseIdentifier)

        groupPhotoGalleryCollectionView.dataSource = self
        groupPhotoGalleryCollectionView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        groupPhotoGallery = Storage.shared.peopleForSelect.peopleArray[photoArrayIndex].photoGallery

        groupAvatarImage.image = UIImage(named: group.communities[photoArrayIndex].avatar)
        groupNameLabel.text = group.communities[photoArrayIndex].name
        groupNameLabel.textColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)

    }
}

extension GroupProfileViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groupPhotoGallery.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoGalleryCollectionViewCellReuseIdentifier, for: indexPath) as? PhotoGalleryCollectionViewCell else { return UICollectionViewCell() }

        let photo = groupPhotoGallery[indexPath.item].url
        cell.configureGallery(photo: UIImage(named: photo))

        return cell
    }

    
}

extension GroupProfileViewController: UICollectionViewDelegate {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        if segue.identifier == goToGroupGallerySegueIdentifier,
           let vc = segue.destination as? GroupGalleryViewController,
//           let indexPath = sender as? IndexPath,
           let arrayIndex = sender as? Int{

            vc.photoArrayIndex = arrayIndex
//            vc.indexPath = indexPath
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let photo = group.communities[indexPath.item]
        performSegue(withIdentifier: goToGroupGallerySegueIdentifier, sender: photoArrayIndex)



//        let fullScreenView = UIView(frame: self.view.bounds)
//        fullScreenView.backgroundColor = #colorLiteral(red: 0.9205206037, green: 1, blue: 0.9940114617, alpha: 1)
//
//        let fullScreenImageView = UIImageView(frame: CGRect(x: 0, y: self.view.bounds.height/2 - self.view.bounds.width/2, width: self.view.bounds.width, height: self.view.bounds.width))
//
//        fullScreenView.addSubview(fullScreenImageView)
//
//        let photo = groupPhotoGallery[indexPath.item].url
//        fullScreenImageView.image = UIImage(named: photo)
//        self.view.addSubview(fullScreenView)
//
//
////        добавим gesture recognaizer, чтобы по клику убирать полный экран
//        let tap = UITapGestureRecognizer(target: self, action: #selector(hideFullScreen(_:)))
//        fullScreenView.addGestureRecognizer(tap)
//
//    }
//
//    @objc func hideFullScreen(_ recognizer: UITapGestureRecognizer) {
//        guard let targetView = recognizer.view else { return }
//        targetView.removeFromSuperview()
    }

}


extension GroupProfileViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = collectionView.bounds.width
        let whiteSpaces: CGFloat = 2
        let cellWidth = width / 2 - whiteSpaces

        return CGSize(width: cellWidth, height: cellWidth)
    }
}
