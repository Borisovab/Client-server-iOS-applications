//
//  ModelMyProfile.swift
//  VKclient
//
//  Created by Александр Борисов on 18.06.2022.
//

import Foundation

struct ModelMyProfile {

    func settingsAccess() {
        let session = Session.sharedInstance
        session.token = "Иван Иванович г.Удачный"
        session.Id = 0

    }

    var myDataIs = MyProfile(avatar: "Профиль", name: "Иван Иванович", city: "г.Удачный", photoGallery: photosForMyGallery)
}


