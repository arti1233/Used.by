//
//  GoogleServise.swift
//  Used.by
//
//  Created by Artsiom Korenko on 17.08.22.
//

import Foundation
import UIKit
import SnapKit
import GoogleSignInSwift
import GoogleSignIn

protocol GoogleServiseProtocol {
    func authWithGoogle(presenting: UIViewController) -> GIDGoogleUser?
}

class GoogleServise: GoogleServiseProtocol {
    
    let signInConfig = GIDConfiguration(clientID: "110530291494-utjaq1tejih8qaknoj6jl72cngtbbeh8.apps.googleusercontent.com")
    
    func authWithGoogle(presenting: UIViewController) ->  GIDGoogleUser? {
        var userInfo: GIDGoogleUser?
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: UIViewController()) { user, error in
            guard error == nil else { return userInfo = nil }
            userInfo = user
        }
        return userInfo
    }
}

