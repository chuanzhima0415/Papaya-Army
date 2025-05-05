//
//  RaceResultManager.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/4/26.
//

import Foundation

struct RaceResultManager {
	static let shared = RaceResultManager()
	
	func retrieveCertainRaceResult(year: String, round: Int) async -> [RaceResult]? {
		guard let response = await DataRequestManager.shared.fetchSpecificRaceResult(year: year, round: round) else {
			assertionFailure("fetch current GrandPrix schedules error!")
			return nil
		}
		
		return response.race?.results
	}
}

struct RaceResultResponse: Codable {
	var race: Race?
	var status: Int?
	
	enum CodingKeys: String, CodingKey {
		case race = "races", status
	}
}

struct Race: Codable {
	var results: [RaceResult]
}

struct RaceResult: Codable {
	var position: String
	var points: Int
	var time: String
	var driver: DriverDetailInfo
	var team: ConstructorInfo
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		
		if let intValue = try? container.decode(Int.self, forKey: .position) {
			self.position = "\(intValue)"
		} else if let stringValue = try? container.decode(String.self, forKey: .position) {
			self.position = stringValue
		} else {
			throw DecodingError.typeMismatch(String.self, DecodingError.Context(
				codingPath: container.codingPath,
				debugDescription: "Expected Int or String convertible to String for 'position'"
			))
		}
		
		
		self.points = try container.decode(Int.self, forKey: .points)
		self.time = try container.decode(String.self, forKey: .time)
		self.driver = try container.decode(DriverDetailInfo.self, forKey: .driver)
		self.team = try container.decode(ConstructorInfo.self, forKey: .team)
	}
}
