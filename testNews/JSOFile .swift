//
//  JSOFile .swift
//  testNews
//
//  Created by Malygin Georgii on 29.10.2020.
//

import Foundation

struct JSONFile: Codable, Hashable {
    let data: DataItem?
    let result: String?
}

struct DataItem: Codable, Hashable {
    let id: Int?
    let title: String?
    let created_at: Int?
    let updated_at: Int?
    let deleted_at: Int?
    let level: Int?
    let distance: String?
    let duration: String?
    let images: [String?]
    let city_id: Int?
    let type: String?
//    let angle: String?
    let cost: String?
    let contacts: String?
    let status: String?
 //   let direction: [[Double]]
    let subtype_id: Int?
    let admin_id: Int?
    let tourism_type_id: Int?
    let city: SityData?
    let tags: [String?]
    let entity: String?
    let annotation: String?
    let additions: [String?]
    let rating: Double?
    let currentUserRating: String?
    let countRating: Double?
    let agency: Agency?
    let guide: String?
    let link: String?
    let favorited: Bool?
    let schedules: [String?]
}

struct SityData: Codable, Hashable {
    let id: Int?
    let title: String?
    let slug: String?
    let description: String?
    let latitude: String?
    let longitude: String?
    let created_at: Int?
    let updated_at: Int?
    let deleted_at: String?
    let image: String?
    let zoom: Int?
    let sort: Int?
    let entity: String?
    let name: String?
    let location: [Double?]
    let placesCount: Int?
    let tripsCount: Int?
    let excursionsCount: Int?
}

struct Agency: Codable, Hashable {
    let id: Int?
    let title: String?
    let city_id: Int?
    let mode: String?
    let phone: String?
    let description: String?
    let created_at: Int?
    let updated_at: Int?
    let deleted_at: String?
    let images: [String?]
    let latitude: String?
    let longitude: String?
    let user_id: String?
    let status: String?
    let provider_id: String?
    let website: String?
    let email: String?
    let logo: String?
    let type: String?
    let pivot: Pivot?
    let entity: String?
    let annotation: String?
    let additions: [String?]
    let rating: Int?
    let currentUserRating: String?
    let countRating: Int?
    let location: [Double?]
}

struct Pivot: Codable, Hashable {
    let trip_id: Int?
    let agency_id: Int?
}
