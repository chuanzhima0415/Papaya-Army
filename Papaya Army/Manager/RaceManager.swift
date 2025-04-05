//
//  RaceManager.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/3/22.
//

import Foundation

struct Race {
	var country: String = "Unknown" // 举办比赛的国家
	var round: Int = -1 // 比赛的站数
	var raceName: String = "Unknown" // 比赛的站的名字
	var date: (
		firstPractice: String,
		secondPractice: String,
		thirdPractice: String,
		qualifying: String,
		raceDay: String,
		sprintQualifying: String,
		sprint: String
	) = ("Unknown", "Unknown", "Unknown", "Unknown", "Unknown", "Unknown", "Unknown") // 一练、二练、三练、排位赛、正赛、冲刺排位赛、冲刺赛的日期
	var time: (
		firstPractice: String,
		secondPractice: String,
		thirdPractice: String,
		qualifying: String,
		raceDay: String,
		sprintQualifying: String,
		sprint: String
	) = ("Unknown", "Unknown", "Unknown", "Unknown", "Unknown", "Unknown", "Unknown") // 一练、二练、三练、排位赛、正赛、冲刺排位赛、冲刺赛的时间
	var circuitName: String = "Unknown" // 赛道名称
}

struct RaceManager {
	static let shared = RaceManager()
	
	/// 获取某一年某一站的所有车手排位赛排名
	/// -Returns: 已排好名的车手数组
	func retrieveQualifyingRaceResult(year: Int, round: Int, completionHandler: @escaping ([Driver]) -> Void) {
		DataRequestManager.shared.fetchQualifyingResults(year: year, round: round) { drivers in
			completionHandler(drivers)
		}
	}

	/// 获取某一年某一站的所有车手正赛排名
	/// -Returns: 已排好名的车手数组
	func retrieveSpecificRaceResult(year: Int, round: Int, completionHandler: @escaping ([Driver]) -> Void) {
		DataRequestManager.shared.fetchRaceResults(year: year, round: round) { results in
			completionHandler(results)
		}
	}

	func retrieveRaceSchedule(completionHandler: @escaping ([Race]) -> Void) {
		DataRequestManager.shared.fetchRacesSchedule { races in
			completionHandler(races)
		}
	}
}
