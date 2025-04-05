//
//  DriverManager.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/3/14.
//

import Foundation

struct Driver {
	var birthday: String = "Uknown"              // 车手生日
	var nationality: String = "Uknown"           // 车手国籍
	var driverNumber: Int = -1 					 // 车手的号码
	var fullName: String = "Unknown" 			 // 车手全名
	var team: String = "Unknown" 				 // 所属车队
	var points: Int = -1 						 // 某次比赛获得的积分
	var finishedStatus: String = "Uknown" 		 // 完赛状态
	var wins: Int = -1 							 // 整个赛季正赛赢的次数
	var standingPos = -1 						 // 总积分排名
	var position = -1 							 // 某场比赛的排名
	var totalPoints = -1 						 // 整个赛季的总积分数
}

/// 单例模式
struct DriverManager {
	static let shared = DriverManager()
	
	/// 获取某位车手的详细信息（国籍、生日）
	/// -Returns: 某位车手的信息
	func retrieveDriverInfo(driverNumber: Int, completionHandler: @escaping (Driver) -> Void) {
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
