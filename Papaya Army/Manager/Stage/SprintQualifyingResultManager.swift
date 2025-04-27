//
//  SprintQualifyingResultManager.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/4/27.
//

import Foundation

struct SprintQualifyingResultManager {
	static let shared = SprintQualifyingResultManager()
	
	func retrieveSprintQualifyingResult(year: String, round: Int) async -> [SprintQualifyingResult]? {
		guard let response = await DataRequestManager.shared.fetchSprintQualifyingResult(year: year, round: round) else {
			return nil
		}
		
		return response.race.results
	}
}

struct SprintQualifyingResultResponse: Codable {
	var race: SprintQualifying
	
	enum CodingKeys: String, CodingKey {
		case race = "races"
	}
}

struct SprintQualifying: Codable {
	var results: [SprintQualifyingResult]
	
	enum CodingKeys: String, CodingKey {
		case results = "sprintQualyResults"
	}
}

struct SprintQualifyingResult: Codable {
	var driverId: String
	var teamId: String
	var gridPosition: Int
	var sq1: String?
	var sq2: String?
	var sq3: String?
	var driver: DriverDetailInfo
}
