//
//  RealmUtilis.swift
//  SlTest
//
//  Created by Mohamed Marouane YOUSSEF on 22/10/2017.
//  Copyright © 2017 Mohamed Marouane YOUSSEF. All rights reserved.
//

import Foundation
import RealmSwift

struct RealmUtils {
    
    static fileprivate var realmConfiguration: Realm.Configuration?
    
    static func getRealmConfiguration() -> Realm.Configuration {
        
        if let realmConfig = realmConfiguration {
            return realmConfig
        } else {
            var config = Realm.Configuration()
            config.deleteRealmIfMigrationNeeded = true
            // Use the default directory, but replace the filename with the username
            config.fileURL = config.fileURL!.deletingLastPathComponent()
                .appendingPathComponent("ff.realm")
            // Setting schema version
            config.schemaVersion = 3
            // Defining ObjectTypes
            config.objectTypes = [Favorite.self]

            realmConfiguration = config
            return realmConfiguration!
        }
    }
}
class favManager {
    func saveFav() {
    let realm = try! Realm(configuration: RealmUtils.getRealmConfiguration())
        try! realm.write {
            
        }
    }
    
    func fetchFav() {
       let realm = try! Realm(configuration: RealmUtils.getRealmConfiguration())
        let _ = realm.objects(Favorite.self)
    }
}
class Favorite : Object {
    dynamic open var date : Date = Date()
    dynamic open var ref : String = ""
    override open static func primaryKey() -> String? {
        return "ref"
    }
}
