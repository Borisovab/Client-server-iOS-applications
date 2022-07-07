//
//  TableViewCell.swift
//  VKclient
//
//  Created by Александр Борисов on 03.06.2022.
//

import UIKit

class TableViewCell: UITableViewCell {


    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLable: UILabel!
    @IBOutlet weak var viewForImageAnimate: UIView!
    
    var closure: (() -> Void)?
    

    override func prepareForReuse() {
        super.prepareForReuse()

        avatarImage.image = nil
        nameLabel.text = nil
        descriptionLable.text = nil
        closure = nil
    }

    func configureTableViewCell(avatar: UIImage?, name: String?, description: String?, closure: @escaping () -> Void) {
        avatarImage.image = avatar
        nameLabel.text = name
        descriptionLable.text = description
        self.closure = closure

        self.backgroundColor = #colorLiteral(red: 0.9205206037, green: 1, blue: 0.9940114617, alpha: 1)

        shadowForImage()
    }

    func configurePeople(avatar: UIImage?, name: String?, city: String?, closure: @escaping () -> Void) {
        avatarImage.image = avatar
        nameLabel.text = name
        descriptionLable.text = city
        self.closure = closure

        self.backgroundColor = #colorLiteral(red: 0.9205206037, green: 1, blue: 0.9940114617, alpha: 1)
        
        shadowForImage()
    }

    func shadowForImage() {
        avatarImage.layer.cornerRadius = self.bounds.height / 3

        viewForImageAnimate.layer.cornerRadius = avatarImage.layer.cornerRadius
        viewForImageAnimate.layer.borderWidth = 2
        viewForImageAnimate.layer.borderColor = UIColor.white.cgColor

        viewForImageAnimate.layer.shadowRadius = 35
        viewForImageAnimate.layer.shadowOffset = CGSize(width: 7, height: 0)
        viewForImageAnimate.layer.shadowOpacity = 0.9
        viewForImageAnimate.layer.shadowColor = UIColor.systemTeal.cgColor

    }

    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func pressImageButton(_ sender: UIButton) {

        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.4,
                       initialSpringVelocity: 0.2,
                       options: []) { [weak self] in
            guard let self = self else { return }
            self.avatarImage.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        } completion: { _ in
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.4,
                           initialSpringVelocity: 0.2,
                           options: []) { [weak self] in
                guard let self = self else { return }
                self.avatarImage.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            } completion: { [weak self] _ in
                guard let self = self else { return }
                self.closure?()
            }
        }

// вариант анимации без пружинки

//        UIView.animate(withDuration: 0.8) { [weak self] in
//            self?.avatarImage.transform = CGAffineTransform(rotationAngle: .pi).scaledBy(x: 0.8, y: 0.8)
//
//        } completion: { [weak self] _ in
//            UIView.animate(withDuration: 0.8) { [weak self] in
//                self?.avatarImage.transform = CGAffineTransform(rotationAngle: .pi * 2).scaledBy(x: 1.0, y: 1.0)
//            } completion: { [weak self] _ in
//
//                self?.closure?()
//            }
//        }

    }
}
