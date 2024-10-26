//
//  ServicesCollectionViewCell.swift
//  FrameworkApp
//
//  Created by MacBook Pro on 15/10/2024.
//

import UIKit

class ServicesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var serviceImg: UIImageView!
    @IBOutlet weak var serviceTitle: UILabel!
    @IBOutlet weak var serviceView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        serviceView.borderColor = UIColor.black.cgColor
    }
}

extension ServicesCollectionViewCell:HomeServiceCellProtocol{
    
    func setServiceImg(imgUrl:String){
//        ImageShowing().showImage(imgURl: imgUrl , imgView: serviceImg, avatar: "Launch Logo-2")
    }
    
    func setServiceTitle(titleEnum:InstallmentLoockUpTypeEnum){
        switch titleEnum{
        case .Health:
            serviceTitle.text = "Health"
        case .Education:
            serviceTitle.text = "Education"
        case .Insurance:
            serviceTitle.text = "Insurance"
        case .Wedding:
            serviceTitle.text = "Wedding"
        case .Car:
            serviceTitle.text = "Car"
        case .Finishing:
            serviceTitle.text = "Finishing"
        case .Travel:
            serviceTitle.text = "Travel"
        case .BillPayment:
            serviceTitle.text = "Bill"
        case .Others:
            serviceTitle.text = "Others"
        default:
            serviceTitle.text = ""
        }
    }
}
