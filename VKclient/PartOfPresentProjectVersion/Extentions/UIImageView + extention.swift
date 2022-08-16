//
//  UIImageView + extention.swift
//  VKclient
//
//  Created by Александр Борисов on 04.08.2022.
//

import Foundation

import UIKit


extension UIImageView {
    func showImage(with url: URL?) {
        guard let url = url else {
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let data = data else {
                return
            }

            let image = UIImage(data: data)
            DispatchQueue.main.async {
                self?.image = image
            }
        }.resume()
    }
//
//    func loadFromUrl(photoUrl:String) {
//
//        guard let url = URL(string: photoUrl) else { return }
//
//
//
//    }
//
//
//
//    //load image async from inaternet
//    func loadFromURL(photoUrl:String){
//        //NSURL
//        let url = NSURL(string: photoUrl)
//        //Request
//        let request = NSURLRequest(url:url! as URL);
//        //Session
//        let session = URLSession.sharedSession
//        //Data task
//        let datatask = session.dataTaskWithRequest(request) { (data:NSData?, response:NSURLResponse?, error:NSError?) -> Void in
//            if error != nil {
//                print(error?.localizedDescription)
//            }
//            dispatch_async(dispatch_get_main_queue()) {
//                self.image = UIImage(data: data!)
//            }
//        }
//        datatask.resume()
//    }
//
//

}
