//
//  NewHomeInteractor.swift
//  FrameworkApp
//
//  Created by MacBook Pro on 15/10/2024.
//

import Foundation


protocol NewHomeInteractorProtocol{
    
    func viewDidLoad(presenter:NewHomeInteractorToPresenterProtocol?)
    func getHome()
    func getTopProvider()
}

class NewHomeInteractor:NewHomeInteractorProtocol{
    fileprivate weak var  presenter:NewHomeInteractorToPresenterProtocol?

    
    func viewDidLoad(presenter: NewHomeInteractorToPresenterProtocol?) {
        self.presenter = presenter
    }
    
    func getHome() {
//        APICLient().executeQuery(params:[:], mapTo:APIRouter.Home, completion: {
//            [weak self] (result : Result<Home,CustomError>) in
//            self?.presenter?.fetchHome(result: result)
//        })
    }
    
    func getTopProvider() {
//        APICLient().executeQuery(params:[:], mapTo:APIRouter.getHomeTopProviders, completion: {
//            [weak self] (result : Result<TopProvider,CustomError>) in
//            self?.presenter?.fetchTopProviders(result: result)
//        })
    }
}
