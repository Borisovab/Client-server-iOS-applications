//
//  ModelGroup.swift
//  VKclient
//
//  Created by Александр Борисов on 20.06.2022.
//

import Foundation

struct ModelGroup {

    var communities = [Group]()

    init() {
        setupCommunity()
    }

    mutating func setupCommunity() {

        let group1 = Group(avatar: "Community1", name: "Железо", description: "Спорт", photoGallery: moscow, id: 0, album: moscowAlbum)
        let group2 = Group(avatar: "Community2", name: "Боевые искуства", description: "Спорт", photoGallery: petersburg, id: 1, album: petersburgAlbum)
        let group3 = Group(avatar: "Community3", name: "Занимательная наука", description: "Наука", photoGallery: yaroslavl, id: 2, album: yaroslavlAlbum)
        let group4 = Group(avatar: "Community4", name: "Познаем мир", description: "Наука", photoGallery: tula, id: 3, album: tulaAlbum)
        let group5 = Group(avatar: "Community5", name: "Swift", description: "IT", photoGallery: sochi, id: 4, album: sochiAlbum)
        let group6 = Group(avatar: "Community6", name: "Swiftbook", description: "IT", photoGallery: sevastopol, id: 5, album: sevastopolAlbum)
        let group7 = Group(avatar: "Community7", name: "Наука и факты", description: "Наука", photoGallery: yekaterinburg, id: 6, album: yekaterinburgAlbum)
        let group8 = Group(avatar: "Community8", name: "САМБО", description: "Спорт", photoGallery: kazan, id: 7, album: kazanAlbum)
        let group9 = Group(avatar: "Community9", name: "Sputnik", description: "Новости", photoGallery: vladivostok, id: 8, album: vladivostokAlbum)
        let group10 = Group(avatar: "Community10", name: "СоловьевLIVE", description: "Новости", photoGallery: grozny, id: 9, album: groznyAlbum)

        communities.append(group1)
        communities.append(group2)
        communities.append(group3)
        communities.append(group4)
        communities.append(group5)
        communities.append(group6)
        communities.append(group7)
        communities.append(group8)
        communities.append(group9)
        communities.append(group10)

    }




}
