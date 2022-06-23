//
//  ImageCache.swift
//  BnpMock
//
//  Created by karim BEN HAMMOUDA on 16/06/2022.
//

import UIKit

class ImageCache {
    // MARK: - Properties
    
    private let cache = NSCache<NSString, UIImage>()
    private var observer: NSObjectProtocol?

    static let shared = ImageCache()

    // MARK: - init
    
    private init() {
        // make sure to purge cache on memory pressure

        observer = NotificationCenter.default.addObserver(
            forName: UIApplication.didReceiveMemoryWarningNotification,
            object: nil,
            queue: nil
        ) { [weak self] notification in
            self?.cache.removeAllObjects()
        }
    }
    
    // MARK: - deinit
    
    deinit {
        NotificationCenter.default.removeObserver(observer!)
    }

    // MARK: - public func
    
    func image(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }

    func save(image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
}
