//
//  NewHomeRouter.swift
//  FrameworkApp
//
//  Created by MacBook Pro on 15/10/2024.
//

import UIKit
//import FittedSheets


protocol NewHomeRouter {
    func goToService()
    func clickOnService(for type: InstallmentLoockUpTypeEnum)
    func goToCarts()
    func goToFinancialProfile()
    func goToEducation(catId:Int,catType:Int,catName:String)
    func goToTravel()
    func navigateToWeddingList(for catID:Int?,with catName:String?,from:FromPage,searchText:String?)
    func goToCar(for catID:Int?,with catName:String?,from:FromPage,searchText:String?,brandID:Int?,locationID:Int?,serviceID:Int?)
    func navigateToFinishingList(for catID:Int?,with catName:String?,searchText:String?,from: FromPage)
    func viewMoreNavigate(serviceType:InstallmentLoockUpTypeEnum,FromAllServices:Bool)
    func goToHealth()
    func goToEducation()
    func goToInsurance()
    func goToWedding()
    func goToCustomTravel()
    func goToBillPayment()
    func goToOthers()
    func goToCar()
    func goToFP()
    func goToFinishing()
    func signIn(from: HomeEnum?)
    func goToRequests()
    func navigateToHealth(for catID:Int?,with catName:String?)
    func navigateToPharmacy()
}

class NewHomeRouterImplementation: NewHomeRouter {
    fileprivate weak var NewHomeViewController: NewHomeViewController?
    
    init(NewHomeViewController: NewHomeViewController) {
        self.NewHomeViewController = NewHomeViewController
    }
    
    func goToService(){
//        self.NewHomeViewController?.navigationController?.pushViewController(ServicesVC(), animated: true)
    }
    
    func goToSubCategory() {
        
    }
    
    func clickOnService(for type: InstallmentLoockUpTypeEnum) {
//        switch type {
//        case .Health:
////            let vc = StoryboardsConstants.Category.getViewControllerInstance(identifier: "CategoryID")
//            self.NewHomeViewController?.navigationController?.pushViewController(CategoriesVC(), animated: true)
//        case .Car:
//            self.NewHomeViewController?.navigationController?.pushViewController(CarCategoryVC(), animated: true)
//        case .Finishing:
//            self.NewHomeViewController?.navigationController?.pushViewController(FinishingCategoryVC(), animated: true)
//        case .Wedding:
//            self.NewHomeViewController?.navigationController?.pushViewController(WeddingCategoryVC(), animated: true)
//        case .Travel:
//            self.NewHomeViewController?.navigationController?.pushViewController(TravelCategoryVC(), animated: true)
//        case .Education:
//            let vc = StoryboardsConstants.EducationCatalogue.getViewControllerInstance(identifier: "EducationVCID")
//            self.NewHomeViewController?.navigationController?.pushViewController(vc, animated: true)
//        default :
//            print("")
        }
     
//    }

    
    func goToCarts(){
//        let vc = GroupingCartViewController()
//        GroupingCartConfiguratorImplementation().configure(GroupingCartViewController: vc, fromLogin:false)
//        self.NewHomeViewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func goToFinancialProfile() {
//        let vc = StoryboardsConstants.FinancialProfileStepOne.getViewControllerInstance(identifier: "FPIntroViewController")
//        self.NewHomeViewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func goToEducation(catId:Int,catType:Int,catName:String){
//        let vc = StoryboardsConstants.EducationCatalogue.getViewControllerInstance(identifier: "SubCategoryID") as! EduSubCategoryVC
//        vc.catId = catId
//        vc.catType = catType
//        vc.catName = catName
//        self.NewHomeViewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func goToTravel() {
//        self.NewHomeViewController?.navigationController?.pushViewController(TravelCategoryVC(), animated: true)
    }
    
    func goToCar(for catID:Int?,with catName:String?,from:FromPage,searchText:String?,brandID:Int?,locationID:Int?,serviceID:Int?){
//        let vc = CarProvidersListVC()
//        CarProvidersListConfigurator().configure(vc: vc, catId: catID, catName: catName,from: from,searchText:searchText,brandID: brandID,locationID: locationID,serviceID: serviceID)
//        self.NewHomeViewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToFinishingList(for catID:Int?,with catName:String?,searchText:String?,from: FromPage){
//        let vc = FinishingProviderListVC()
//        FinishingProviderConfigurator().configure(vc: vc, catId: catID, catName: catName, from: from,searchText:searchText)
//        self.NewHomeViewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToHealth(for catID:Int?,with catName:String?){
        //        let vc = StoryboardsConstants.Category.getViewControllerInstance(identifier: "MainSubCategoryTabID") as! MainSubCategoryTabVC
        //        vc.catName = catName ?? ""
        //        vc.catId = catID ?? 0
        //        self.NewHomeViewController?.navigationController?.pushViewController(vc, animated: true)
        //    }
    }
    
    func navigateToPharmacy(){
//        let vc = PharmacyDetailsViewController()
//        PharmacyDetailsConfiguratorImplementation().configure(PharmacyDetailsViewController: vc,editObj: nil,fromEdit: false)
//        self.NewHomeViewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToWeddingList(for catID:Int?,with catName:String?,from:FromPage,searchText:String?){
//        let vc = WeddingProvidersListVC()
//        WeddingProviderListConfigurator().configure(vc: vc, catId: catID, catName: catName, from: from, searchText: searchText, entityName: nil, cityID: nil, categoryID: nil)
//        self.NewHomeViewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func viewMoreNavigate(serviceType:InstallmentLoockUpTypeEnum,FromAllServices:Bool){
//        if FromAllServices{
//            self.goToService()
//        }else{
//            self.clickOnService(for: serviceType)
//        }
    }
    func goToHealth(){
//        self.NewHomeViewController?.navigationController?.pushViewController(CustomHealthViewController(), animated: true)
    }
    func goToEducation(){
//        self.NewHomeViewController?.navigationController?.pushViewController(CustomEducationViewController(), animated: true)
    }
    func goToInsurance(){
//        self.NewHomeViewController?.navigationController?.pushViewController(CustomInsuranceViewController(), animated: true)
    }
    func goToWedding(){
//        self.NewHomeViewController?.navigationController?.pushViewController(CustomWeddingViewController(), animated: true)
    }
    
    func goToCustomTravel(){
//        self.NewHomeViewController?.navigationController?.pushViewController(CustomTravelViewController(), animated: true)
    }
    func goToBillPayment(){
//        self.NewHomeViewController?.navigationController?.pushViewController(CustomBillViewController(), animated: true)
    }
    func goToOthers(){
//        self.NewHomeViewController?.navigationController?.pushViewController(CustomOtherViewController(), animated: true)
    }
    func goToCar(){
//        self.NewHomeViewController?.navigationController?.pushViewController(CustomCarViewController(), animated: true)
    }
    func goToFP() {
//        let vc = StoryboardsConstants.FinancialProfileStepOne.getViewControllerInstance(identifier: "FPIntroViewController")
//        self.NewHomeViewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func goToFinishing() {
//        self.NewHomeViewController?.navigationController?.pushViewController(CustomFinishingViewController(), animated: true)

    }
    
    func signIn(from: HomeEnum?) {
//        let navigationController = UINavigationController(rootViewController: SignInVC())
//        let controller = SheetViewController(controller: navigationController, sizes: [.fixed(450.00)])
//        controller.topCornersRadius = 27
//        controller.dismissOnBackgroundTap = false
//        controller.dismissOnPan = false
//        controller.didDismiss = { [self] v in
//            //TODO: check here FROM
//            if SDKManager.shared.checkUserValue() {
//                switch from {
//                case .FP:
//                    self.goToFP()
//                case .Request:
//                    //TODO: go to requests
//                   goToRequests()
//                case .none:
//                    print("GO TO")
//                }
//            } else {
//                self.signIn(from: nil)
//            }
//        }
//        self.NewHomeViewController?.present(controller, animated: true, completion: nil)
        
    }
    
    func goToRequests(){
//        let vc = UIStoryboard(name: "Booking", bundle: nil).instantiateViewController(withIdentifier: "MyBookingViewController") as! MyBookingViewController
//        MyBookingConfiguratorImplementation().configure(MyBookingViewController: vc)
//        self.NewHomeViewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
