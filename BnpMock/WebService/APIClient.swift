//
//  APIClient.swift
//  BnpMock
//
//  Created by karim BEN HAMMOUDA on 14/06/2022.
//

import Foundation
import RxSwift
import RxCocoa

public protocol Networking {
    func getData<T: Codable>(url: String) -> Observable<T>
}

class APIClient: Networking {

    func getData<T: Codable>(url: String) -> Observable<T> {
        return Observable<T>.create { [weak self] observer in
            guard self != nil else { return Disposables.create() }
                guard let request = URL(string: url) else {
                    return Disposables.create()
                }

                let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                    do {
                        let model = try JSONDecoder().decode(T.self, from: data ?? Data())
                        observer.onNext( model )
                    } catch let error {
                        observer.onError(error)
                    }
                    observer.onCompleted()
                }

                task.resume()
                return Disposables.create {
                    task.cancel()
                }
        }
    }
}



