//
//  ImageDownloader.swift
//  MultiImageDownloadingDemo
//
//  Created by Yiyin Shen on 29/4/19.
//  Copyright © 2019 Sylvia. All rights reserved.
//

import Foundation
import UIKit

class ImageDownloader {
    static let sharedInstance = ImageDownloader()
    private init() {}

    private var inMemoryImages: [String: UIImage] = [:]
    private var operations: [String: BlockOperation] = [:]
    private var downloadOperationQueue: OperationQueue = OperationQueue()

    func fetchImageFor(urlString: String, completionHandler: @escaping (UIImage?, Error?) -> Void ) {
        // if image exists in memory, grab from memory
        if let image = inMemoryImages[urlString] {
            DispatchQueue.main.async {
                completionHandler(image, nil)
                print("fetched from imageMemory \(urlString)")
            }
        } else {
            // not in memory, try fetch from sand box first
            guard let url = URL(string: urlString) else { return }

            // url.query is just for the specific dummy data in demo, it should be url.lastPathComponent
            let filePath = getDocumentsDirectory().appendingPathComponent(url.query ?? "")
            if let data = NSData(contentsOf: filePath), let image = UIImage(data: data as Data) {
                print("fetched from sandbox")
                inMemoryImages[urlString] = image
                DispatchQueue.main.async {
                    completionHandler(image, nil)
                }
            }
            // not in sandbox -> download
            else {
                print("started downloading \(urlString)")
                if operations[urlString] == nil {
                    let operation = BlockOperation {
                        if let url = URL(string: urlString) {
                            let task = URLSession.shared.dataTask(with: URLRequest(url: url),
                                                                  completionHandler: { (data, response, error) in
                                if let data = data {

                                    let image = UIImage(data: data)
                                    self.inMemoryImages[urlString] = image
                                    do {
                                        try data.write(to: filePath)
                                        print("saved image to sandbox")
                                    } catch {
                                        print("failed to write image to sandbox")
                                    }

                                    DispatchQueue.main.async {
                                        completionHandler(image, nil)
                                    }
                                } else if let error = error {
                                    DispatchQueue.main.async {
                                        completionHandler(nil, error)
                                    }
                                }
                            })
                            task.resume()
                        } else {
                            print("invalida url")
                        }
                    }

                    operations[urlString] = operation
                    downloadOperationQueue.addOperation(operation)
                }
            }
        }
    }

    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        return paths[0]
    }
}
