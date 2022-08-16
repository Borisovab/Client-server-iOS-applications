//
//  NewsTableViewCell.swift
//  VKclient
//
//  Created by Александр Борисов on 29.06.2022.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var friendsCollectionView: UICollectionView!
    
    let registernibName = "PhotoGalleryCollectionViewCell"
    let PhotoGalleryCollectionViewCellReuseIdentifier = "PhotoGalleryCollectionViewCellReuseIdentifier"

    var modellPeople = [Human]()


    override func prepareForReuse() {
        super.prepareForReuse()
        friendsCollectionView.reloadData()
    }

    func configureNews() {

        friendsCollectionView.dataSource = self
        friendsCollectionView.delegate = self
        friendsCollectionView.register(UINib(nibName: registernibName, bundle: nil), forCellWithReuseIdentifier: PhotoGalleryCollectionViewCellReuseIdentifier)

        modellPeople = Storage.shared.friends
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


extension NewsTableViewCell: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modellPeople.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoGalleryCollectionViewCellReuseIdentifier, for: indexPath) as? PhotoGalleryCollectionViewCell else { return UICollectionViewCell() }

        let photo = modellPeople[indexPath.item].avatar

        cell.configureGallery(photo: UIImage(named: photo))

        cell.layer.cornerRadius = 35
        cell.layer.borderWidth = 2
        cell.layer.borderColor = #colorLiteral(red: 0.874512732, green: 0.9583994746, blue: 0.9569959044, alpha: 1)


        return cell
    }



}

extension NewsTableViewCell: UICollectionViewDelegate {


}

extension NewsTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let height = collectionView.bounds.height
        let whiteSpaces: CGFloat = 0
        let cellWidth = height / 1 - whiteSpaces

        return CGSize(width: cellWidth, height: cellWidth)
    }
}
