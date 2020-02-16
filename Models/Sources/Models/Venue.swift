//
//  Created by martin on 08.10.19.
//  Copyright © 2019 Martin Hartl. All rights reserved.
//

import Foundation

public struct Venue: Codable, Identifiable {
    public struct Location: Codable {
        public let  address: String?

        public init(address: String) {
            self.address = address
        }
    }

    public init(name: String,
                id: String,
                location: Location) {
        self.name = name
        self.id = id
        self.location = location
    }

    public let name: String
    public let id: String
    public let location: Location
}
