//
//  HomeViewModel.swift
//  BnpMock
//
//  Created by Karim Ben Hammouda on 21/06/2022.
//

import Foundation

protocol HomeViewModel {
        
    var coordinator: Coordinator? { get set }

}

class HomeViewModelImplement: HomeViewModel {
    // MARK: - Properties
    
    var coordinator: Coordinator?
    
    // MARK: - init
    
    init(coordinator: Coordinator?) {
        self.coordinator = coordinator
    }
}


