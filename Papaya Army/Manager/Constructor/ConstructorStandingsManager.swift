//
//  ConstructorManager.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/4/5.
//

import Foundation

struct ConstructorStandingsManager {
	static let shared = ConstructorStandingsManager()

	func retrieveConstructorStandings() async -> [ConstructorStanding]? {
		guard let response = await DataRequestManager.shared.fetchCurrentConstructorStandings() else {
			assertionFailure("fail to fetch current constructor stadings")
			return nil
		}
		return response.constructorStandings
	}
}

struct ConstructorStandingsResopnse: Codable {
	var constructorStandings: [ConstructorStanding]

	enum CodingKeys: String, CodingKey {
		case constructorStandings = "constructors_championship"
	}
}

struct ConstructorStanding: Codable, Identifiable {
	var id = UUID()
	var isLiked = false
	var teamId: String
	var teamName: String {
		let parts = teamId.split(separator: "_")
		var ret = ""
		for part in parts {
			ret += part.capitalized + " "
		}
		return ret.trimmingCharacters(in: .whitespaces)
	}

	var points: Int
	var position: Int
	var wins: Int?

	enum CodingKeys: String, CodingKey {
		case teamId, points, position, wins
	}
}
