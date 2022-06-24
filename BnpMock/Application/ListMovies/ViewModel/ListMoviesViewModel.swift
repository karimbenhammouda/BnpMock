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
    
    var apiUrl: String { get set }

    func fetchMovieList()
    
    func search(_ query: String)

}

class ListMoviesViewModelImplement: ListMoviesViewModel {
    // MARK: - Properties

    var displayedMovieList: BehaviorRelay<[Movie]> = BehaviorRelay.init(value: [])
    var mainListMovies: Observable<PopularMovies>?
    var filtredMoviesList: [Movie]
    let disposeBag = DisposeBag()
    var apiUrl: String
    private let apiClient: Networking?

    // MARK: - init
    
    init(apiClient: Networking?, apiUrl: String) {
        self.apiClient = apiClient
        self.apiUrl = apiUrl
        self.filtredMoviesList = []
    }

    // MARK: - public func
    
    func fetchMovieList() {
        mainListMovies = self.apiClient?.getData(url: apiUrl)

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


