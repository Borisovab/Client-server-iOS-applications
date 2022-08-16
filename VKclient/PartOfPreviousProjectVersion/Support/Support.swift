//
//  Support.swift
//  VKclient
//
//  Created by Александр Борисов on 03.06.2022.
//

import Foundation
import UIKit

// url для галереи моих друзей и групп
var moscow = [moscowPic1, moscowPic2, moscowPic3, moscowPic4, moscowPic5, moscowPic6]
var petersburg = [petersburgPic1, petersburgPic2, petersburgPic3, petersburgPic4, petersburgPic5, petersburgPic6]
var yaroslavl = [yaroslavlPic1, yaroslavlPic2, yaroslavlPic3, yaroslavlPic4, yaroslavlPic5, yaroslavlPic6]
var tula = [tulaPic1, tulaPic2]
var sochi = [sochiPic1, sochiPic2]
var sevastopol = [sevastopolPic1, sevastopolPic2]
var yekaterinburg = [yekaterinburgPic1, yekaterinburgPic2]
var kazan = [kazanPic1, kazanPic2]
var vladivostok = [vladivostokPic1, vladivostokPic2]
var grozny = [groznyPic1, groznyPic2]
var novosibirsk = [novosibirskPic1, novosibirskPic2]
var kaliningrad = [kaliningradPic1, kaliningradPic2]
var ulanUde = [ulanUdePic1, ulanUdePic2]
var yakutsk = [yakutskPic1, yakutskPic2]


let moscowPic1 = PhotosForFriendsGallery(url: "Москва1")
let moscowPic2 = PhotosForFriendsGallery(url: "Москва2")
let moscowPic3 = PhotosForFriendsGallery(url: "Москва3")
let moscowPic4 = PhotosForFriendsGallery(url: "Москва4")
let moscowPic5 = PhotosForFriendsGallery(url: "Москва5")
let moscowPic6 = PhotosForFriendsGallery(url: "Москва6")

let petersburgPic1 = PhotosForFriendsGallery(url: "Петербург1")
let petersburgPic2 = PhotosForFriendsGallery(url: "Петербург2")
let petersburgPic3 = PhotosForFriendsGallery(url: "Петербург3")
let petersburgPic4 = PhotosForFriendsGallery(url: "Петербург4")
let petersburgPic5 = PhotosForFriendsGallery(url: "Петербург5")
let petersburgPic6 = PhotosForFriendsGallery(url: "Петербург6")

let yaroslavlPic1 = PhotosForFriendsGallery(url: "Ярославль1")
let yaroslavlPic2 = PhotosForFriendsGallery(url: "Ярославль2")
let yaroslavlPic3 = PhotosForFriendsGallery(url: "Ярославль3")
let yaroslavlPic4 = PhotosForFriendsGallery(url: "Ярославль4")
let yaroslavlPic5 = PhotosForFriendsGallery(url: "Ярославль5")
let yaroslavlPic6 = PhotosForFriendsGallery(url: "Ярославль6")


let tulaPic1  = PhotosForFriendsGallery(url: "Тула1")
let tulaPic2  = PhotosForFriendsGallery(url: "Тула2")

let sochiPic1 = PhotosForFriendsGallery(url: "Сочи1")
let sochiPic2 = PhotosForFriendsGallery(url: "Сочи2")

let sevastopolPic1 = PhotosForFriendsGallery(url: "Севастополь1")
let sevastopolPic2 = PhotosForFriendsGallery(url: "Севастополь2")


let yekaterinburgPic1 = PhotosForFriendsGallery(url: "Екатеринбург1")
let yekaterinburgPic2 = PhotosForFriendsGallery(url: "Екатеринбург2")


let kazanPic1 = PhotosForFriendsGallery(url: "Казань1")
let kazanPic2 = PhotosForFriendsGallery(url: "Казань2")


let vladivostokPic1 = PhotosForFriendsGallery(url: "Владивосток1")
let vladivostokPic2 = PhotosForFriendsGallery(url: "Владивосток2")


let groznyPic1 = PhotosForFriendsGallery(url: "Грозный1")
let groznyPic2 = PhotosForFriendsGallery(url: "Грозный2")


let novosibirskPic1 = PhotosForFriendsGallery(url: "Новосибирск1")
let novosibirskPic2 = PhotosForFriendsGallery(url: "Новосибирск2")


let kaliningradPic1 = PhotosForFriendsGallery(url: "Калининград1")
let kaliningradPic2 = PhotosForFriendsGallery(url: "Калининград2")


let ulanUdePic1 = PhotosForFriendsGallery(url: "Улан-Удэ1")
let ulanUdePic2 = PhotosForFriendsGallery(url: "Улан-Удэ2")


let yakutskPic1 = PhotosForFriendsGallery(url: "Якутск1")
let yakutskPic2 = PhotosForFriendsGallery(url: "Якутск2")


// url для галереи моих групп

var moscowAlbum = [UIImage(named: "Москва1")!, UIImage(named: "Москва2")!, UIImage(named: "Москва3")!, UIImage(named: "Москва4")!, UIImage(named: "Москва5")!, UIImage(named: "Москва6")!]
var petersburgAlbum = [UIImage(named: "Петербург1")!, UIImage(named: "Петербург2")!, UIImage(named: "Петербург3")!, UIImage(named: "Петербург4")!, UIImage(named: "Петербург5")!, UIImage(named: "Петербург6")!]
var yaroslavlAlbum = [UIImage(named: "Ярославль1")!, UIImage(named: "Ярославль2")!, UIImage(named: "Ярославль3")!, UIImage(named: "Ярославль4")!, UIImage(named: "Ярославль5")!, UIImage(named: "Ярославль6")!]
var tulaAlbum = [UIImage(named: "Тула1")!, UIImage(named: "Тула2")!]
var sochiAlbum = [UIImage(named: "Сочи1")!, UIImage(named: "Сочи2")!]
var sevastopolAlbum = [UIImage(named: "Севастополь1")!, UIImage(named: "Севастополь2")!]
var yekaterinburgAlbum = [UIImage(named: "Екатеринбург1")!, UIImage(named: "Екатеринбург2")!]
var kazanAlbum = [UIImage(named: "Казань1")!, UIImage(named: "Казань2")!]
var vladivostokAlbum = [UIImage(named: "Владивосток1")!, UIImage(named: "Владивосток2")!]
var groznyAlbum = [UIImage(named: "Грозный1")!, UIImage(named: "Грозный2")!]
var novosibirskAlbum = [UIImage(named: "Новосибирск1")!, UIImage(named: "Новосибирск2")!]
var kaliningradAlbum = [UIImage(named: "Калининград1")!, UIImage(named: "Калининград2")!]
var ulanUdeAlbum = [UIImage(named: "Улан-Удэ1")!, UIImage(named: "Улан-Удэ2")!]
var yakutskAlbum = [UIImage(named: "Якутск1")!, UIImage(named: "Якутск2")!]


// url для галереи моего прогфиля
var photosForMyGallery = [myPhoto1, myPhoto2, myPhoto3, myPhoto4, myPhoto5, myPhoto6, myPhoto7, myPhoto8]


let myPhoto1 = ForMyGallery(url: "i-1")
let myPhoto2 = ForMyGallery(url: "i-2")
let myPhoto3 = ForMyGallery(url: "i-3")
let myPhoto4 = ForMyGallery(url: "i-4")
let myPhoto5 = ForMyGallery(url: "i-5")
let myPhoto6 = ForMyGallery(url: "i-6")
let myPhoto7 = ForMyGallery(url: "i-7")
let myPhoto8 = ForMyGallery(url: "i-8")


