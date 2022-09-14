//
//  WebFriends.swift
//  VKclient
//
//  Created by Александр Борисов on 11.07.2022.
//

import Foundation
import RealmSwift
import SwiftUI

class WebDataRequest {

    //MARK: - method for get user's parameters

    func requestUser(completion: @escaping (Result<UserArray, Error>) -> Void) {

        var components = URLComponents(string: "https://api.vk.com/method/users.get")
        components?.queryItems = [
            URLQueryItem(name: "access_token", value: Session.sharedInstance.token),
            URLQueryItem(name: "v", value: "5.131")
        ]

        guard let url = components?.url else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("some error")

                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }

                do {
                    let decoder = JSONDecoder()
                    let model = try decoder.decode(UserArray.self, from: data)
                    completion(.success(model))

                    let realmPosts: [DataAboutUser] = model.response.map { post in
                        let realmPost = DataAboutUser()
                        realmPost.id = post.id
                        realmPost.firstName = post.firstName
                        realmPost.lastName = post.lastName

                        return realmPost
                    }
                    self.saveForUsers(posts: realmPosts)

                } catch {
                    print(error)
                    completion(.failure(error))
                }
            }
        }.resume()
    }

    private func saveForUsers(posts: [DataAboutUser]) {
        do {
            let realm = try Realm()
            try realm.write {
                posts.forEach { realm.add($0, update: .all) }
            }
        } catch {
            print(error)
        }
    }


    //MARK: - method for get friend's parameters

    func request(completion: @escaping (Result<JSONInfo<ResponseFriends>, Error>) -> Void) {

        var components = URLComponents(string: "https://api.vk.com/method/friends.get")
        components?.queryItems = [
            URLQueryItem(name: "access_token", value: Session.sharedInstance.token),
            URLQueryItem(name: "fields", value: "nickname"),
            URLQueryItem(name: "fields", value: "photo_100"),
            URLQueryItem(name: "v", value: "5.131")
        ]

        guard let url = components?.url else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("some error")

                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }

                do {
                    let decoder = JSONDecoder()
                    let model = try decoder.decode(JSONInfo<ResponseFriends>.self, from: data)
                    completion(.success(model))

                    let realmPosts: [RealmFriendsArrayParam] = model.response.items.map { post in
                        let realmPost = RealmFriendsArrayParam()
                        realmPost.id = post.id
                        realmPost.avatar = post.avatar
                        realmPost.trackCode = post.trackCode
                        realmPost.firstName = post.firstName
                        realmPost.lastName = post.lastName
                        realmPost.canAccessClosed = post.canAccessClosed
                        realmPost.isClosed = post.isClosed

                        return realmPost
                    }
                    self.saveForFriends(posts: realmPosts)

                } catch {
                    print(error)
                    completion(.failure(error))
                }
            }
        }.resume()
    }

    private func saveForFriends(posts: [RealmFriendsArrayParam]) {
        do {
            let realm = try Realm()
            try realm.write {
                posts.forEach { realm.add($0, update: .all) }
            }
        } catch {
            print(error)
        }
    }



    //MARK: - method for get groups parameters

    func requestForGroups(completion: @escaping (Result<JSONInfo<ResponseGroups>, Error>) -> Void) {

        var components = URLComponents(string: "https://api.vk.com/method/groups.get")
        components?.queryItems = [
            URLQueryItem(name: "access_token", value: Session.sharedInstance.token),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "fields", value: "description"),
            URLQueryItem(name: "v", value: "5.131")
        ]

        guard let url = components?.url else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("some error")

                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }

                do {
                    let decoder = JSONDecoder()
                    let model = try decoder.decode(JSONInfo<ResponseGroups>.self, from: data)
                    completion(.success(model))

                    let realmPosts: [RealmGroupsArrayParam] = model.response.items.map { post in
                        let realmPost = RealmGroupsArrayParam()
                        realmPost.id = post.id
                        realmPost.descriptionGroup = post.descriptionGroup
                        realmPost.name = post.name
                        realmPost.photo100 = post.photo100

                        return realmPost
                    }
                    self.saveForGroups(posts: realmPosts)
                } catch {
                    print(error)
                    completion(.failure(error))
                }
            }
        }.resume()
    }

    private func saveForGroups(posts: [RealmGroupsArrayParam]) {
        do {
            let realm = try Realm()
            try realm.write {
                posts.forEach { realm.add($0, update: .all) }
            }
        } catch {
            print(error)
        }
    }

    func restoreGroups() throws -> [GroupModel] {
        let realm = try Realm()

        let objects = realm.objects(RealmGroupsArrayParam.self)
        let posts = Array(
            objects.map {
                GroupModel(
                    id: $0.id,
                    name: $0.name,
                    photo100: $0.photo100
                )
            }
        )
        return posts
    }

    //MARK: - method for get photo parameters (в проекте сейчас используется этот метод в TestCollectionViewController)

    func requestGetPhoto(completion: @escaping (Result<JSONInfo<ResponseJsonPhotos>, Error>) -> Void) {

        var components = URLComponents(string: "https://api.vk.com/method/photos.get")
        components?.queryItems = [
            URLQueryItem(name: "access_token", value: Session.sharedInstance.token),
            URLQueryItem(name: "owner_id", value: "-92848243"),
            URLQueryItem(name: "album_id", value: "wall"),
            URLQueryItem(name: "v", value: "5.131")
        ]
        guard let url = components?.url else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("some error")
                    completion(.failure(error))

                    return
                }
                guard let data = data else { return }

                do {
                    let decoder = JSONDecoder()
                    let model = try decoder.decode(JSONInfo<ResponseJsonPhotos>.self, from: data)
                    completion(.success(model))

                    let realmPosts: [RealmPhotosArray] = model.response.items.map { post in
                        let realmPost = RealmPhotosArray()
                        realmPost.albumId = post.albumId
                        realmPost.ownerId = post.ownerId

                        let realmSizes: [DataSizePhoto] = post.sizes.map { size in
                            let realmSize = DataSizePhoto()
                            realmSize.url = size.url
                            return realmSize
                        }

                        realmPost.sizes.append(objectsIn: realmSizes)
                        return realmPost
                    }
                    self.savePhotos(posts: realmPosts)
                } catch {
                    print(error)
                    completion(.failure(error))
                }
            }
        }.resume()
    }

    private func savePhotos(posts: [RealmPhotosArray]) {
        do {
            let realm = try Realm()
            try realm.write {
                posts.forEach { realm.add($0, update: .all)}
            }
        } catch {
            print(error)
        }
    }



    //MARK: - method for get photo parameters to News VC (в проекте, сейчас используется этот метод в ячейке WebNewsTableViewCell)

    func requestGetPhotoByIDGroup(id: String, completion: @escaping (Result<JSONInfo<ResponseJsonPhotos>, Error>) -> Void) {

        var components = URLComponents(string: "https://api.vk.com/method/photos.get")
        components?.queryItems = [
            URLQueryItem(name: "access_token", value: Session.sharedInstance.token),
            URLQueryItem(name: "owner_id", value: "-" + id),
            URLQueryItem(name: "album_id", value: "wall"),
            URLQueryItem(name: "v", value: "5.131")
        ]
        guard let url = components?.url else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("some error")
                    completion(.failure(error))

                    return
                }
                guard let data = data else { return }

                do {
                    let decoder = JSONDecoder()
                    let model = try decoder.decode(JSONInfo<ResponseJsonPhotos>.self, from: data)
                    completion(.success(model))

                } catch {
                    print(error)
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}





