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
import RealmSwift


@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var realmServise: RealmServiceProtocol!
    var userDefaultsPassword = "password"
    var fireBase: FireBaseProtocol!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        realmServise = RealmService()
        FirebaseApp.configure()
        let userData = realmServise.getUserData()
        fireBase = FireBaseService()
        
        if let password = UserDefaults.standard.string(forKey: userDefaultsPassword), !password.isEmpty {
            changeUserAcount(userModel: userData)
        } else {
            UserDefaults.standard.set(userDefaultsPassword, forKey: userDefaultsPassword)
            GIDSignIn.sharedInstance.signOut()
            fireBase.signOutFirebase() { [weak self] result in
                guard let self = self else { return }
                if result {
                    self.realmServise.addUserData(isUserSignIn: false)
                    self.realmServise.addUserData(ID: "")
                    self.changeUserAcount(userModel: userData)
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
    
    func changeUserStatus(userId: String, isUserSignIn: Bool) {
        realmServise.addUserData(ID: userId)
        realmServise.addUserData(isUserSignIn: isUserSignIn)
    }
    
    func changeUserAcount(userModel: UserRealmModel) {
        var modelUser = userModel
        if let user = Auth.auth().currentUser {
          // User is signed in.
            changeUserStatus(userId: user.uid, isUserSignIn: true)
            modelUser = realmServise.getUserData()
            print("чел авторизован Firebase")
        } else {
          // No user is signed in.
            changeUserStatus(userId: "", isUserSignIn: false)
            modelUser = realmServise.getUserData()
            print("чел не авторизован Firebase")
        }
        
        if modelUser.isUserSingIn == false {
            GIDSignIn.sharedInstance.restorePreviousSignIn { [weak self] user, error in
                guard let self = self else { return }
                if error != nil || user == nil {
                    self.changeUserStatus(userId: "", isUserSignIn: false)
                    print("чел не авторизован Google")
                } else {
                    guard let userId = user?.userID else { return }
                    self.changeUserStatus(userId: userId, isUserSignIn: true)
                    print("чел авторизован Google")
                }
            }
        }
    }
}

