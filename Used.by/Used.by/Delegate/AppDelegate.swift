//
//  AppDelegate.swift
//  Used.by
//
//  Created by Artsiom Korenko on 9.08.22.
//

import UIKit
import GoogleSignIn
import GoogleSignInSwift
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth


@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var realmServise: RealmServiceProtocol!


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        realmServise = RealmService()
        FirebaseApp.configure()
        let userFirebase = Auth.auth().currentUser
        var userData = realmServise.getUserData()
        
        if realmServise.getUsersRealmModel().first == nil {
            realmServise.resertUserData()
        }
        
        if let user = userFirebase {
          // User is signed in.
            realmServise.addUserData(ID: user.uid)
            realmServise.addUserData(isAuthFirebase: true)
            realmServise.addUserData(isUserSignIn: true)
            userData = realmServise.getUserData()
            print("чел авторизован Firebase")
        } else {
          // No user is signed in.
            realmServise.addUserData(ID: "")
            realmServise.addUserData(isAuthFirebase: false)
            realmServise.addUserData(isUserSignIn: false)
            userData = realmServise.getUserData()
            print("чел не авторизован Firebase")
        }
        
        if userData.isUserSingIn == false {
            GIDSignIn.sharedInstance.restorePreviousSignIn { [weak self] user, error in
                guard let self = self else { return }
                if error != nil || user == nil {
                    self.realmServise.addUserData(ID: "")
                    self.realmServise.addUserData(isAuthFirebase: false)
                    self.realmServise.addUserData(isUserSignIn: false)
                    print("чел не авторизован Google")
                } else {
                    guard let userId = user?.userID else { return }
                    self.realmServise.addUserData(ID: userId)
                    self.realmServise.addUserData(isAuthFirebase: true)
                    self.realmServise.addUserData(isUserSignIn: true)
                    print("чел авторизован Google")
                }
            }
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }
}

