//
//  MovieCellViewModel.swift
//  BnpMock
//
//  Created by karim BEN HAMMOUDA on 15/06/2022.
//

import Foundation

protocol MovieCellViewModel {
    var movie: Movie { get set }
}

class MovieCellViewModelImplement: MovieCellViewModel {
    // MARK: - Properties
    
    var movie: Movie
    
    // MARK: - init
    
    init(movie: Movie) {
        self.movie = movie
    }
}
