//
//  SprintRaceManager.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/4/27.
//

import Foundation

struct SprintRaceResultManager {
	static let shared = SprintRaceResultManager()
	
	func retrieveSprintRaceResults(year: String, round: Int) async -> [SprintRaceResult]? {
		guard let response = await DataRequestManager.shared.fetchSprintRaceResults(year: year, round: round) else {
			assertionFailure("fail to fetch sprint race results")
			return nil
		}
		return response.race.results
	}
}

struct SprintRaceResponse: Codable {
	var race: SprintRace
	
	enum CodingKeys: String, CodingKey {
		case race = "races"
	}
}

struct SprintRace: Codable {
	var results: [SprintRaceResult]
	
	enum CodingKeys: String, CodingKey {
		case results = "sprintRaceResults"
	}
}

struct SprintRaceResult: Codable {
	var driverId: String
	var position: Int
	var teamId: String
	var gridPosition: Int
	var points: Int
	var driver: DriverDetailInfo
}
