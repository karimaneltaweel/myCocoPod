//
//  NewHomePresenter.swift
//  FrameworkApp
//
//  Created by MacBook Pro on 15/10/2024.
//

import Foundation

protocol NewHomeView: AnyObject {
    func initUI()
    func showAPIErrorAlert(error: CustomError)
    func educationCollectionHeight(height:Int)
    func carCollectionHeight(height:Int)
    func finishingCollectionHeight(height:Int)
    func reload()
    func reloadTopProvider()
    func showSkelaton()
    func hideSkelaton()
    func upadateCustomDropDown(customCat: [Datum])
}


protocol HomeServiceCellProtocol {
    func setServiceImg(imgUrl:String)
    func setServiceTitle(titleEnum:InstallmentLoockUpTypeEnum)
}


protocol CategoryCellProtocol{
    func setCategoryImg(imgUrl:String)
    func setCategoryTitle(title:String)
    func setBackground(light:Bool)
}

protocol WeddingCollectionProtocol{
    func setName(with name: String)
    func setImage(with image: String)
}

protocol TopProvidersCellProtocol{
    func setItemName(itemName:String)
    func itemProviderName(providerName:ProviderTypeEnum)
    func setProviderStart(start:String)
    func setProviderImage(imgUrl:String)
}

protocol ServiceCellProtocol{
    func setServiceName(with name:String)
    func setServiceImage(with image:String,fromHome:Bool)
}

protocol NewHomePresenter {
    func viewDidLoad()
    func configure(cell: HomeServiceCellProtocol, forRow row: Int)
    func configureCell(cell: ServiceCellProtocol, forRow row: Int)
    func configureEducationCell(cell: CategoryCellProtocol, forRow row: Int)
    func configureWeddingCell(cell: WeddingCollectionProtocol, forRow row: Int)
    func configureCarCell(cell: CategoryCellProtocol, forRow row: Int)
    func configureFinishingCell(cell: CategoryCellProtocol, forRow row: Int)
    func configureTopProvidersCell(cell: TopProvidersCellProtocol, forRow row: Int)
    func numOfServices() -> Int
    func numOfHealthServices() -> Int
    func numOfEducatiobServices() -> Int 
    func numOfWeddingServices() -> Int
    func numOfCarServices() -> Int
    func numOffinishingServices() -> Int
    func numOffTopProviders() -> Int
    func didItemSelectedInService(at index: Int)
    func didSelectItemOnEducation(at index: Int)
    func didSelectItemOnTravel()
    func didSelectItemOnWedding(at index: Int)
    func didSelectItemOnCar(at index: Int)
    func didSelectItemOnFinishing(at index: Int)
    func didSelectItemOnViewMore(serviceType:InstallmentLoockUpTypeEnum,FromAllServices:Bool)
    func didSelectCustomServiceDropDown(index: Int, item: String)
    func cLickOnCustom()
    func serviceName(type:InstallmentLoockUpTypeEnum) -> String
    func clickOnFp()
    func clickOnSetting(index:Int)
    func didSelectItemOnHealth(at index: Int)
}

protocol NewHomeInteractorToPresenterProtocol:AnyObject{
    func fetchHome(result:Result<Home,CustomError>)
    func fetchTopProviders(result:Result<TopProvider,CustomError>)
}

class NewHomePresenterImplementation: NewHomePresenter {
    fileprivate weak var view: NewHomeView?
    internal let router: NewHomeRouter
    internal let interactor : NewHomeInteractor
    fileprivate var homeData:Home?
    fileprivate var customCategories:Home?
    fileprivate var healthData:Datum?
    fileprivate var educationData:Datum?
    fileprivate var weddingData:Datum?
    fileprivate var carData:Datum?
    fileprivate var finisingData:Datum?
    fileprivate var topProviderData:TopProvider?
    var selectedcustomId = 0

    init(view: NewHomeView,router: NewHomeRouter,interactor:NewHomeInteractor) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.interactor.viewDidLoad(presenter: self)
    }

    
    func viewDidLoad() {
        self.view?.showSkelaton()
        self.interactor.getHome()
        self.interactor.getTopProvider()
        self.view?.initUI()
    }
    
    func configure(cell: HomeServiceCellProtocol, forRow row: Int) {
        cell.setServiceImg(imgUrl: homeData?.data?[row].serviceTypeImgURL ?? "")
        cell.setServiceTitle(titleEnum:  homeData?.data?[row].type ?? .Health)
    }
    
    func configureCell(cell: ServiceCellProtocol, forRow row: Int) {
        cell.setServiceImage(with:  healthData?.serivceTypesCategories?[row].sdkImgURL ?? "",fromHome: true)
        cell.setServiceName(with: healthData?.serivceTypesCategories?[row].name ?? "")
    }
    
    func configureEducationCell(cell: CategoryCellProtocol, forRow row: Int) {
        cell.setBackground(light: true)
        cell.setCategoryImg(imgUrl:educationData?.serivceTypesCategories?[row].sdkImgURL ?? "")
        cell.setCategoryTitle(title:educationData?.serivceTypesCategories?[row].name ?? "")
    }
    
    func configureWeddingCell(cell: WeddingCollectionProtocol, forRow row: Int){
        cell.setImage(with: weddingData?.serivceTypesCategories?[row].sdkImgURL ?? "")
        cell.setName(with: weddingData?.serivceTypesCategories?[row].name ?? "")

    }
    
    func configureCarCell(cell: CategoryCellProtocol, forRow row: Int){
        cell.setBackground(light: true)
        cell.setCategoryImg(imgUrl:carData?.serivceTypesCategories?[row].sdkImgURL ?? "")
        cell.setCategoryTitle(title:carData?.serivceTypesCategories?[row].name ?? "")

    }
    
    func configureFinishingCell(cell: CategoryCellProtocol, forRow row: Int){
        cell.setBackground(light: false)
        cell.setCategoryImg(imgUrl:finisingData?.serivceTypesCategories?[row].sdkImgURL ?? "")
        cell.setCategoryTitle(title:finisingData?.serivceTypesCategories?[row].name ?? "")

    }
    
    func configureTopProvidersCell(cell: TopProvidersCellProtocol, forRow row: Int) {
        cell.setItemName(itemName:topProviderData?.data?[row].name ?? "")
        cell.setProviderStart(start: "\(topProviderData?.data?[row].id ?? "")")
        cell.setProviderImage(imgUrl:topProviderData?.data?[row].imageURL ?? "")
        cell.itemProviderName(providerName: topProviderData?.data?[row].type ?? .MedicalHistory)
    }
    
    func numOfServices() -> Int{
        homeData?.data?.count ?? 0
    }
    
    func numOfHealthServices() -> Int {
        healthData?.serivceTypesCategories?.count ?? 0
    }
    
    func numOfEducatiobServices() -> Int {
        educationData?.serivceTypesCategories?.count ?? 0
    }
    
    func numOfWeddingServices() -> Int {
        weddingData?.serivceTypesCategories?.count ?? 0
    }
    
    func numOfCarServices() -> Int {
        carData?.serivceTypesCategories?.count ?? 0
    }
    
    func numOffinishingServices() -> Int {
        finisingData?.serivceTypesCategories?.count ?? 0
    }
    
    func numOffTopProviders() -> Int {
        topProviderData?.data?.count ?? 0
    }
    
    func getFilteredData(){
        healthData = homeData?.data?.first(where:{$0.type == InstallmentLoockUpTypeEnum.Health})
        educationData = homeData?.data?.first(where:{$0.type == InstallmentLoockUpTypeEnum.Education})
        weddingData = homeData?.data?.first(where: {$0.type == InstallmentLoockUpTypeEnum.Wedding})
        carData = homeData?.data?.first(where: {$0.type == InstallmentLoockUpTypeEnum.Car})
        finisingData = homeData?.data?.first(where: {$0.type == InstallmentLoockUpTypeEnum.Finishing})
        self.view?.educationCollectionHeight(height:(75*2) + 10)
        self.view?.carCollectionHeight(height:(75*2) + 10)
        self.view?.finishingCollectionHeight(height:(75*2) + 10)
    }
    
    func didItemSelectedInService(at index: Int) {
        self.router.clickOnService(for:homeData?.data?[index].type ?? .GYM)
    }
    
    func didSelectItemOnEducation(at index: Int){
        self.router.goToEducation(catId: educationData?.serivceTypesCategories?[index].id ?? 0, catType: getCategory(eduID: educationData?.serivceTypesCategories?[index].id ?? 0) , catName: educationData?.serivceTypesCategories?[index].name ?? "")
    }

    func didSelectItemOnTravel(){
        self.router.goToTravel()
    }
    
    func didSelectItemOnWedding(at index: Int){
        router.navigateToWeddingList(for: weddingData?.serivceTypesCategories?[index].id ?? 0, with: weddingData?.serivceTypesCategories?[index].name ?? "",from: .ViewAll, searchText: nil)
    }
    
    func didSelectItemOnCar(at index: Int){
        router.goToCar(for: carData?.serivceTypesCategories?[index].id ?? 0, with: carData?.serivceTypesCategories?[index].name,from: .ViewAll, searchText: nil,brandID: nil,locationID: nil,serviceID: nil)

    }
    
    func didSelectItemOnFinishing(at index: Int){
        router.navigateToFinishingList(for: finisingData?.serivceTypesCategories?[index].id ?? 0, with:  finisingData?.serivceTypesCategories?[index].name ?? "", searchText: nil,from: .ViewAll)
    }
    
    func didSelectItemOnViewMore(serviceType:InstallmentLoockUpTypeEnum,FromAllServices:Bool){
        router.viewMoreNavigate(serviceType:serviceType,FromAllServices:FromAllServices)
    }
    
    
    func didSelectItemOnHealth(at index: Int){
        if healthData?.serivceTypesCategories?[index].id == 48 {
            self.router.navigateToPharmacy()
        } else {
            self.router.navigateToHealth(for: healthData?.serivceTypesCategories?[index].id ?? 0, with: healthData?.serivceTypesCategories?[index].name ?? "")
        }

    }
    
    func getCategory(eduID:Int) -> Int{
                    return 0
//        switch eduID{
//        case 14:
//            return EducationCategoryTypeEnum.School.rawValue
//        case 15:
//            return EducationCategoryTypeEnum.University.rawValue
//        case 16:
//            return EducationCategoryTypeEnum.Institute.rawValue
//        case 33:
//            return EducationCategoryTypeEnum.Courses.rawValue
//        default:
//            return 0
//        }
    }
    
    func serviceName(type:InstallmentLoockUpTypeEnum) -> String{
        switch type{
        case .Health:
            return "Health"
        case .Education:
            return "Education"
        case .Insurance:
            return "Insurance"
        case .Wedding:
            return "Wedding"
        case .Car:
            return "Car"
        case .Finishing:
            return"Finishing"
        case .Travel:
            return "Travel"
        case .BillPayment:
            return"Bill"
        case .Others:
            return "Others"
        default:
            return ""
        }
    }
    
    func didSelectCustomServiceDropDown(index: Int, item: String){
        print("Selected item: \(item) at index: \(index)")
        self.selectedcustomId = index
    }
    
    func cLickOnCustom() {
        if let cutomType = MainCategoriesEnum(rawValue: self.selectedcustomId) {
            switch cutomType {
            case .Health:
                self.router.goToHealth()
            case .Education:
                self.router.goToEducation()
            case .Insurance:
                self.router.goToInsurance()
            case .Wedding:
                self.router.goToWedding()
            case .Car:
                self.router.goToCar()
            case .Travel:
                self.router.goToCustomTravel()
            case .BillPayment:
                self.router.goToBillPayment()
            case .Others:
                self.router.goToOthers()
            case .Finishing:
                self.router.goToFinishing()
            default:
                print("OK")
            }
        }
    }
    
    func clickOnSetting(index:Int){
        switch index {
        case 0:
            self.router.goToCarts()
        case 1:
            self.clickOnFp()
        case 2:
            self.clickOnRequests()
        default:
            print("")
        }
    }
    
    
    func clickOnFp(){
//        SDKManager.shared.checkUserValue() ? router.goToFP() : router.signIn(from: .FP)
    }
    
    func clickOnRequests(){
//        SDKManager.shared.checkUserValue() ? router.goToRequests() : router.signIn(from: .Request)
    }
}

extension NewHomePresenterImplementation:NewHomeInteractorToPresenterProtocol{
    func fetchTopProviders(result: Result<TopProvider, CustomError>) {
        switch result {
        case .success(let success):
            self.topProviderData = success
            self.view?.reloadTopProvider()
        case .failure(let failure):
            self.view?.showAPIErrorAlert(error: failure)
        }
    }
    
    func fetchHome(result: Result<Home, CustomError>) {
        switch result {
        case .success(let success):
            self.view?.hideSkelaton()
            self.homeData = success
            self.customCategories = success
            self.customCategories?.data?.append(Datum(id:MainCategoriesEnum.Others.rawValue,type: InstallmentLoockUpTypeEnum.Others, serviceTypeImgURL: "", serivceTypesCategories:[]))
            self.view?.upadateCustomDropDown(customCat:customCategories?.data ?? [])
            if let index = homeData?.data?.firstIndex(where: { $0.type == .BillPayment }) {
                homeData?.data?.remove(at: index)
                if let index = homeData?.data?.firstIndex(where: { $0.type == .Insurance }) {
                    homeData?.data?.remove(at: index)
                }
            }
            getFilteredData()
            self.view?.reload()
        case .failure(let failure):
            self.view?.showAPIErrorAlert(error: failure)
        }
    }
}
