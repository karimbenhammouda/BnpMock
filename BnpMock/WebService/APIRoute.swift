//
//  APIRoute.swift
//  BnpMock
//
//  Created by karim BEN HAMMOUDA on 15/06/2022.
//

import Foundation

protocol APIRouteBuilder {
    var urlString: String { get }
    var baseURL: String { get }
    var path: String { get }
}

enum APIRoute {
    case getImage
    case getListMovies
    case getListMoviesMock
}

extension APIRoute: APIRouteBuilder {
    var baseURL: String {
        switch self {
        case .getImage:
            return "https://image.tmdb.org/t/p/original"
        case .getListMoviesMock:
            return "MovieMock"
        default:
            return "https://api.themoviedb.org/3/"
        }
    }
    
    var path: String {
        switch self {
        case .getListMovies:
            return "movie/popular?"
        default:
            return ""
        }
    }

    var urlString: String {
        switch self {
        case .getImage, .getListMoviesMock:
            return "\(baseURL)"
        default:
            return "\(baseURL)\(path)\(Constants.WebServiceConstant.apiKey)\(Constants.WebServiceConstant.apiKeyValue)"
        }
    }
}
