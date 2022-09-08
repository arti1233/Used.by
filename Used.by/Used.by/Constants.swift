//
//  Constants.swift
//  Used.by
//
//  Created by Artsiom Korenko on 19.08.22.
//

import Foundation

struct Constants {
        
    static var baseURL = "https://used-by-64d67-default-rtdb.firebaseio.com/"
    static var carBrendURl = "https://used-by-64d67.firebaseio.com/carBrend.json"
    static var allAdsID = "https://used-by-64d67-4879b.firebaseio.com/.json"
    static var getInfoAds = "https://used-by-64d67-17a16.firebaseio.com/ads/"
    
    static var getAllUserInfoURl: String {
        return baseURL.appending("user.json")
    }
    
    static var getUserInfoURl: String {
        return baseURL.appending("users/")
    }
    
}
