//
//  QualifyingResultManager.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/4/26.
//

import Foundation

struct QualifyingResultManager {
	static let shared = QualifyingResultManager()
	
	func retrieveQualifyingResults(year: String, round: Int) async -> [QualifyingResult]? {
		guard let response = await DataRequestManager.shared.fetchQualifyingResults(year: year, round: round) else {
			assertionFailure("fail to fetch Qualifying results")
			return nil
		}
		
		return response.race.results
	}
}

struct QualifyingResultResponse: Codable {
	var race: Qualifying
	
	enum CodingKeys: String, CodingKey {
		case race = "races"
	}
}

struct Qualifying: Codable {
	var results: [QualifyingResult]
	
	enum CodingKeys: String, CodingKey {
		case results = "qualyResults"
	}
}

struct QualifyingResult: Codable {
	var driverId: String
	var teamId: String
	var q1: String?
	var q2: String?
	var q3: String?
	var position: String
	var driver: DriverDetailInfo
	var team: ConstructorInfo
	
	enum CodingKeys: String, CodingKey {
		case position = "gridPosition"
		case driverId, teamId, q1, q2, q3, driver, team
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		
		if let stringValue = try? container.decode(String.self, forKey: .position) {
			self.position = stringValue
		} else if let intValue = try? container.decode(Int.self, forKey: .position) {
			self.position = "\(intValue)"
		} else {
			throw DecodingError.typeMismatch(String.self, DecodingError.Context(
				codingPath: container.codingPath,
				debugDescription: "Expected Int or String convertible to String for 'position'"
			))
		}
		
		self.driverId = try container.decode(String.self, forKey: .driverId)
		self.teamId = try container.decode(String.self, forKey: .teamId)
		self.q1 = try container.decodeIfPresent(String.self, forKey: .q1)
		self.q2 = try container.decodeIfPresent(String.self, forKey: .q2)
		self.q3 = try container.decodeIfPresent(String.self, forKey: .q3)
		self.driver = try container.decode(DriverDetailInfo.self, forKey: .driver)
		self.team = try container.decode(ConstructorInfo.self, forKey: .team)
	}
}
