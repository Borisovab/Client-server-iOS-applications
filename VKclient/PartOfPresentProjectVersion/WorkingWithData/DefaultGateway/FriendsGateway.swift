//
//  DefaultGateway.swift
//  VKclient
//
//  Created by Александр Борисов on 26.08.2022.
//

import Foundation
import RealmSwift

class FriendsGateway {
    init(
        network: NetworkController,
        dataBase: RealmStorage
    ) {
        self.network = network
        self.dataBase = dataBase
    }

    let network: NetworkerProtocol
    let dataBase: DataStorageProtocol

    func loadPosts(completion: @escaping([FriendsPostViewModel]) -> Void) {
        var components = URLComponents(string: "https://api.vk.com/method/friends.get")
        components?.queryItems = [
            URLQueryItem(name: "access_token", value: Session.sharedInstance.token),
            URLQueryItem(name: "fields", value: "nickname"),
            URLQueryItem(name: "fields", value: "photo_100"),
            URLQueryItem(name: "v", value: "5.131")
        ]

        guard
            let url = components?.url
        else {
            completion([])
            return
        }

        let request = URLRequest(url: url)
        network.load(request: request) { [weak self] (model: JSONInfo<ResponseFriends>?) in

            if let model = model {
                DispatchQueue.main.async {
                    model.response.items
                        .map { netPost in
                            let post = RealmFriendsArrayParam()
                            post.fillData(with: netPost)
                            return post
                        }
                        .forEach { self?.dataBase.save(model: $0) }

                    let viewData = model.response.items
                        .map { FriendsPostViewModel(from: $0) }

                    completion(viewData)
                }
            } else {
                DispatchQueue.main.async {
                    let values: [RealmFriendsArrayParam]? = self?.dataBase.restore()
                    let viewData = (values ?? [])
                        .map { FriendsPostViewModel(from: $0) }

                    completion(viewData)
                }
            }
        }
    }
}
