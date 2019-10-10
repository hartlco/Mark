//
//  LastCheckInsResponse.swift
//  Models
//
//  Created by martin on 12.10.19.
//  Copyright © 2019 Martin Hartl. All rights reserved.
//

import Foundation

public struct LastCheckInsResponse: Codable {
    struct Checkins: Codable {
        let items: [Item]
    }

    struct Response: Codable {
        let checkins: Checkins
    }

    struct Item: Codable {
        let id: String
        let venue: Venue?
    }

    let response: Response

    public var venues: [Venue] {
        return response.checkins.items.compactMap {
            return $0.venue
        }
    }
}
