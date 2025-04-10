//
//  DriverManager.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/3/14.
//

import Foundation

/// 单例模式
struct DriverManager {
	static let shared = DriverManager()

	struct Driver: Codable {
		var nationality: String // 车手国籍
		var driverNumber: Int // 车手的号码
		var fullName: String // 车手全名
		var constructor: String // 所属车队
		var wins: Int // 整个赛季正赛赢的次数
		var standingPos: Int // 总积分排名
		var totalPoints: Int // 整个赛季的总积分数
	}
	
	struct DriverDetail: Codable {
		var driverBasicInfo: Driver
		var birth: String
	}
	
	/// 获取某位车手的详细信息（国籍、生日）
	/// -Returns: 某位车手的信息
	func retrieveDriverInfo(driverNumber: Int, completionHandler: @escaping (DriverDetail) -> Void) {
		DataRequestManager.shared.fetchDriverInfo(driverNumber: driverNumber) { driver in
			completionHandler(driver)
		}
	}

	/// 获取 StandingsView 的排名
	/// -Returns: 已排好名的车手数组
	func retrieveDriverStandings(completionHandler: @escaping ([Driver]) -> Void) {
		DataRequestManager.shared.fetchDriverStandingsRanking { drivers in
			completionHandler(drivers)
		}
	}
}
