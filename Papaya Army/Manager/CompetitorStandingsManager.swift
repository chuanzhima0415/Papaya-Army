//
//  CompetitorStandingsManager.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/4/11.
//

import Foundation

struct CompetitorStandingsManager {
	static let shared = CompetitorStandingsManager()
	
	func retrieveCompetitorStandings(seasonId: String) async -> [Competitor]? {
		let competitorStandingsResponse = await DataRequestManager.shared.fetchCompetitorsStandings(seasonId: seasonId)
		return competitorStandingsResponse?.competitorStandings.competitors
	}
}

struct CompetitorStandingsResponse: Codable {
	var competitorStandings: CompetitorStandings
	
	enum CodingKeys: String, CodingKey {
		case competitorStandings = "stage"
	}
}

struct CompetitorStandings: Codable {
	var competitors: [Competitor]
}

struct Competitor: Codable {
	var competitorId: String /// 车手 id
	var name: String /// 车手名字
	var nationality: String /// 车手国籍
	var team: Constructor /// 所属车队
	var result: Result
	var driverName: String {
		let names = name.components(separatedBy: ", ")
		return names[1] + " " + names[0]
	}
	
	enum CodingKeys: String, CodingKey {
		case name, nationality, team, result
		case competitorId = "id"
	}
}

struct Result: Codable {
	var points: Int?
	var fastestLap: String?
	var laps: Int?
	var position: Int?
	var grid: Int?
	var pitStopCount: Int?
	var carNumber: Int
	var status: String?
	var time: String?
	var victories: Int?
	var races: Int?
	var racesWithPoints: Int?
	var polePositions: Int?
	var podiums: Int?
	var fastestLaps: Int?
	var victoryPoleAndFastestLap: Int?
	
	enum CodingKeys: String, CodingKey {
		case points, laps, position, grid, status, time, podiums, races, victories
		case fastestLap = "fastest_lap_time"
		case pitStopCount = "pitstop_count"
		case carNumber = "car_number"
		case racesWithPoints = "races_with_points"
		case polePositions = "polepositions"
		case victoryPoleAndFastestLap = "victory_pole_and_fastest_lap"
		case fastestLaps = "fastest_laps"
	}
}
