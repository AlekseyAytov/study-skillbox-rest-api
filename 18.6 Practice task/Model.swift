//
//  Model.swift
//  18.6 Practice task
//
//  Created by Alex Aytov on 4/26/23.
//

import Foundation

// network model
struct SearchResults: Codable {
    var searchType: String
    var expression: String
    var results: [SingleResult]
    var errorMessage: String
}

struct SingleResult: Codable {
    var id: String
    var resultType: String
    var image: String
    var title: String
    var description: String
}

// local model
struct ResultForDisplay {
    var title: String
    var description: String
    var image: String
    
    init(networkModel: SingleResult) {
        self.title = networkModel.title
        self.description = networkModel.description
        self.image = networkModel.image
    }
}
