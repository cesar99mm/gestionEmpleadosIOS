//
//  NetworkManager.swift
//  empresa
//
//  Created by APPS2T on 24/2/22.
//

import Foundation
import Alamofire

final class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    static var baseUrl = "https://pokeapi.co/api/v2/"
    
    // Endpoints
    var pokemonListUrl = NetworkManager.baseUrl + "pokemon/"
    var pokemonDetailUrl = NetworkManager.baseUrl + "detail/" // This is an example
    /*
    func getPokemonList(params: [String: Any]?, completion: @escaping (Response?) -> Void) {
        guard let url = URL(string: pokemonListUrl) else {
            completion(nil)
            return
        }
        
        var urlRequest = URLRequest(url: url, timeoutInterval: 10)
        
        if let params = params {
            guard let paramsData = try? JSONSerialization.data(withJSONObject: params, options: []) else {
                completion(nil)
                return
            }
            
            urlRequest.httpMethod = "POST"
            urlRequest.httpBody = paramsData
        }
        
        let headers = [
            "Content-Type": "application/json",
            "Accept":       "application/json"
        ]
        
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.httpAdditionalHeaders = headers
        
        let urlSession = URLSession(configuration: sessionConfiguration)
        
        let networkTask = urlSession.dataTask(with: urlRequest) {
            data, response, error in
            
            let httpResponse = response as! HTTPURLResponse
            
            print("HTTP Status code: \(httpResponse.statusCode)")
            
            guard error == nil else {
                completion(nil)
                return
            }
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(Response.self, from: data)
                completion(response)
            } catch {
                completion(nil)
            }
        }
        
        networkTask.resume()
    }*/
    
}

