//
//  StageScheduleManager.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/4/11.
//

import Foundation

struct StartDate: Codable, Equatable, Comparable {
	static func < (lhs: StartDate, rhs: StartDate) -> Bool {
		if let date1 = lhs.fullDate, let date2 = rhs.fullDate {
			return date1 < date2
		} else {
			return false
		}
	}

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
