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
        container.register(Networking.self, name: "ApiClient", factory: { (resolver) in
                return APIClient()
        })
        
        container.register(Networking.self, name: "ApiClientMock", factory: { (resolver) in
                return APIClientMock()
        })
        
        // MARK: - ViewModel
        
        // ListMoviesViewModel
        container.register(ListMoviesViewModel.self) { (resolver, networking: Networking?, apiUrl: String) in
            ListMoviesViewModelImplement(apiClient: networking, apiUrl: apiUrl)
        }
        
        // DetailsMoviesViewModel
        container.register(DetailsMoviesViewModel.self) { (resolver, movie: Movie) in
            let movieDetails = MovieDeatils(title: movie.originalTitle, overview: movie.overview, backdropPath: movie.backdropPath)
            return DetailsMoviesViewModelImplement(movieDeatils: movieDetails)
        }
        
        //MovieCellViewModel
        container.register(MovieCellViewModel.self) { (resolver, movie: Movie) in
            let movielist = MovieList(title: movie.title, overview: movie.overview, posterPath: movie.posterPath)
            return MovieCellViewModelImplement(movie: movielist)
        }
        
        // MARK: - ViewController
        
        // ListMoviesViewController
        container.register(HomeViewController.self) { (resolver, coordinator: Coordinator) in
            let homeViewController = HomeViewController(coordinator: coordinator)
            return homeViewController
        }
        
        // ListMoviesViewController
        container.register(ListMoviesViewController.self) { (resolver, coordinator: Coordinator, apiUrl: String) in
            let viewModel = resolver.resolve(ListMoviesViewModel.self, arguments: coordinator.apiclient, apiUrl)
            let listMoviesViewController = ListMoviesViewController(viewModel: viewModel!, coordinator: coordinator)
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
