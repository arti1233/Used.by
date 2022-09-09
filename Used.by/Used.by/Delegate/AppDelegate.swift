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
            changeUserStatus(userId: user.uid, isAuthFirebase: true, isUserSignIn: true)
            userData = realmServise.getUserData()
            print("чел авторизован Firebase")
        } else {
          // No user is signed in.
            changeUserStatus(userId: "", isAuthFirebase: false, isUserSignIn: false)
            userData = realmServise.getUserData()
            print("чел не авторизован Firebase")
        }
        
        if userData.isUserSingIn == false {
            GIDSignIn.sharedInstance.restorePreviousSignIn { [weak self] user, error in
                guard let self = self else { return }
                if error != nil || user == nil {
                    self.changeUserStatus(userId: "", isAuthFirebase: false, isUserSignIn: false)
                    print("чел не авторизован Google")
                } else {
                    guard let userId = user?.userID else { return }
                    self.changeUserStatus(userId: userId, isAuthFirebase: true, isUserSignIn: true)
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
    
    func changeUserStatus(userId: String, isAuthFirebase: Bool, isUserSignIn: Bool) {
        realmServise.addUserData(ID: userId)
        realmServise.addUserData(isAuthFirebase: isAuthFirebase)
        realmServise.addUserData(isUserSignIn: isUserSignIn)
    }
}

