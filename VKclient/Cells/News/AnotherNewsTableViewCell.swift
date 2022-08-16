//
//  AnotherNewsTableViewCell.swift
//  VKclient
//
//  Created by Александр Борисов on 29.06.2022.
//

import UIKit

class AnotherNewsTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImage: UIImageView! {
        didSet {
            avatarImage.layer.cornerRadius = 25
        }
    }

    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.textColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
        }
    }

    @IBOutlet weak var groupPhotoAlbum: UICollectionView!

    let registernibName = "PhotoGalleryCollectionViewCell"
    let PhotoGalleryCollectionViewCellReuseIdentifier = "PhotoGalleryCollectionViewCellReuseIdentifier"

    var albumForNews = [UIImage]()
    var groups = [Group]()

    var indexArray = 0

    override func prepareForReuse() {
        super.prepareForReuse()

        avatarImage.image = nil
        nameLabel.text = nil
   
        groupPhotoAlbum.reloadData()
    }
    

    func configure(avatar: UIImage?, name: String?, album: [UIImage]) {

        albumForNews = Storage.shared.groups.communities[indexArray].album

        // from NewsViewController
        NotificationCenter.default.addObserver(self, selector: #selector(indexForCell(_:)), name: Notification.Name("indexForAnotherNewsTVCell"), object: nil)

        avatarImage.image = avatar
        nameLabel.text = name
        albumForNews = album

        groupPhotoAlbum.dataSource = self
        groupPhotoAlbum.delegate = self


        groupPhotoAlbum.register(UINib(nibName: registernibName, bundle: nil), forCellWithReuseIdentifier: PhotoGalleryCollectionViewCellReuseIdentifier)

    }

    @objc func indexForCell(_ notification: Notification) {
        guard let indexForCell = notification.object as? Int else { return }
        indexArray = indexForCell
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


extension AnotherNewsTableViewCell: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albumForNews.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoGalleryCollectionViewCellReuseIdentifier, for: indexPath) as? PhotoGalleryCollectionViewCell else { return UICollectionViewCell() }

        let photo = albumForNews[indexPath.item]
        cell.configureGallery(photo: photo)

        return cell
    }
}


extension AnotherNewsTableViewCell: UICollectionViewDelegate {

}

extension AnotherNewsTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let height = collectionView.bounds.height
        let whiteSpaces: CGFloat = 2
        let cellWidth = height / 1 - whiteSpaces

        return CGSize(width: cellWidth, height: cellWidth)
    }
}
