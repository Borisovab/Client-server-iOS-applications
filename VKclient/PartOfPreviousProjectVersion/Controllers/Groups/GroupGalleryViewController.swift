//
//  GroupGalleryViewController.swift
//  VKclient
//
//  Created by Александр Борисов on 24.06.2022.
//

import UIKit

class GroupGalleryViewController: UIViewController {

    @IBOutlet weak var galleryView: GalleryHorisontalView!
    

    var groupGallery = [UIImage]()
    var photoArrayIndex = 0
    var indexPath: IndexPath!


    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        groupGallery = Storage.shared.groups.communities[photoArrayIndex].album
     
//        let image = [UIImage(named: groupGallery[photoArrayIndex].url)!]
//        galleryView.setImages(images: image)


        galleryView.setImages(images: groupGallery)


    }


}
