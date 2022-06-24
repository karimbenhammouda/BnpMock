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
    let container: Container
    let navigationController = UINavigationController()
    
    // MARK: Init
    
    init(windowScene: UIWindowScene?, swinjectContainer: SwinjectContainer, window: UIWindow?) {
        self.windowScene = windowScene
        self.container = swinjectContainer.container
        self.window = window
    }
    
    // MARK: Public Func
    
    func start() {
        guard let windowScene = windowScene, let homeViewController = container.resolve(HomeViewController.self, argument: self) else {
            return
        }
        navigationController.viewControllers = [homeViewController]
        navigationController.popToRootViewController(animated: false)
        if let window = window {
            window.windowScene = windowScene
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        }
    }
    
    func showListMovies(apiClient: Networking) {
        guard let controller = container.resolve(ListMoviesViewController.self, arguments: self, apiClient) else {
            return
        }
        navigationController.pushViewController(controller, animated: true)
    }
    
    func showDetailsMovie(movie: Movie) {
        guard let controller = container.resolve(DetailsMoviesViewController.self, argument: movie) else {
            return
        }
        self.navigationController.pushViewController(controller, animated: true)
    }
}



