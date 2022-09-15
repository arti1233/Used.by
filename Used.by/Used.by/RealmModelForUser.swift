//
//  RealmModelForUser.swift
//  Used.by
//
//  Created by Artsiom Korenko on 6.09.22.
//

import Foundation
import RealmSwift
import UIKit
 
class UserRealmModel: Object {
    @Persisted(primaryKey: true) var id = 0
    @Persisted var userID: String = "" 
    @Persisted var isUserSingIn: Bool = false 
}
