//
//  WeddingCollectionViewCell.swift
//  FrameworkApp
//
//  Created by MacBook Pro on 16/10/2024.
//

import UIKit

class WeddingCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}

extension WeddingCollectionViewCell:WeddingCollectionProtocol{
    
    func setName(with name: String) {
        self.name.text = name
    }
    
    func setImage(with image: String) {
//        ImageShowing().showImage(imgURl: image, imgView: self.image, avatar: "Logo")

    }
}
