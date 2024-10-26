//
//  SubCatCell.swift
//  Salamtak PatientApp
//
//  Created by Eslam on 09/03/2022.
//  Copyright © 2022 Es. All rights reserved.
//

import UIKit
//import SVProgressHUD
//import AMShimmer
//import Lottie

class TopProvidersCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var itemImg: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemProviderName: UILabel!
    
    var opId = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        showAnimatedSkeleton()
        isUserInteractionEnabled = false
    }
    
    func hideSkeletonView() {
        isUserInteractionEnabled = true
//        hideSkeleton()
    }
    
    func configureCell(obj: SubCategoriesItems) {
        self.opId = obj.id
        self.itemName.text = obj.name
        self.itemProviderName.text = obj.providerName
//        self.startFromLbl.text = "\(obj.startFrom) "+"egp/Month".localized
//        ImageShowing().showImage(imgURl: obj.imageUrl ?? "" , imgView: itemImg, avatar: "Logo")
    }
    
    //MARK: For cell take collection width/2
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        
        setNeedsLayout()
        layoutIfNeeded()
        
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        
        var frame = layoutAttributes.frame
        frame.size.height = ceil(size.height)
        layoutAttributes.frame = frame
        
        return layoutAttributes
    }
}

extension TopProvidersCollectionViewCell:TopProvidersCellProtocol{
    func setItemName(itemName:String){
        self.itemName.text = itemName
    }
    
    func itemProviderName(providerName:ProviderTypeEnum){
        switch providerName {
        case .Doctor, .Operation, .MedicalHistory:
            itemProviderName.text = "top.Provider.Health"
        
        case .Wedding:
            itemProviderName.text = "top.Provider.wedding"
            
        case .Others, .Insurance, .GYM, .Bill:
            break
        case .Car:
            itemProviderName.text = "top.Provider.car"
            
        case .Finishing:
            itemProviderName.text = "top.Provider.fin"
            
        case .UniversityOrInstitute, .School, .Course:
            itemProviderName.text = "top.Provider.edu"
            
        case .Travel:
            itemProviderName.text = "top.Provider.travel"
        }
    }
    
    func setProviderStart(start:String){
//        self.startFromLbl.text = "\(start) "+"egp/Month".localized
    }
    
    func setProviderImage(imgUrl:String){
//        ImageShowing().showImage(imgURl: imgUrl , imgView: itemImg, avatar: "Logo")
    }
}
