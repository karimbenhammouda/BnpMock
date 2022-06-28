//
//  MovieCellViewModel.swift
//  BnpMock
//
//  Created by karim BEN HAMMOUDA on 15/06/2022.
//

import Foundation

struct MovieList {
   var title:String
   var overview:String
   var posterPath:String

   init(title:String, overview:String, posterPath:String) {
      self.title = title
      self.overview = overview
      self.posterPath = posterPath
  }
}

protocol MovieCellViewModel {
    var movie: MovieList { get set }
}

class MovieCellViewModelImplement: MovieCellViewModel {
    // MARK: - Properties
    
    var movie: MovieList
    
    // MARK: - init
    
    init(movie: MovieList) {
        self.movie = movie
    }
}
