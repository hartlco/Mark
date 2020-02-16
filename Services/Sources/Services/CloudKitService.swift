//
//  CloudKitService.swift
//  Services
//
//  Created by martin on 15.10.19.
//  Copyright © 2019 Martin Hartl. All rights reserved.
//

import Foundation
import CloudKit

@available(iOS 13.0, watchOS 6.0, *)
final public  class CloudKitService {
    public init() { }

    public func save(token: String) {
        let tokenRecord = CKRecord(recordType: "Token")
        tokenRecord["token"] = token as CKRecordValue

        CKContainer(identifier: "iCloud.Mark").privateCloudDatabase.save(tokenRecord) { record, error in
            if let error = error {
                print("CloudKit save error: \(error.localizedDescription)")
            }
        }
    }

    public func getToken(completion: @escaping (String?) -> Void) {
        let database = CKContainer(identifier: "iCloud.Mark").privateCloudDatabase

        let query = CKQuery(recordType: "Token", predicate: NSPredicate(value: true))
        query.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]

        database.perform(query, inZoneWith: nil) { records, error in
            guard let record = records?.last, error == nil,
                let token = record["token"] as? String else {
                completion(nil)
                return
            }

            completion(token)
        }
    }
}
