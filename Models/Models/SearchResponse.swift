//
//  Created by martin on 08.10.19.
//  Copyright © 2019 Martin Hartl. All rights reserved.
//

import Foundation

public struct SearchResponse: Codable {
    public struct Response: Codable {
        public let venues: [Venue]
    }

    private let response: Response

    public var venues: [Venue] {
        return response.venues
    }
}
