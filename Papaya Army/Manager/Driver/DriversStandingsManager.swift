//
//  CompetitorStandingsManager.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/4/11.
//

import Foundation

struct DriversStandingsManager {
	static let shared = DriversStandingsManager()
	
	func retrieveDriverStandings() async -> [DriversStanding]? {
		guard let response = await DataRequestManager.shared.fetchCurrentDriverStandings() else {
			assertionFailure("fetch driver standings failure")
			return nil
		}
		return response.driversStandings
	}
}

struct DriversStandingsReponse: Codable {
	var driversStandings: [DriversStanding]
	
	enum CodingKeys: String, CodingKey {
		case driversStandings = "drivers_championship"
	}
}

struct DriversStanding: Codable, Equatable {
	var driverId: String
	var teamId: String
	var points: Int
	var position: Int
	var wins: Int?
	var driverDetailInfo: DriverDetailInfo
	
	enum CodingKeys: String, CodingKey {
		case driverDetailInfo = "driver"
		case driverId, teamId, points, position, wins
	}
}

struct DriverDetailInfo: Codable, Equatable {
	var firstName: String
	var lastName: String
	var nationality: String
	var shortName: String
	var birthday: String
	var number: Int
	var url: String
	
	enum CodingKeys: String, CodingKey {
		case firstName = "name"
		case lastName = "surname"
		case nationality, shortName, number, url, birthday
	}
}
