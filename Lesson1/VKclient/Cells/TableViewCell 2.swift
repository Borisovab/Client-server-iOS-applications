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

    
    

    override func prepareForReuse() {
        super.prepareForReuse()

        avatarImage.image = nil
        nameLabel.text = nil
        descriptionLable.text = nil
    }

    func configureTableViewCell(avatar: UIImage?, name: String?, description: String?) {
        avatarImage.image = avatar
        nameLabel.text = name
        descriptionLable.text = description
    }

    func configurePeople(avatar: UIImage?, name: String?, city: String?) {
        avatarImage.image = avatar
        nameLabel.text = name
        descriptionLable.text = city

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
