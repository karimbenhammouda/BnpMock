//
//  File.swift
//  BnpMock
//
//  Created by karim BEN HAMMOUDA on 14/06/2022.
//

import Swinject
import SwinjectStoryboard
import UIKit

class SwinjectContainer {
    // MARK: - Properties
    
    var container = Container()
    
    // MARK: - Public function
    
    public func register() {
        // MARK: - APIClient
        
        // APIClient
        container.register(Networking.self, factory: { resolver in
            return APIClient()
        })
        
        // MARK: - ViewModel
        
        // ListMoviesViewModel
        container.register(HomeViewModel.self) { (resolver, coordinator: Coordinator) in
            HomeViewModelImplement( coordinator: coordinator)
        }
        
        // ListMoviesViewModel
        container.register(ListMoviesViewModel.self) { (resolver, isMock: Bool, coordinator: Coordinator) in
            ListMoviesViewModelImplement(apiClient: resolver.resolve(Networking.self), isMockData: isMock, coordinator: coordinator)
        }
        
        // DetailsMoviesViewModel
        container.register(DetailsMoviesViewModel.self) { (resolver, movie: Movie) in
            DetailsMoviesViewModelImplement(movie: movie)
        }
        
        //MovieCellViewModel
        container.register(MovieCellViewModel.self) { (resolver, movie: Movie) in
            MovieCellViewModelImplement(movie: movie)
        }
        
        // MARK: - ViewController
        
        // ListMoviesViewController
        container.register(HomeViewController.self) { (resolver) in
            let homeViewController = HomeViewController()
            return homeViewController
        }
        
        // ListMoviesViewController
        container.register(ListMoviesViewController.self) { (resolver, isMock: Bool, coordinator: Coordinator) in
            let listMoviesViewController = ListMoviesViewController()
            listMoviesViewController.viewModel = resolver.resolve(ListMoviesViewModel.self, arguments: isMock, coordinator)
            return listMoviesViewController
        }

        // DetailsMoviesViewController
        container.register(DetailsMoviesViewController.self) { (resolver, movie: Movie) in
            let detailsMoviesViewController = DetailsMoviesViewController()
            detailsMoviesViewController.viewModel = resolver.resolve(DetailsMoviesViewModel.self, argument: movie)
            return detailsMoviesViewController
        }
    }
}
