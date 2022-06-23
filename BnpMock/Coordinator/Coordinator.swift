//
//  Coordinator.swift
//  BnpMock
//
//  Created by Karim Ben Hammouda on 21/06/2022.
//

import Foundation
import UIKit
import Swinject

class Coordinator {
    
    // MARK: Properties
    
    let windowScene: UIWindowScene?
    let window: UIWindow?
    let swinjectContainer: SwinjectContainer?
    let navigationController = UINavigationController()
    
    // MARK: Init
    
    init(windowScene: UIWindowScene?, swinjectContainer: SwinjectContainer?, window: UIWindow?) {
        self.windowScene = windowScene
        self.swinjectContainer = swinjectContainer
        self.window = window
    }
    
    // MARK: Public Func
    
    func start() {
        guard let windowScene = windowScene, let homeViewController = swinjectContainer?.container.resolve(HomeViewController.self) else {
            return
        }
        homeViewController.viewModel = swinjectContainer?.container.resolve(HomeViewModel.self, argument: self)
        navigationController.viewControllers = [homeViewController]
        navigationController.popToRootViewController(animated: false)
        if let window = window {
            window.windowScene = windowScene
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        }
    }
    
    func showListMovies(isMock: Bool) {
        guard let controller = swinjectContainer?.container.resolve(ListMoviesViewController.self, arguments: isMock, self) else {
            return
        }
        navigationController.pushViewController(controller, animated: true)
    }
    
    func showDetailsMovie(movie: Movie) {
        guard let controller = swinjectContainer?.container.resolve(DetailsMoviesViewController.self, argument: movie) else {
            return
        }
        self.navigationController.pushViewController(controller, animated: true)
    }
}



