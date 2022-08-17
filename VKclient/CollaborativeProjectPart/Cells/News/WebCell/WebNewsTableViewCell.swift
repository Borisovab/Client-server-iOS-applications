//
//  WebNewsTableViewCell.swift
//  VKclient
//
//  Created by Александр Борисов on 12.08.2022.
//

import UIKit

class WebNewsTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImage: UIImageView!{
        didSet {
            avatarImage.layer.cornerRadius = 25
        }
    }
    @IBOutlet weak var nameLable: UILabel!{
        didSet {
            nameLable.textColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
        }
    }

    @IBOutlet weak var photoAlbumCollectionView: UICollectionView!

    let nameNibRegister = "PhotoGalleryCollectionViewCell"
    let PhotoGalleryCollectionViewCellReuseIdentifier = "PhotoGalleryCollectionViewCellReuseIdentifier"


    let networkService = WebDataRequest()
    var photoResponse: JSONInfo<ResponseJsonPhotos>? = nil

    var idForMethod = 0

    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImage.image = nil
        nameLable.text = nil
        photoAlbumCollectionView.reloadData()
    }

    func configureNews() {

        NotificationCenter.default.addObserver(self, selector: #selector(indexForCell(_:)), name: Notification.Name("idGroupFromWebGroupNewsViewControllerToWebNewsTableViewCell"), object: nil)

        photoAlbumCollectionView.dataSource = self
        photoAlbumCollectionView.delegate = self
        photoAlbumCollectionView.register(UINib(nibName: nameNibRegister, bundle: nil), forCellWithReuseIdentifier: PhotoGalleryCollectionViewCellReuseIdentifier)

        getPhotoRequest()
    }

    @objc func indexForCell(_ notification: Notification) {
        guard let idForCell = notification.object as? Int else { return }
        idForMethod = idForCell
    }

    func configureName(name: String?) {
        nameLable.text = name
    }

    func getPhotoRequest() {
        networkService.requestGetPhotoByIDGroup(id: String(idForMethod)) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let photoInfo):
                photoInfo.response.items.map { (name) in

                    self.photoResponse = photoInfo
                    self.photoAlbumCollectionView.reloadData()
                }
            case .failure(let error):
                print("error: - ", error)
            }
        }
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


extension WebNewsTableViewCell: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
//        return photoResponse?.response.items.map {$0.ownerId}.count ?? 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoGalleryCollectionViewCellReuseIdentifier, for: indexPath) as? PhotoGalleryCollectionViewCell else { return UICollectionViewCell() }

        let strUrlLast = photoResponse?.response.items.map {$0.sizes.last?.url}[indexPath.item] ?? ""

        let url = URL(string: strUrlLast)

        cell.photoImage.showImage(with: url)


        return cell
    }
}


extension WebNewsTableViewCell: UICollectionViewDelegate {

}

extension WebNewsTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = collectionView.bounds.width
        let whiteSpaces: CGFloat = 2
        let cellWidth = width / 3 - whiteSpaces

        return CGSize(width: cellWidth, height: cellWidth)
    }
}

