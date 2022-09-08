//
//  AlamofireProvider.swift
//  Used.by
//
//  Created by Artsiom Korenko on 19.08.22.
//

import Foundation
import Alamofire
import UIKit

protocol RestAPIProviderProtocol {
    
    func getAllUsersInfo(completion: @escaping(Result<[Users], Error>) -> Void)
    func getUserInfo(id: String, completion: @escaping(Result<Users, Error>) -> Void)
    func getCarBrendInfo(completion: @escaping(Result<[CarBrend], Error>) -> Void)
}

class AlamofireProvider: RestAPIProviderProtocol {
    
    func getAllUsersInfo(completion: @escaping (Result<[Users], Error>) -> Void) {
        AF.request(Constants.getAllUserInfoURl, method: .get).responseDecodable(of: [Users].self) { response in
            switch response.result {
            case .success(let result):
                return completion(.success(result))
            case .failure(let error):
                return completion(.failure(error))
            }
        }
    }
    
    func getUserInfo(id: String, completion: @escaping (Result<Users, Error>) -> Void) {
        AF.request(Constants.getUserInfoURl.appending("\(id).json"), method: .get).responseDecodable(of: Users.self) { response in
            switch response.result {
            case .success(let result):
                return completion(.success(result))
            case .failure(let error):
                return completion(.failure(error))
            }
        }
    }
    
    func getCarBrendInfo(completion: @escaping (Result<[CarBrend], Error>) -> Void) {
        AF.request(Constants.carBrendURl, method: .get).responseDecodable(of: [CarBrend].self) { response in
            switch response.result {
            case .success(let result):
                return completion(.success(result))
            case .failure(let error):
                return completion(.failure(error))
            }
        }
    }
}


