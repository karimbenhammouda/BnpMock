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

class APIClientMock: Networking {

    func getData<T: Codable>(url: String) -> Observable<T> {
        return Observable<T>.create { [weak self] observer in
            guard let weakSelf = self else { return Disposables.create() }
                if let data = weakSelf.getmMockData(name: url) {
                    do {
                        let model = try JSONDecoder().decode(T.self, from: data)
                        observer.onNext(model)
                    } catch let error {
                        observer.onError(error)
                    }
                }
                observer.onCompleted()
                return Disposables.create()
        }
    }

    func getmMockData(name: String) -> Data? {
        if let path = Bundle.main.path(forResource: name, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return data
            } catch {
                print("Request failed with error: \(error)")
            }
        }
        return nil
    }
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



