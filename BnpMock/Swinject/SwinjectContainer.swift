//
//  File.swift
//  BnpMock
//
//  Created by karim BEN HAMMOUDA on 14/06/2022.
//

import Swinject
import UIKit

class SwinjectContainer {
    // MARK: - Properties
    
    var container = Container()
    
    // MARK: - Public function
    
    public func register() {
        // MARK: - APIClient
        
        // APIClient
        container.register(Networking.self, factory: { (resolver, isMock: Bool) in
            if isMock {
                return APIClientMock()
            } else {
                return APIClient() 
            }
        })
        
        // MARK: - ViewModel
        
        // ListMoviesViewModel
        container.register(ListMoviesViewModel.self) { (resolver) in
            ListMoviesViewModelImplement(apiClient: resolver.resolve(Networking.self))
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
        container.register(HomeViewController.self) { (resolver, coordinator: Coordinator) in
            let homeViewController = HomeViewController(coordinator: coordinator)
            return homeViewController
        }
        
        // ListMoviesViewController
        container.register(ListMoviesViewController.self) { (resolver, coordinator: Coordinator, apiClient: Networking) in
            let viewModel = ListMoviesViewModelImplement(apiClient: apiClient)
            let listMoviesViewController = ListMoviesViewController(viewModel: viewModel, coordinator: coordinator)
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
