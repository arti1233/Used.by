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

protocol FireBaseProtocol {
    func createNewUser(email: String, password: String, name: String) -> Bool
    
    func addNewUserForGoogle(name: String, email: String, userId: String)
}

class FiriBaseService: FireBaseProtocol {
   
    let reference = Database.database().reference().child("users")
    
    func addNewUserForGoogle(name: String, email: String, userId: String) {
        reference.child(userId).updateChildValues(["name" : name, "email": email])
    }
    
   
    func createNewUser(email: String, password: String, name: String) -> Bool {
        var resultCreateUser = Bool()
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let self = self, error == nil, let result = result else {
                resultCreateUser = false
                return }
            self.reference.child(result.user.uid).updateChildValues(["name" : name, "email": result.user.email])
            resultCreateUser = true
        }
        return resultCreateUser
    }
    

}

