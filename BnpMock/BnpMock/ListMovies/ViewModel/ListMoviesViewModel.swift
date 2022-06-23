//
//  ListMoviesViewModel.swift
//  BnpMock
//
//  Created by karim BEN HAMMOUDA on 15/06/2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol ListMoviesViewModel {
    var displayedMovieList: BehaviorRelay<[Movie]> { get set }

    var mainListMovies: Observable<PopularMovies>? { get set }
    
    var filtredMoviesList: [Movie] { get set }
    
    var isMockData: Bool { get set }
    
    var coordinator: Coordinator? { get set }

    func fetchMovieList()
    
    func search(_ query: String)

}

class ListMoviesViewModelImplement: ListMoviesViewModel {
    // MARK: - Properties
    
    var isMockData: Bool
    var displayedMovieList: BehaviorRelay<[Movie]> = BehaviorRelay.init(value: [])
    var mainListMovies: Observable<PopularMovies>?
    var filtredMoviesList: [Movie]
    let disposeBag = DisposeBag()
    var coordinator: Coordinator?
    private let apiClient: Networking?

    // MARK: - init
    
    init(apiClient: Networking?, isMockData: Bool, coordinator: Coordinator?) {
        self.apiClient = apiClient
        self.isMockData = isMockData
        self.coordinator = coordinator
        self.filtredMoviesList = []
    }

    // MARK: - public func
    
    func fetchMovieList() {
        mainListMovies = isMockData ? self.apiClient?.getData(url: APIRoute.getListMoviesMock.urlString, isMock: true) : self.apiClient?.getData(url: APIRoute.getListMovies.urlString, isMock: false)
        mainListMovies?
            .debug("mainListMovies received event")
            .subscribe(onNext: { [unowned self] movieListResult in
            displayedMovieList.accept(movieListResult.results)
            getInitFiltredData()
        }).disposed(by: disposeBag)
    }
    
    func search(_ query: String) {
        var movies: [Movie] = []
        
        movies = filtredMoviesList.filter { $0.originalTitle.hasPrefix(query) }
        
        Observable<[Movie]>.just(movies)
            .bind(to: displayedMovieList)
            .disposed(by: self.disposeBag)
    }
    
    // MARK: - private func
    
    private func getInitFiltredData() {
        guard let mainListMovies = mainListMovies else {
            return
        }
        mainListMovies.toArray()
            .subscribe({
                switch $0 {
                case .success(let value):
                    self.filtredMoviesList = value[0].results
                case .failure(_):
                    self.filtredMoviesList = []
                }
            })
            .disposed(by: disposeBag)
    }
}


