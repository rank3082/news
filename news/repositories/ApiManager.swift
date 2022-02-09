//
//  ApiManager.swift
//  news
//
//  Created by Ran Kellner on 09/02/2022.
//

import Foundation
import Alamofire

class ApiManager {
    static let shared = ApiManager()
    private init(){}
    
    
    func fetchArticles(onSuccess: @escaping ([Article]) -> Void, onError: @escaping (Error?) -> Void) {
        let serviceUrl = "https://newsapi.org/v2/everything?sources=engadget&from=2022-02-09&apiKey=53ff3e2d7adf4a5c839d10f58d0b420c&sortBy=publishedAt"
        sendRequest(serviceUrl: serviceUrl, onSuccess: { data in
            do {
                let decoder = JSONDecoder()
                let articlesResponse = try decoder.decode(ArticlesResponseModel.self, from: data)
                onSuccess(articlesResponse.articles)
            } catch {
                onError(error)
            }
        }, onError: { error in
            onError(error)
        })
    }
    
    private func sendRequest(serviceUrl: String, parameters: [String: String]? = nil,  onSuccess: @escaping (Data) -> Void, onError: @escaping (AFError?) -> Void ) {
        AF.request(serviceUrl, method: HTTPMethod.get, parameters: parameters, encoder: URLEncodedFormParameterEncoder.default).response(completionHandler: { response in
            if let error = response.error {
                onError(error)
                return
            }
            
            guard let data = response.data else {
                onError(nil)
                return
            }
            
            onSuccess(data)
        })
    }
}
