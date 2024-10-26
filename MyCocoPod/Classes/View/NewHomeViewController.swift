//
//  NewHomeViewController.swift
//  FrameworkApp
//
//  Created by MacBook Pro on 15/10/2024.
//

import UIKit
//import DropDown

public final class NewHomeViewController: UIViewController {
    
    @IBOutlet weak var ServicesCollection: UICollectionView!
    @IBOutlet weak var ServiceViewMore: UIView!
    @IBOutlet weak var healthCollection: UICollectionView!
    @IBOutlet weak var healthViewMore: UIView!
    @IBOutlet weak var educationCollection: UICollectionView!
    @IBOutlet weak var educationViewMore: UIView!
    @IBOutlet weak var educationCollectionHeight: NSLayoutConstraint!
    @IBOutlet weak var travelViewMore: UIView!
    @IBOutlet weak var weddingCollection: UICollectionView!
    @IBOutlet weak var weddingViewMore: UIView!
    @IBOutlet weak var carViewMore: UIView!
    @IBOutlet weak var carCollection: UICollectionView!
    @IBOutlet weak var carCollectionHeight: NSLayoutConstraint!
    @IBOutlet weak var finishingViewMore: UIView!
    @IBOutlet weak var finishingCollection: UICollectionView!
    @IBOutlet weak var finishingCollectionHeight: NSLayoutConstraint!
    @IBOutlet weak var topProvidersViewMore: UIView!
    @IBOutlet weak var topProviderCollection: UICollectionView!
    @IBOutlet weak var customView: UIView!
    @IBOutlet weak var customTxt: UITextField!
    
    var presenter: NewHomePresenter?
    
//    let customDropDown = DropDown()
//    let settingsDropDown = DropDown()
    let settingBtn = UIButton(type: .system)

    var customDict = [Int:String]()
//    var imgsArr = [UIImage(named:"BookTapIcon"),UIImage(named:"iconFinancialProfile"),UIImage(named:"iconBookings")]

    
    let serviceCellRef = "ServicesCollectionViewCell"
    let HealthCellRef = "ServicesCell"
    let CategoryCollectionCellRef = "CategoryCollectionViewCell"
    let weddingCellRef = "WeddingCollectionViewCell"
    let topProvidersCellRef = "TopProvidersCollectionViewCell"

    var serviceMore = ViewAllViewController()
    var healthMore = ViewAllViewController()
    var educationMore = ViewAllViewController()
    var travelMore = ViewAllViewController()
    var weddingMore = ViewAllViewController()
    var carMore = ViewAllViewController()
    var finishingMore = ViewAllViewController()
    var TopProviderMore = ViewAllViewController()

    // MARK: - UIViewController Events
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "BNPL"
        presenter?.viewDidLoad()

    }
    
    public init () {
        super.init(nibName: "NewHomeViewController", bundle: Bundle(for: NewHomeViewController.self))
        self.modalPresentationStyle = .fullScreen
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // Custom initialization code here
    }
    
    @IBAction func travelPressed(_ sender: Any) {
        self.presenter?.didSelectItemOnTravel()
    }
    
  @IBAction  func customServicesPressed(_ sender: Any) {
//        customDropDown.show()
        
//        customDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
//            print("Selected item: \(item) at index: \(index)")
//            let selectedId = Array(self.customDict.filter {$0.value == item})[0].key
//            presenter?.didSelectCustomServiceDropDown(index: selectedId, item: item)
//            self.customTxt.text = item
//        }
    }
    
   @IBAction func startPressed(_ sender: Any) {
        self.presenter?.cLickOnCustom()
    }
    
    func registerCell(){
        ServicesCollection.register(UINib(nibName: serviceCellRef, bundle: nil), forCellWithReuseIdentifier: serviceCellRef)
        healthCollection.register(UINib(nibName: HealthCellRef, bundle: nil), forCellWithReuseIdentifier: HealthCellRef)
        educationCollection.register(UINib(nibName: CategoryCollectionCellRef, bundle: nil), forCellWithReuseIdentifier: CategoryCollectionCellRef)
        weddingCollection.register(UINib(nibName: weddingCellRef, bundle: nil), forCellWithReuseIdentifier: weddingCellRef)
        carCollection.register(UINib(nibName: CategoryCollectionCellRef, bundle: nil), forCellWithReuseIdentifier: CategoryCollectionCellRef)
        finishingCollection.register(UINib(nibName: CategoryCollectionCellRef, bundle: nil), forCellWithReuseIdentifier: CategoryCollectionCellRef)
        topProviderCollection.register(UINib(nibName: topProvidersCellRef, bundle: nil), forCellWithReuseIdentifier: topProvidersCellRef)


    }
    
    func addMoreViewAsSub(MainView:UIView,SubView:ViewAllViewController,serviceName:String,ViewAllName:String,serviceType:InstallmentLoockUpTypeEnum,FromAllServices:Bool){
        SubView.view.frame = MainView.bounds
        SubView.serviceLBL.text = serviceName
        SubView.viewAllLBL.text = ViewAllName
        SubView.viewpressed = {
            self.presenter?.didSelectItemOnViewMore(serviceType: serviceType, FromAllServices: FromAllServices)
        }
        SubView.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        MainView.addSubview(SubView.view)
    }
    
    func customDropDownInit() {
//        customDropDown.anchorView = customView
//        DropDown().dropDownStyle(dropdown: customDropDown)
    }
    
    func settingsDropDownInit() {
//        settingsDropDown.anchorView = settingBtn
//        settingsDropDown.direction = .bottom
//        settingsDropDown.dataSource = ["Cart","Financial profile","Requests"]
//        DropDown().dropDownStyle(dropdown: settingsDropDown)
    }
    
    
    private func setupNavigationBarButtons() {
        // Create a custom left button
        if #available(iOS 13.0, *) {
            settingBtn.setImage(UIImage(systemName: "gearshape.fill"), for: .normal)
        } else {
            // Fallback on earlier versions
        }
        settingBtn.tintColor = .black
        settingBtn.addTarget(self, action: #selector(fpButtonTapped), for: .touchUpInside)
        let settingButton = UIBarButtonItem(customView: settingBtn)
        self.navigationItem.rightBarButtonItem = settingButton
    }

    @objc private func fpButtonTapped() {
//        settingsDropDown.show()
//        settingsDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
//            print("Selected item: \(item) at index: \(index)")
//            self.presenter?.clickOnSetting(index: index)
//        }
    }
}



extension NewHomeViewController: NewHomeView {
    func initUI(){
        let overviewTextAttributes = [
            NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .bold)
        ] as [NSAttributedString.Key : Any]
        self.navigationController?.navigationBar.titleTextAttributes = overviewTextAttributes
        
        registerCell()
        setupNavigationBarButtons()
        addMoreViewAsSub(MainView: ServiceViewMore, SubView: serviceMore,serviceName: "Service",ViewAllName: "View All",serviceType:.GYM,FromAllServices: true)
        addMoreViewAsSub(MainView: healthViewMore, SubView: healthMore,serviceName: "Health",ViewAllName: "Explore More",serviceType:.Health,FromAllServices: false)
        addMoreViewAsSub(MainView: educationViewMore, SubView: educationMore,serviceName: "Education",ViewAllName: "Explore More",serviceType:.Education,FromAllServices: false)
        addMoreViewAsSub(MainView: travelViewMore, SubView: travelMore,serviceName: "Travel",ViewAllName: "Explore More",serviceType:.Travel,FromAllServices: false)
        addMoreViewAsSub(MainView: weddingViewMore, SubView: weddingMore,serviceName: "Wedding",ViewAllName: "Explore More",serviceType:.Wedding,FromAllServices: false)
        addMoreViewAsSub(MainView: carViewMore, SubView: carMore,serviceName: "Car Services",ViewAllName: "Explore More",serviceType:.Car,FromAllServices: false)
        addMoreViewAsSub(MainView: finishingViewMore, SubView: finishingMore,serviceName: "Finishing",ViewAllName: "Explore More",serviceType:.Finishing,FromAllServices: false)
        addMoreViewAsSub(MainView: topProvidersViewMore, SubView: TopProviderMore,serviceName: "Top Providers",ViewAllName: "Explore More",serviceType:.GYM,FromAllServices: false)
        customDropDownInit()
        settingsDropDownInit()
    }
    
    func showAPIErrorAlert(error: CustomError) {
//        self.networkFailureResponse(error: error)
    }
//    
    func reload(){
        ServicesCollection.reloadData()
        healthCollection.reloadData()
        educationCollection.reloadData()
        weddingCollection.reloadData()
        carCollection.reloadData()
        finishingCollection.reloadData()
        topProviderCollection.reloadData()
    }
    
    func reloadTopProvider(){
        topProviderCollection.reloadData()
    }
    
    func educationCollectionHeight(height:Int){
        educationCollectionHeight.constant = CGFloat(height)
    }
    
    func carCollectionHeight(height: Int) {
        carCollectionHeight.constant = CGFloat(height)
    }
    
    func finishingCollectionHeight(height: Int) {
        finishingCollectionHeight.constant = CGFloat(height)
    }
    
    func showSkelaton(){
//        self.view.showAnimatedSkeleton()
    }
    
    func hideSkelaton(){
//        self.view.hideSkeleton()
    }
    
    func upadateCustomDropDown(customCat: [Datum]){
//        self.customDropDown.dataSource.removeAll()
//        for i in 0 ..< customCat.count{
//            self.customDropDown.dataSource.append(presenter?.serviceName(type: customCat[i].type ?? .GYM) ?? "")
//            self.customDict[customCat[i].type?.rawValue ?? 0] = presenter?.serviceName(type: customCat[i].type ?? .GYM) ?? ""
//        }
//        print("AAAA::", customDict)
    }
}
