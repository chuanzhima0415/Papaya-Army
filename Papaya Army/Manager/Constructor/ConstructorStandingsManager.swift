//
//  ConstructorManager.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/4/5.
//

import Foundation

struct ConstructorColor {
	static let mercedes = (0, 210, 190)
	static let ferrari = (220, 0, 0)
	static let red_bull = (252, 215, 0)
	static let mclaren = (255, 135, 0)
	static let alpine = (254, 134, 188)
	static let aston_martin = (0, 111, 98)
	static let sauber = (0, 231, 1)
	static let visa_rb = (22, 52, 203)
	static let haas = (255, 255, 255)
	static let williams = (0, 160, 221)
}

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

struct ConstructorStanding: Codable {
	var teamId: String
	var teamName: String {
		let parts = teamId.split(separator: "_")
		var ret = ""
		for part in parts {
			ret += part.capitalized + " "
		}
		return ret
	}
	var points: Int
	var position: Int
	var wins: Int?
}
