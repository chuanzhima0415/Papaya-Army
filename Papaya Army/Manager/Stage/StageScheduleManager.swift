//
//  StageScheduleManager.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/4/11.
//

import Foundation


struct StageScheduleManager {
	static let shared = StageScheduleManager()
	
	func retrieveCompletedStages(round: Int, stages: [(name: String, startDate: Date)]) async -> Set<String> {
		var ret: Set<String> = []
		
		for stage in stages {
			switch stage.name {
			case "race":
				if let response = await DataRequestManager.shared.fetchSpecificRaceResult(year: "2025", round: round) {
					if response.status == nil {
						ret.insert("race")
					}
				}
			case "practice1":
				if let response = await DataRequestManager.shared.fetchPracticeNResults(year: "2025", round: round, n: 1) {
					if response.status == nil {
						ret.insert("practice1")
					}
				}
			case "practice2":
				if let response = await DataRequestManager.shared.fetchPracticeNResults(year: "2025", round: round, n: 2) {
					if response.status == nil {
						ret.insert("practice2")
					}
				}
			case "practice3":
				if let response = await DataRequestManager.shared.fetchPracticeNResults(year: "2025", round: round, n: 3) {
					if response.status == nil {
						ret.insert("practice3")
					}
				}
			case "qualifying":
				if let response = await DataRequestManager.shared.fetchQualifyingResults(year: "2025", round: round) {
					if response.status == nil {
						ret.insert("qualifying")
					}
				}
			case "sprintRace":
				if let response = await DataRequestManager.shared.fetchSprintRaceResults(year: "2025", round: round) {
					if response.status == nil {
						ret.insert("sprintRace")
					}
				}
			case "sprintQualifying":
				if let response = await DataRequestManager.shared.fetchSprintQualifyingResult(year: "2025", round: round) {
					if response.status == nil {
						ret.insert("sprintQualifying")
					}
				}
			default:
				return []
			}
		}
		
		return ret
	}
}

struct StartDate: Codable, Equatable {
	var date: String?
	var time: String?
	var fullDate: Date? {
		if let date, let time {
			let isoString = "\(date)T\(time)"
			return ISO8601DateFormatter().date(from: isoString)
		} else {
			return nil
		}
	}
}

struct StageSchedule: Codable, Equatable {
	var race: StartDate
	var qualifying: StartDate
	var practice1: StartDate
	var practice2: StartDate
	var practice3: StartDate
	var sprintQualifying: StartDate
	var sprintRace: StartDate
	
	enum CodingKeys: String, CodingKey {
		case qualifying = "qualy"
		case practice1 = "fp1"
		case practice2 = "fp2"
		case practice3 = "fp3"
		case sprintQualifying = "sprintQualy"
		case sprintRace, race
	}
}
