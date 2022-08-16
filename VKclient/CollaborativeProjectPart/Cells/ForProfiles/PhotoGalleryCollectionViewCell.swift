//
//  PhotoGalleryCollectionViewCell.swift
//  VKclient
//
//  Created by Александр Борисов on 03.06.2022.
//

import UIKit

class PhotoGalleryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var photoImage: UIImageView!


    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImage.image = nil
    }

    func configureGallery(photo: UIImage?) {
        photoImage.image = photo
    }



    override func awakeFromNib() {
        super.awakeFromNib()

    }



}
