//
//  SomeWebMethods.swift
//  VKclient
//
//  Created by Александр Борисов on 11.08.2022.
//

import Foundation


class SomeMethods {

    //MARK: - friends.get

    func sendFriendsGetRequest() {
        var components = URLComponents(string: "https://api.vk.com/method/friends.get")
        components?.queryItems = [
            URLQueryItem(name: "access_token", value: Session.sharedInstance.token),
            URLQueryItem(name: "fields", value: "nickname"),
            URLQueryItem(name: "fields", value: "photo_200_orig"),
            URLQueryItem(name: "v", value: "5.131")
        ]

        guard let url = components?.url else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            print("response --> \(response)")
            guard let data = data else { return }

            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(JSONInfo<ResponseFriends>.self, from: data)
                let idOfMyFriends = model.response.items.map { $0.id }
                let myFriends = model
                print(myFriends)
            } catch {
                print(error)
            }

            //            print("Body friends.get --> \(String(data: data, encoding: .utf8))")

        }.resume()
    }

    //MARK: - groups.get
    func sendGroupsGetRequest() {
        var components = URLComponents(string: "https://api.vk.com/method/groups.get")
        components?.queryItems = [
            URLQueryItem(name: "access_token", value: Session.sharedInstance.token),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "fields", value: "description"),
            URLQueryItem(name: "fields", value: "main_album_id"),
            URLQueryItem(name: "v", value: "5.131")
        ]

        guard let url = components?.url else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            print("response --> \(response)")
            guard let data = data else { return }

            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(JSONInfo<ResponseGroups>.self, from: data)
                let myGroupName = model.response.items.map { $0.name }
                print(myGroupName)
            } catch {
                print(error)
            }
            //            print("Body groups.get --> \(String(data: data, encoding: .utf8))")

        }.resume()
    }

    //MARK: - photos.getAll
    func sendPhotoGetAllRequest() {

        var components = URLComponents(string: "https://api.vk.com/method/photos.getAll")
        components?.queryItems = [
            URLQueryItem(name: "access_token", value: Session.sharedInstance.token),
            URLQueryItem(name: "owner_id", value: "183432082"),
            URLQueryItem(name: "no_service_albums", value: "1"),
            URLQueryItem(name: "v", value: "5.131")
        ]

        guard let url = components?.url else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            print("response --> \(response)")
            guard let data = data else { return }

            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(JSONInfo<ResponsePhotos>.self, from: data)
                let myfriendsPhoto = model.response.items.map { $0.sizes.map { $0.url} }
                print(myfriendsPhoto)
            } catch {
                print(error)
            }
                        print("Body photos.getAll --> \(String(data: data, encoding: .utf8))")

        }.resume()
    }







    //MARK: - groups.search
    func sendGroupsSearchGetRequest(Str: String) {
        var components = URLComponents(string: "https://api.vk.com/method/groups.search")
        components?.queryItems = [
            URLQueryItem(name: "access_token", value: Session.sharedInstance.token),
            URLQueryItem(name: "q", value: "\(Str)"),
            URLQueryItem(name: "v", value: "5.131")
        ]

        guard let url = components?.url else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            print("response --> \(response)")
            guard let data = data else { return }

            print("Body groups.search --> \(String(data: data, encoding: .utf8))")

        }.resume()
    }

}





