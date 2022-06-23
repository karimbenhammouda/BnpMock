//
//  Constants.swift
//  BnpMock
//
//  Created by karim BEN HAMMOUDA on 15/06/2022.
//

import Foundation
import UIKit

struct Constants {
    // MARK: - WebService Constant
    
    struct WebServiceConstant {
        static let apiKey = "api_key="
        static let apiKeyValue = "0f87166fa120d80fe37a8f4835bec5ae"
    }
    
    // MARK: - cell Identifier
    
    struct cellIdentifier {
        static let movieCell = "MovieTableViewCell"
    }
    
    // MARK: - cell Nib Name
    
    struct nibName {
        static let movieCell = "MovieTableViewCell"
    }
    
    // MARK: - Font
    
    struct font {
        static let readMoreFont = UIFont(name: "Helvetica-Oblique", size: 11.0)!
    }
}
