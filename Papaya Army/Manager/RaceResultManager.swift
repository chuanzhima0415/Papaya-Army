//
//  RaceResultManager.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/4/9.
//

import Foundation

struct RaceResultManager {
	static let shared = RaceResultManager()

	class Result {
		var position: Int
		var driverName: String
		var constructor: String
		
		init(position: Int, driverName: String, constructor: String) {
			self.position = position
			self.driverName = driverName
			self.constructor = constructor
		}
	}
	
	/// 练习赛成绩
	class PracticeResult: Result {
		var lapTime: String
		init(lapTime: String, position: Int, driverName: String, constructor: String) {
			self.lapTime = lapTime
			super.init(position: position, driverName: driverName, constructor: constructor)
		}
	}
	
	/// 冲刺赛成绩
	class SprintResult: RaceResult {}
	
	/// 排位赛成绩
	class QualifyingResult: Result {
		var lapTime: String
		init(lapTime: String, position: Int, driverName: String, constructor: String) {
			self.lapTime = lapTime
			super.init(position: position, driverName: driverName, constructor: constructor)
		}
	}
	
	/// 冲刺排位赛成绩
	class SprintQualifyingResult: QualifyingResult {}
	
	/// 正赛成绩
	class RaceResult: Result {
		var points: Int
		var finishingStatus: String
		init(points: Int, finishingStatus: String, position: Int, driverName: String, constructor: String) {
			self.points = points
			self.finishingStatus = finishingStatus
			super.init(position: position, driverName: driverName, constructor: constructor)
		}
	}
	
	/// 获取某一年某一站的所有车手排位赛排名
	/// -Returns: 已排好名的车手数组
	func retrieveQualifyingRaceResult(year: Int, round: Int, completionHandler: @escaping ([QualifyingResult]) -> Void) {
//		DataRequestManager.shared.fetchQualifyingResults(year: year, round: round) { drivers in
//			completionHandler(drivers)
//		}
	}

	/// 获取某一年某一站的所有车手正赛排名
	/// -Returns: 已排好名的 result 数组
	func retrieveSpecificRaceResult(year: Int, round: Int, completionHandler: @escaping ([RaceResult]) -> Void) {
		DataRequestManager.shared.fetchRaceResults(year: year, round: round) { results in
			completionHandler(results)
		}
	}

	/// 获取某一年某一站的所有车手冲刺赛排名
	func retrieveSpecificSprintResult(year: Int, round: Int, completionHandler: @escaping ([SprintResult]) -> Void) {}
}
