//
//  MyProfile.swift
//  VKclient
//
//  Created by Александр Борисов on 18.06.2022.
//

import Foundation

struct AdministrationAccess {
    var token = ""
    var Id = 0
}

struct ForMyGallery {
    var url: String
    var isLiked = false
    var likeCounter = 0
}

struct MyProfile {

    var avatar: String
    var name: String
    var city: String
    var photoGallery = [ForMyGallery]()

    var administrationAccess = AdministrationAccess()

}
