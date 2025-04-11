//
//  StageScheduleManager.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/4/11.
//

import Foundation

struct StageScheduleManager {
	static let shared = StageScheduleManager()
	
	func retrieveStageSchedule(grandPrixId: String) async -> [StageSchedule]? {
		let stageScheduleResponse = await DataRequestManager.shared.fetchStageSchedule(grandPrixId: grandPrixId)
		return stageScheduleResponse?.stageSchedules
	}
}

struct StageScheduleResponse: Codable {
	var stageSchedules: [StageSchedule]
	
	enum CodingKeys: String, CodingKey {
		case stageSchedules = "stages"
	}
}

struct StageSchedule: Codable {
	var stageId: String
	var name: String
	var startTime: Date
	var endTime: Date
	var status: String
	var stages: [StageSchedule]?
	var humidity: Int?
	var airTemperature: Int?
	var trackTemperature: Int?
	var weather: String?
	
	enum CodingKeys: String, CodingKey {
		case status, stages, weather, humidity
		case stageId = "id"
		case name = "description"
		case startTime = "scheduled"
		case endTime = "scheduled_end"
		case airTemperature = "air_temperature"
		case trackTemperature = "track_temperature"
	}
}
