//
//  MoviewSearchResponseModel.swift
//  MovieRateApp
//
//  Created by yangjs on 2023/03/27.
//

import Foundation
struct MovieSearchResponseModel: Decodable {
    var items: [Movie] = []
}
