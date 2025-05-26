//
//  RaceSchedulesManager.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/4/11.
//

import Foundation

struct GrandPrixSchedulesManager {
	static let shared = GrandPrixSchedulesManager()
	
	func retrieveGrandPrixSchedules() async -> [GrandPrixSchedule]? {
		guard let response = await DataRequestManager.shared.fetchCurrentGrandPrixSchedules() else {
			assertionFailure("fetch current GrandPrix schedules error!")
			return nil
		}
		return response.grandPrixSchedules
	}
}

struct GrandPrixSchedulesResponse: Codable {
	var grandPrixSchedules: [GrandPrixSchedule]
	
	enum CodingKeys: String, CodingKey {
		case grandPrixSchedules = "races"
	}
}

struct GrandPrixSchedule: Codable, Equatable {
	var gpId: String
	var gpName: String {
		let parts = gpId.split(separator: "_")
		var name = ""
		for part in parts {
			if part != "2025" {
				name += part.capitalized + " "
			}
		}
		name += "GP"
		return name
	}
	var stageSchedule: StageSchedule
	var laps: Int
	var round: Int
	var circuit: Circuit
	
	enum CodingKeys: String, CodingKey {
		case gpId = "raceId"
		case stageSchedule = "schedule"
		case laps, round, circuit
	}
}


