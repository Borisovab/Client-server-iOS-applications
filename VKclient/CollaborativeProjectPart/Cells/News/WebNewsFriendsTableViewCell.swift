//
//  SecondWebNewsTableViewCell.swift
//  VKclient
//
//  Created by Александр Борисов on 12.08.2022.
//

import UIKit

class WebNewsFriendsTableViewCell: UITableViewCell {

    @IBOutlet weak var friendsInNewsVCCollectionView: UICollectionView!
    
    let registernibName = "PhotoGalleryCollectionViewCell"
    let photoGalleryCollectionViewCellReuseIdentifier = "PhotoGalleryCollectionViewCellReuseIdentifier"

    let networkService = WebDataRequest()
    var friendsResponse: JSONInfo<ResponseFriends>? = nil


    func configureFriendsInNews() {

        friendsInNewsVCCollectionView.dataSource = self
        friendsInNewsVCCollectionView.delegate = self
        friendsInNewsVCCollectionView.register(UINib(nibName: registernibName, bundle: nil), forCellWithReuseIdentifier: photoGalleryCollectionViewCellReuseIdentifier)

        getRequest()

    }


    func getRequest() {
        networkService.request() { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let friendsInfo):
                friendsInfo.response.items.map { (name) in

                    self.friendsResponse = friendsInfo
                    self.friendsInNewsVCCollectionView.reloadData()
                }
            case .failure(let error):
                print("error: - ", error)
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}



extension WebNewsFriendsTableViewCell: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return friendsResponse?.response.items.map { $0.firstName }.count ?? 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photoGalleryCollectionViewCellReuseIdentifier, for: indexPath) as? PhotoGalleryCollectionViewCell else { return UICollectionViewCell() }

        cell.layer.cornerRadius = 35
        cell.layer.borderWidth = 2
        cell.layer.borderColor = #colorLiteral(red: 0.874512732, green: 0.9583994746, blue: 0.9569959044, alpha: 1)


        return cell
    }



}

extension WebNewsFriendsTableViewCell: UICollectionViewDelegate {


}

extension WebNewsFriendsTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let height = collectionView.bounds.height
        let whiteSpaces: CGFloat = 0
        let cellWidth = height / 1 - whiteSpaces

        return CGSize(width: cellWidth, height: cellWidth)
    }
}
