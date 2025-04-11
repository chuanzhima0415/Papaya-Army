//
//  CompetitorDetailManager.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/4/11.
//

import Foundation

struct CompetitorDetailManager {
	static let shared = CompetitorDetailManager()

	func retrieveCompetitorDetailInfo(competitorId: String) async -> CompetitorDetailResponse? {
		return await DataRequestManager.shared.fetchCompetitorDetailInfo(competitorId: competitorId)
	}
}

struct CompetitorDetailResponse: Codable {
	var competitor: Competitor
	var teams: [Constructor]
	var info: CompetitorDetailInfo
}

struct CompetitorDetailInfo: Codable {
	var firstPole: String
	var firstVictory: String
	var firstPoints: String
	var birthday: String
	var birthPlace: String
	var carNumber: Int

	enum CodingKeys: String, CodingKey {
		case firstPole = "first_pole"
		case firstVictory = "first_victory"
		case birthday = "dateofbirth"
		case birthPlace = "placeofbirth"
		case carNumber = "car_number"
		case firstPoints = "first_points"
	}
}
