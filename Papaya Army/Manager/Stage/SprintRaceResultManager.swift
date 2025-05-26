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
		return response.race?.results
	}
}

struct SprintRaceResponse: Codable {
	var race: SprintRace?
	var status: Int?

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
	var position: String
	var teamId: String
	var gridPosition: Int
	var points: Int
	var driver: DriverDetailInfo

	init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.driverId = try container.decode(String.self, forKey: .driverId)

		if let stringValue = try? container.decodeIfPresent(String.self, forKey: .position) {
			self.position = stringValue
		} else if let intValue = try? container.decodeIfPresent(Int.self, forKey: .position) {
			self.position = "\(intValue)"
		} else {
			throw DecodingError.dataCorruptedError(forKey: .position, in: container, debugDescription: "Position should be Int or String convertible to String")
		}

		self.teamId = try container.decode(String.self, forKey: .teamId)
		self.gridPosition = try container.decode(Int.self, forKey: .gridPosition)
		self.points = try container.decode(Int.self, forKey: .points)
		self.driver = try container.decode(DriverDetailInfo.self, forKey: .driver)
	}
}
