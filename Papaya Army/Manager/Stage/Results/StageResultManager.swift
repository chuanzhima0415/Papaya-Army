//
//  StageResultManager.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/4/11.
//

import Foundation

struct StageResultManager {
	static let shared = StageResultManager()
	
	func retrieveStageResult(for stageId: String) async -> StageResultResponse? {
		await DataRequestManager.shared.fetchStageResult(stageId: stageId)
	}
}

struct StageResultResponse: Codable {
	var stageResult: StageResult
	
	enum CodingKeys: String, CodingKey {
		case stageResult = "stage"
	}
}

struct StageResult: Codable, Equatable {
	var id: String
	var name: String
	var status: String
	var airTemperature: Int?
	var trackTemperature: Int?
	var humidity: Int?
	var weather: String?
	var competitors: [Competitor]
	
	enum CodingKeys: String, CodingKey {
		case id, status, humidity, weather, competitors
		case name = "description"
		case airTemperature = "air_temperature"
		case trackTemperature = "track_temperature"
	}
}

struct Constructor: Codable, Equatable {
	var constructorId: String
	var name: String
	var nationality: String
	
	enum CodingKeys: String, CodingKey {
		case name, nationality
		case constructorId = "id"
	}
}
