//
//  HomeViewController.swift
//  BnpMock
//
//  Created by karim BEN HAMMOUDA on 14/06/2022.
//

import UIKit
import RxRelay

class HomeViewController: UIViewController {
    
    // MARK: - @Properties
    var coordinator: Coordinator

    // MARK: - @IBOutlet
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var switchMock: UISwitch!
    
    // MARK: - override func
    
    override func viewDidLoad() {
        switchMock.setOn(false, animated: false)
    }
    
    // MARK: - @IBAction

    @IBAction func displayMoviesTapped(_ sender: Any) {
        let apiClient: Networking?
        let apiUrl: String
        if switchMock.isOn {
            apiClient = coordinator.container.resolve(Networking.self, name: "ApiClientMock")
            apiUrl = APIRoute.getListMoviesMock.urlString
        } else {
            apiClient = coordinator.container.resolve(Networking.self, name: "ApiClient")
            apiUrl = APIRoute.getListMovies.urlString
        }
        guard let apiClient = apiClient else { return }
        coordinator.apiclient = apiClient
        coordinator.showListMovies(apiUrl: apiUrl)
    }
}
