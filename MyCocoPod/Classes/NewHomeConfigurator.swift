//
//  NewHomeConfigurator.swift
//  FrameworkApp
//
//  Created by MacBook Pro on 15/10/2024.
//

import Foundation


protocol NewHomeConfigurator {
    func configure(NewHomeViewController:NewHomeViewController)
}


class NewHomeConfiguratorImplementation {

    func configure(NewHomeViewController:NewHomeViewController) {
        let view = NewHomeViewController
        let router = NewHomeRouterImplementation(NewHomeViewController: view)
        
        let interactor = NewHomeInteractor()
        let presenter = NewHomePresenterImplementation(view: view, router: router,interactor:interactor)
        
        
        NewHomeViewController.presenter = presenter
    }
    
}
