//
//  ModelPeople.swift
//  VKclient
//
//  Created by Александр Борисов on 03.06.2022.
//

import Foundation

struct ModelPeople {

    var peopleArray = [Human]()

    init() {
        setupPeople()
    }

    mutating func setupPeople() {

        let person1 = Human(avatar: "man1", name: "Павел", city: "г.Москва", photoGallery: moscow, id: 0)
        let person2 = Human(avatar: "man2", name: "Сергей", city: "г.Санкт-Петербург", photoGallery: petersburg, id: 1)
        let person3 = Human(avatar: "man3", name: "Александр", city: "г.Ярославль", photoGallery: yaroslavl, id: 2)
        let person4 = Human(avatar: "man4", name: "Илья", city: "г.Тула", photoGallery: tula, id: 3)
        let person5 = Human(avatar: "man5", name: "Петр", city: "г.Сочи", photoGallery: sochi, id: 4)
        let person6 = Human(avatar: "man6", name: "Игорь", city: "г.Севастополь", photoGallery: sevastopol, id: 5)
        let person7 = Human(avatar: "man7", name: "Дмитрий", city: "г.Екатеринбург", photoGallery: yekaterinburg, id: 6)
        let person8 = Human(avatar: "woman1", name: "Амелия", city: "г.Казань", photoGallery: kazan, id: 7)
        let person9 = Human(avatar: "woman2", name: "Жанна", city: "г.Владивосток", photoGallery: vladivostok, id: 8)
        let person10 = Human(avatar: "woman3", name: "Амира", city: "г.Грозный", photoGallery: grozny, id: 9)
        let person11 = Human(avatar: "woman4", name: "Анастасия", city: "г.Новосибирск", photoGallery: novosibirsk, id: 10)
        let person12 = Human(avatar: "woman5", name: "Ксения", city: "г.Калининград", photoGallery: kaliningrad, id: 11)
        let person13 = Human(avatar: "woman6", name: "Аделина", city: "г.Улан-Удэ", photoGallery: ulanUde, id: 12)
        let person14 = Human(avatar: "woman7", name: "София", city: "г.Якутск", photoGallery: yakutsk, id: 13)

        peopleArray.append(person1)
        peopleArray.append(person2)
        peopleArray.append(person3)
        peopleArray.append(person4)
        peopleArray.append(person5)
        peopleArray.append(person6)
        peopleArray.append(person7)
        peopleArray.append(person8)
        peopleArray.append(person9)
        peopleArray.append(person10)
        peopleArray.append(person11)
        peopleArray.append(person12)
        peopleArray.append(person13)
        peopleArray.append(person14)
    }

}
