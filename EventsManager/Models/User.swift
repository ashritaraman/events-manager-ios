//
//  User.swift
//  EventsManager
//
//  Created by Ethan Hu on 5/18/18.
//
//

import Foundation

struct User: Codable {
    var netID: String
    var userID: String
    var googleIdToken: String
    var serverAuthToken: String?
    var name: String
    var avatar: URL
    var bookmarkedEvents: [Int]
    var followingOrganizations: [Int]
    var followingTags: [Int]

    private enum CodingKeys: String, CodingKey {
        case netID = "net_id"
        case userID = "user_id"
        case googleIdToken = "google_id_token"
        case serverAuthToken = "server_auth_token"
        case name = "name"
        case avatar = "avatar"
        case bookmarkedEvents = "bookmarked_events"
        case followingOrganizations = "following_organizations"
        case followingTags = "following_tags"
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(netID, forKey: .netID)
        try container.encode(userID, forKey: .userID)
        try container.encode(googleIdToken, forKey: .googleIdToken)
        try container.encode(serverAuthToken, forKey: .serverAuthToken)
        try container.encode(name, forKey: .name)
        try container.encode(avatar, forKey: .avatar)
        try container.encode(bookmarkedEvents, forKey: .bookmarkedEvents)
        try container.encode(followingOrganizations, forKey: .followingOrganizations)
        try container.encode(followingTags, forKey: .followingTags)
    }

}
