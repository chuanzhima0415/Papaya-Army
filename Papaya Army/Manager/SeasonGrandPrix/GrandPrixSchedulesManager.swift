//
//  RaceSchedulesManager.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/4/11.
//

import Foundation

struct GrandPrixSchedulesManager {
	static let shared = GrandPrixSchedulesManager()

	func retrieveGrandPrixSchedule(seasonId: String) async -> [GrandPrixSchedule]? {
		let grandPrixSchedulesResponse = await DataRequestManager.shared.fetchGrandPrixSchedules(seasonId: seasonId)
		return grandPrixSchedulesResponse?.grandPrixSchedules
	}
}

/// 某一年的全年比赛日历
struct GrandPrixSchedulesResponse: Codable {
	var grandPrixSchedules: [GrandPrixSchedule]

	enum CodingKeys: String, CodingKey {
		case grandPrixSchedules = "stages"
	}
}

struct GrandPrixSchedule: Codable, Equatable {
	var id: String // 该站大奖赛的 stageid
	var grandPrixName: String // 该站大奖赛的名字
	var startDate: Date // 整一站大奖赛的开始时间
	var endDate: Date // 整一站大奖赛的结束时间
	var status: String // 大奖赛的举办状态
	var venue: Venue? // 大奖赛的举办场地

	enum CodingKeys: String, CodingKey {
		case id, status, venue
		case startDate = "scheduled"
		case endDate = "scheduled_end"
		case grandPrixName = "description"
	}
}

/// 每一站比赛的场地
struct Venue: Codable, Equatable {
	var curcuitName: String // 赛道名字
	var country: String // 正赛举行的国家
	var city: String // 正赛举行的城市
	var laps: Int // 正赛总圈数
	var length: Int // 赛道全长

	enum CodingKeys: String, CodingKey {
		case country, city, laps, length
		case curcuitName = "name"
	}
}
