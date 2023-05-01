//
//  NetworkService.swift
//  OTUS_MyCourseWork
//
//  Created by Александр Ковбасин on 01.05.2023.
//

import Foundation

enum NetworkError: Error {
    case cancelled
    case custom(reason: String)
    case server
    case parse(description: String)
    case unknown
}

protocol NetworkService: AnyObject {
    func request(
        url: URLRequest,
        completion: @escaping (Result<Data, NetworkError>) -> Void
    )
//    func requestWithDownloadTask(
//        url: URLRequest,
//        completion: @escaping (Result<URL, NetworkError>) -> Void
//    )
//    func requestWithDownloadTask2(
//        url: URLRequest,
//        completion: @escaping (Result<URL, NetworkError>) -> Void,
//        progressCompletion: @escaping (Float) -> Void
//    )
}

final class NetworkServiceImp {
    
//    private var completion: ((Result<URL, NetworkError>) -> Void)?
//    private var progressCompletion: ((Float) -> Void)?
//
//    private lazy var session = URLSession(
//        configuration: .default,
//        delegate: self,
//        delegateQueue: nil
//    )
}

extension NetworkServiceImp: NetworkService {
    
    func request(
        url: URLRequest,
        completion: @escaping (Result<Data, NetworkError>) -> Void
    ) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            let completionOnMainThread: (Result<Data, NetworkError>) -> Void = { result in
                DispatchQueue.main.async {
                    completion(result)
                }
            }
            
            if let error {
                print("🛑", #function, error)
                completionOnMainThread(.failure(.custom(reason: error.localizedDescription)))
                return
            }
            
            guard
                let response = response as? HTTPURLResponse,
                response.statusCode > 200 || response.statusCode <= 300,
                let data = data
            else {
                print("🛑", #function)
                completionOnMainThread(.failure(.server))
                return
            }
            
            print("✅", #function, data)
            completionOnMainThread(.success(data))
        }.resume()
    }
    
//    func requestWithDownloadTask(
//        url: URLRequest,
//        completion: @escaping (Result<URL, NetworkError>) -> Void
//    ) {
//        URLSession.shared.downloadTask(with: url) { url, response, error in
//            let completionOnMainThread: (Result<URL, NetworkError>) -> Void = { result in
//                DispatchQueue.main.async {
//                    completion(result)
//                }
//            }
//            
//            if let error {
//                print("🛑", #function, error)
//                completionOnMainThread(.failure(.custom(reason: error.localizedDescription)))
//                return
//            }
//            
//            guard
//                let response = response as? HTTPURLResponse,
//                response.statusCode > 200 || response.statusCode <= 300,
//                let url = url
//            else {
//                print("🛑", #function)
//                completionOnMainThread(.failure(.server))
//                return
//            }
//            
//            print("✅", #function, url)
//            completionOnMainThread(.success(url))
//        }.resume()
//    }
//    
//    func requestWithDownloadTask2(
//        url: URLRequest,
//        completion: @escaping (Result<URL, NetworkError>) -> Void,
//        progressCompletion: @escaping (Float) -> Void
//    ) {
//        let task = self.session.downloadTask(with: url)
//        self.completion = completion
//        self.progressCompletion = progressCompletion
//        task.resume()
//    }
//}
//
//extension NetworkServiceImp: URLSessionDownloadDelegate {
//    
//    func urlSession(
//        _ session: URLSession,
//        downloadTask: URLSessionDownloadTask,
//        didFinishDownloadingTo location: URL
//    ) {
//        print("🍏", location)
//        DispatchQueue.main.async {
//            self.completion?(.success(location))
//        }
//    }
//    
//    func urlSession(
//        _ session: URLSession,
//        downloadTask: URLSessionDownloadTask,
//        didWriteData bytesWritten: Int64,
//        totalBytesWritten: Int64,
//        totalBytesExpectedToWrite: Int64
//    ) {
//        let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
//        print("🍎", totalBytesWritten, totalBytesExpectedToWrite, progress)
//        DispatchQueue.main.async {
//            self.progressCompletion?(progress)
//        }
//    }
//    
//    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
//        print("🍋", error)
//    }
}

