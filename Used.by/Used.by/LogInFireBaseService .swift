//
//  LogInFireBaseService .swift
//  Used.by
//
//  Created by Artsiom Korenko on 17.08.22.
//

import Foundation
import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import Firebase
import FirebaseDatabaseSwift
import FirebaseDatabase
import FirebaseStorage

protocol FireBaseProtocol {
    
// create new user in firebase
    func createNewUser(email: String, password: String, name: String, completion: @escaping(Bool, String) -> Void)
    
// add new user with google
    func addNewUserForGoogle(name: String, email: String, userIdGoogle: String)
    
// Create new ads
    func createNewAds(userId: String, carBrend: String, carModel: String, year: Int, typeEngine: Int, gearBox: Int, typeDrive: Int, capacity: Double, mileage: Int, cost: Int, description: String, photo: [UIImage], phoneNumber: Int, condition: Int)
    
// Upload photo cars in ads
    func uploadPhoto(photo: UIImage, comletion: @escaping(Result<URL, Error>) -> Void)
    
// Add adsId in user profile
    func addAdsIdInUsers(userId: String, adsId: String)
    
// Sign In firebase
    func signInFireBase(email: String, password: String, completion: @escaping (Bool, String) -> Void)
    
// Sign Out firebase
    func signOutFirebase(completion: @escaping (Bool) -> Void)
// Add favorite adsId in base
    func addSaveUserAds(userId: String, adsId: String, complition: @escaping(Bool) -> Void)
    
    func chekSaveAdsOrNot(userId: String, adsId: String, complition: @escaping(Bool) -> Void)
    
    func deletUserAds(userId: String, adsId: String)
}

class FireBaseService: FireBaseProtocol {
   
    let referenceUsers = Database.database().reference().child("used").child("users").child("users")
    let refAds = Database.database().reference().child("used").child("adsInfo").child("ads")
    let refID = Database.database().reference().child("used").child("adsID")
    
    let storage = Storage.storage().reference().child("pic")
    
    func signOutFirebase(completion: @escaping (Bool) -> Void) {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            completion(true)
        } catch _ as NSError {
            completion(false)
        }
    }
    
    func addNewUserForGoogle(name: String, email: String, userIdGoogle: String) {
        referenceUsers.child(userIdGoogle).updateChildValues(["name" : name, "email": email, "ads": []])
    }
    
    func deletUserAds(userId: String, adsId: String) {
        referenceUsers.child(userId).observeSingleEvent(of: .value) { [weak self] snapshot in
            guard let self = self else { return }
            if !snapshot.exists() { return }
            if let dict = snapshot.value as? Dictionary<String, AnyObject>, var arrayAdsId = dict["adsId"] as? [String] {
                arrayAdsId = arrayAdsId.filter({$0 != adsId})
                self.referenceUsers.child(userId).child("adsId").setValue(arrayAdsId)
            } else {
                self.referenceUsers.child(userId).child("adsId").setValue([])
            }
        }
        
        refID.observeSingleEvent(of: .value) { [weak self] snapshot in
            guard let self = self else { return }
            if !snapshot.exists() { return }
              if let dict = snapshot.value as? Dictionary<String, AnyObject>,
                 var posts = dict["ID"] as? [String] {
                  posts = posts.filter({$0 != adsId})
                  self.refID.child("ID").setValue(posts)
              } else {
                  self.refID.child("ID").setValue([])
              }
        }
        refAds.child(adsId).removeValue()
    }
    
    
    func addAdsIdInUsers(userId: String, adsId: String) {
        referenceUsers.child(userId).observeSingleEvent(of: .value) { snapshot in
            if !snapshot.exists() { return }
            if let dict = snapshot.value as? Dictionary<String, AnyObject>, var arrayAdsId = dict["adsId"] as? [String] {
                arrayAdsId.append(adsId)
                self.referenceUsers.child(userId).child("adsId").setValue(arrayAdsId)
            } else {
                self.referenceUsers.child(userId).child("adsId").setValue([adsId])
            }
        }
    }
    
    func signInFireBase(email: String, password: String, completion: @escaping (Bool, String) -> Void) {
        var userId = ""
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if error != nil {
                completion(false, userId)
            } else if let result = authResult {
                userId = result.user.uid
                completion(true, userId)
            }
        }
    }
   
    func createNewUser(email: String, password: String, name: String, completion: @escaping(Bool, String) -> Void) {
        var userId = ""
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let self = self, error == nil, let result = result else {
                completion(false, userId)
                return
            }
            self.referenceUsers.child(result.user.uid).updateChildValues(["name" : name, "email": email, "ads": [], "saveAds" : []])
            userId = result.user.uid
            completion(true, userId)
        }
    }
    
    
    func createNewAds(userId: String, carBrend: String, carModel: String, year: Int, typeEngine: Int, gearBox: Int, typeDrive: Int, capacity: Double, mileage: Int, cost: Int, description: String, photo: [UIImage], phoneNumber: Int, condition: Int) {
        guard let adsId = refAds.childByAutoId().key else { return }
        var arrayUrl: [URL] = []
        for image in photo {
            uploadPhoto(photo: image) { (result) in
                switch result {
                case .success(let url):
                    arrayUrl.append(url)
                    self.refAds.child(adsId).child("photo").setValue(arrayUrl.map({$0.description}))
                case .failure:
                    print("No ok photo")
                }
            }
        }
        
            let stringUrl = arrayUrl.map({$0.description})
            apendNewIdInBase(id: adsId)
            refAds.child(adsId).updateChildValues(["id": adsId,
                                           "carBrend": carBrend,
                                           "carModel": carModel,
                                           "year": year,
                                           "typeEngine": typeEngine,
                                           "gearBox": gearBox,
                                           "typeDrive": typeDrive,
                                           "capacity": capacity,
                                           "mileage": mileage,
                                           "photo": stringUrl,
                                           "cost": cost,
                                           "description": description,
                                           "phoneNumber": phoneNumber,
                                           "condition": condition])
            addAdsIdInUsers(userId: userId, adsId: adsId)
    }
    
    func apendNewIdInBase(id: String) {
        refID.observeSingleEvent(of: .value) { [weak self] snapshot in
            guard let self = self else { return }
            if !snapshot.exists() { return }
              if let dict = snapshot.value as? Dictionary<String, AnyObject>,
                 var posts = dict["ID"] as? [String] {
                 posts.append(id)
                  self.refID.child("ID").setValue(posts)
              } else {
                  self.refID.child("ID").setValue([id])
              }
        }
    }
    
    func addSaveUserAds(userId: String, adsId: String, complition: @escaping(Bool) -> Void) {
        referenceUsers.child(userId).observeSingleEvent(of: .value) { snapshot in
            var result = true
            var arrayAds: [String] = []
            if !snapshot.exists() { return }
            if let dict = snapshot.value as? Dictionary<String, AnyObject>, let arrayAdsId = dict["saveAds"] as? [String] {
                arrayAdsId.forEach({
                    if $0 == adsId {
                        result = false
                    } else {
                        arrayAds.append($0)
                    }
                })
                if result {
                    arrayAds.append(adsId)
                }
                self.referenceUsers.child(userId).child("saveAds").setValue(arrayAds)
            } else {
                self.referenceUsers.child(userId).child("saveAds").setValue([adsId])
            }
            complition(result)
        }
    }
    
    func chekSaveAdsOrNot(userId: String, adsId: String, complition: @escaping(Bool) -> Void) {
        referenceUsers.child(userId).observeSingleEvent(of: .value) { snapshot in
            var result = false
            if !snapshot.exists() { return }
            if let dict = snapshot.value as? Dictionary<String, AnyObject>, let arrayAdsId = dict["saveAds"] as? [String] {
                arrayAdsId.forEach({
                    if $0 == adsId {
                       result = true
                    }
                })
            }
            complition(result)
        }
    }
    
    func uploadPhoto(photo: UIImage, comletion: @escaping(Result<URL, Error>) -> Void) {
       guard let randomPhotoName = refAds.childByAutoId().key,
             let imageData = photo.jpegData(compressionQuality: 0.5) else { return }
        
        let ref = storage.child(randomPhotoName)
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        ref.putData(imageData, metadata: metadata) { (metadata, error) in
            guard metadata != nil else {
                comletion(.failure(error!))
                return
            }
            
            ref.downloadURL { (url, error) in
                guard let url = url else {
                    comletion(.failure(error!))
                    return
                }
                comletion(.success(url))
            }
        }
    }
}


