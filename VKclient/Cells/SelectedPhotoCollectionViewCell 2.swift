//
//  SelectedPhotoCollectionViewCell.swift
//  VKclient
//
//  Created by Александр Борисов on 06.06.2022.
//

import UIKit

class SelectedPhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var selectedPhoto: UIImageView!
    @IBOutlet weak var likeControlView: LikeControlView!

    var onLikeClosure: ((Bool, Int) -> Void)?
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        selectedPhoto.image = nil
        likeControlView.configure(isLiked: false, couter: 0)
        onLikeClosure = nil
    }

    func configureSelectedGallery(photo: UIImage?, isLiked: Bool, likeCouter: Int, onLikeClosure: @escaping (Bool, Int) -> Void) {
        selectedPhoto.image = photo
        likeControlView.configure(isLiked: isLiked, couter: likeCouter)
        likeControlView.delegate = self
        self.onLikeClosure = onLikeClosure

    }


    override func awakeFromNib() {
        super.awakeFromNib()

        // Initialization code
    }

}

extension SelectedPhotoCollectionViewCell: LikeControlProtocol {

    func pressLike(likeState: Bool, currentCounter: Int) {
//        print("counter \(currentCounter)")
//        print(likeState ? "true" : "false")
        self.onLikeClosure?(likeState, currentCounter)
    }


}
