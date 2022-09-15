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
    
    func getUserInfo(id: String, completion: @escaping(Result<Users, Error>) -> Void)
    func getCarBrendInfo(completion: @escaping(Result<[CarBrend], Error>) -> Void)
    func getAllAdsId(completion: @escaping(Result<AllAdsId, Error>) -> Void)
    func getAdsInfo(id: String, completion: @escaping(Result<AdsInfo, Error>) -> Void)
    func getUserAds(id: String, completion: @escaping (Result<UsersAds, Error>) -> Void)
    func getSaveUserAds(id: String, completion: @escaping (Result<UsersSaveAds, Error>) -> Void)
    
}

class AlamofireProvider: RestAPIProviderProtocol {
    
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
    
    func getUserAds(id: String, completion: @escaping (Result<UsersAds, Error>) -> Void) {
        AF.request(Constants.getUserInfoURl.appending("\(id).json"), method: .get).responseDecodable(of: UsersAds.self) { response in
            switch response.result {
            case .success(let result):
                return completion(.success(result))
            case .failure(let error):
                return completion(.failure(error))
            }
        }
    }
    
    func getSaveUserAds(id: String, completion: @escaping (Result<UsersSaveAds, Error>) -> Void) {
        AF.request(Constants.getUserInfoURl.appending("\(id).json"), method: .get).responseDecodable(of: UsersSaveAds.self) { response in
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
    
    func getAllAdsId(completion: @escaping(Result<AllAdsId, Error>) -> Void) {
        AF.request(Constants.allAdsID, method: .get).responseDecodable(of: AllAdsId.self) { response in
            switch response.result {
            case .success(let result):
                return completion(.success(result))
            case .failure(let error):
                return completion(.failure(error))
            }
        }
    }
    
    func getAdsInfo(id: String, completion: @escaping (Result<AdsInfo, Error>) -> Void) {
        AF.request(Constants.getInfoAds.appending("\(id).json"), method: .get).responseDecodable(of: AdsInfo.self) { response in
            switch response.result {
            case .success(let result):
                return completion(.success(result))
            case .failure(let error):
                return completion(.failure(error))
            }
        }
    }
    
}


