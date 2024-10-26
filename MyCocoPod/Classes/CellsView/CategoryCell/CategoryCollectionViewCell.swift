//
//  CategoryCollectionViewCell.swift
//  FrameworkApp
//
//  Created by MacBook Pro on 15/10/2024.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backgroundImge: UIImageView!
    @IBOutlet weak var categoryImg: UIImageView!
    @IBOutlet weak var categoryTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

extension CategoryCollectionViewCell:CategoryCellProtocol{
    func setCategoryImg(imgUrl:String){
//        ImageShowing().showImage(imgURl: imgUrl , imgView: categoryImg, avatar: "Launch Logo-2")
    }
    
    func setCategoryTitle(title:String){
        categoryTitle.text = title
    }
    
    func setBackground(light:Bool){
        if light{
            backgroundImge.image = UIImage(named: "backgroundLight")
            categoryTitle.textColor = .black
        }else{
            backgroundImge.image = UIImage(named: "backgroundDark")
            categoryTitle.textColor = .white
        }
    }
}
