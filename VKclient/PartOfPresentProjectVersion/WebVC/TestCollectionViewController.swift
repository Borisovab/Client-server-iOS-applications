//
//  TestCollectionViewController.swift
//  VKclient
//
//  Created by Александр Борисов on 11.08.2022.
//

import UIKit

class TestCollectionViewController: UIViewController {

    @IBOutlet weak var testCollectionView: UICollectionView!

    let nameNibIdentifier = "PhotoGalleryCollectionViewCell"
    let photoGalleryCollectionViewCellReuseIdentifier = "photoGalleryCollectionViewCellReuseIdentifier"

    let networkService = WebDataRequest()
    var photoResponse: JSONInfo<ResponseJsonPhotos>? = nil
    let test = SomeMethods()

    var groupsResponse: JSONInfo<ResponseGroups>? = nil
    var groupIdArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollection()
        getPhotoRequest()
    }

    func getPhotoRequest() {
        networkService.requestGetPhoto { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let photoInfo):
                photoInfo.response.items.map { (name) in

                    self.photoResponse = photoInfo
                    self.testCollectionView.reloadData()
                }
            case .failure(let error):
                print("error: - ", error)
            }
        }
    }

    private func setupCollection() {
        testCollectionView.register(UINib(nibName: nameNibIdentifier, bundle: nil), forCellWithReuseIdentifier: photoGalleryCollectionViewCellReuseIdentifier)

        testCollectionView.dataSource = self
        testCollectionView.delegate = self
    }
}


extension TestCollectionViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoResponse?.response.items.map {$0.ownerId}.count ?? 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photoGalleryCollectionViewCellReuseIdentifier, for: indexPath) as? PhotoGalleryCollectionViewCell else { return UICollectionViewCell() }

        let strUrlLast = photoResponse?.response.items.map {$0.sizes.last?.url}[indexPath.item] ?? ""
        let url = URL(string: strUrlLast)

        cell.photoImage.showImage(with: url)


        return cell
    }
}

extension TestCollectionViewController: UICollectionViewDelegate {

}

extension TestCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = collectionView.bounds.width
        let whiteSpaces: CGFloat = 3
        let cellWidth = width / 2 - whiteSpaces

        return CGSize(width: cellWidth, height: cellWidth)
    }
}
