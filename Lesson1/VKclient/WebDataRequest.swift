//
//  WebFriends.swift
//  VKclient
//
//  Created by Александр Борисов on 11.07.2022.
//

import Foundation

class WebDataRequest {

    var friendsIDArray = [ "29621","67232","240213","349444","642747","952784","1054162","1318104","1520292","1758531","1825387","1919192","2182596","2193066","2266245","2321337","2411770","2451385","2532593","2570211","2790483","2923519","2958229","3245903","3705536","3931747","4251328","4310139","4360300","5142331","5386513","5476282","5693820","6505268","7371126","7840093","7912748","8278917","8326864","8350974","9170310","9625778","11246492","11605729","12472007","13214971","16501119","23308100","24776480","25834284","27768026","29747330","29946985","31811505","37639541","38423864","39549933","51036527","51454389","54900469","80625955","83196978","91021971","94072628","95755787","97097149","111074306","111939140","115589293","133882239","144154933","144547189","153449483","183432082","194440622","218828803","221364231","248252103","298387008","303489220","327454716","366351969","382175024","386304288","426922678","479997368","601053761"
    ]

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

            print("Body friends.get --> \(String(data: data, encoding: .utf8))")

        }.resume()
    }

    //MARK: - groups.get
    func sendGroupsGetRequest() {
        var components = URLComponents(string: "https://api.vk.com/method/groups.get")
        components?.queryItems = [
            URLQueryItem(name: "access_token", value: Session.sharedInstance.token),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "fields", value: "description"),
            URLQueryItem(name: "v", value: "5.131")
        ]

        guard let url = components?.url else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            print("response --> \(response)")
            guard let data = data else { return }

            print("Body groups.get --> \(String(data: data, encoding: .utf8))")

        }.resume()
    }

    //MARK: - photos.getAll
    func sendFriedsPhotoGetRequest() {

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
