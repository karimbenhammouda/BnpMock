//
//  DetailsMoviesViewModel.swift
//  BnpMock
//
//  Created by karim BEN HAMMOUDA on 15/06/2022.
//

import Foundation

protocol DetailsMoviesViewModel {
    var movie: Movie { get set }
}

class DetailsMoviesViewModelImplement: DetailsMoviesViewModel {
    // MARK: - Properties

    var movie: Movie
    
    // MARK: - init
    
    init(movie: Movie) {
        self.movie = movie
    }
    
}
