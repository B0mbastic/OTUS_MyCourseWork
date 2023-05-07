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
}

final class NetworkServiceImp {
    private var completion: ((Result<URL, NetworkError>) -> Void)?
    private var progressCompletion: ((Float) -> Void)?
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
                completionOnMainThread(.failure(.custom(reason: error.localizedDescription)))
                return
            }
            guard
                let response = response as? HTTPURLResponse,
                response.statusCode > 200 || response.statusCode <= 300,
                let data = data
            else {
                completionOnMainThread(.failure(.server))
                return
            }
            completionOnMainThread(.success(data))
        }.resume()
    }
}

