//
//  DetailsMoviesViewModel.swift
//  BnpMock
//
//  Created by karim BEN HAMMOUDA on 15/06/2022.
//

import Foundation

struct MovieDeatils {
   var title:String
   var overview:String
   var backdropPath:String

   init(title:String, overview:String, backdropPath:String) {
      self.title = title
      self.overview = overview
      self.backdropPath = backdropPath
  }
}

protocol DetailsMoviesViewModel {
    var movieDeatils: MovieDeatils { get set }
}

class DetailsMoviesViewModelImplement: DetailsMoviesViewModel {
    // MARK: - Properties

    var movieDeatils: MovieDeatils
    
    // MARK: - init
    
    init(movieDeatils: MovieDeatils) {
        self.movieDeatils = movieDeatils
    }
    
}
