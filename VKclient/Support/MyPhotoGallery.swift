//
//  MyPhotoGallery.swift
//  VKclient
//
//  Created by Александр Борисов on 07.06.2022.
//

import Foundation


struct MyPhotoGallery {

    var photoGallery = [String]()

    init() {
        setupPhotoGallery()
    }

    mutating func setupPhotoGallery() {

        let photo1 = "i-1"
        let photo2 = "i-2"
        let photo3 = "i-3"
        let photo4 = "i-4"
        let photo5 = "i-5"
        let photo6 = "i-6"
        let photo7 = "i-7"
        let photo8 = "i-8"

        photoGallery.append(photo1)
        photoGallery.append(photo2)
        photoGallery.append(photo3)
        photoGallery.append(photo4)
        photoGallery.append(photo5)
        photoGallery.append(photo6)
        photoGallery.append(photo7)
        photoGallery.append(photo8)

    }
}

