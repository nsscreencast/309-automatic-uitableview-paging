//
//  PagedResponse.swift
//  BeerScroller
//
//  Created by Ben Scheirman on 10/25/17.
//  Copyright © 2017 NSScreencast. All rights reserved.
//

import Foundation

struct PagedResponse<T : Codable> : Codable {
    let currentPage: Int
    let numberOfPages: Int
    let totalResults: Int
    let data: [T]
}
