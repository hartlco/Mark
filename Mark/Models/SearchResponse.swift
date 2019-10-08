//
//  Created by martin on 08.10.19.
//  Copyright © 2019 Martin Hartl. All rights reserved.
//

import Foundation

struct SearchResponse: Codable {
    struct Response: Codable {
        let venues: [Venue]
    }

    private let response: Response

    var venues: [Venue] {
        return response.venues
    }
}
