//
//  DataRequestManager.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/3/19.
//

import Foundation

struct DataRequestManager {
	static var shared = DataRequestManager()

	/// 请求一个车手的详细信息
	func fetchDriverInfo(driverNumber: Int) -> Driver {
		guard let url = URL(string: "https://api.openf1.org/v1/drivers?driver_number=\(driverNumber)&session_key=latest") else {
			assert(false, "url error!")
		}
		let task = URLSession.shared.dataTask(with: url) { data, response, error in
			guard response != nil, data != nil, error == nil else {
				assert(false, "Error: \(error?.localizedDescription ?? "Unknown")")
			}
			// 处理 data & return Driver
		}
		task.resume() // 发出请求
		return Driver(name: "Unknown", team: "Unknown", points: 0, finishingStatus: "Unknown")
	}
	
	/// 请求某站排位赛的排名
	func fetchQualifyingResults(year: Int, round: Int) -> [Driver] {
		guard let url = URL(string: "http://ergast.com/api/f1/\(year)/\(round)/qualifying") else {
			assert(false, "url error!")
		}
		let task = URLSession.shared.dataTask(with: url) { data, response, error in
			guard response != nil, data != nil, error == nil else {
				assert(false, "Error: \(error?.localizedDescription ?? "Unknown")")
			}
			// 处理 data & return [Driver]
		}
		task.resume() // 发出请求
		return [Driver]()
	}
	
	/// 请求某站正赛的排名
	func fetchRaceResults(year: Int, round: Int) -> [Driver] {
		guard let url = URL(string: "http://ergast.com/api/f1/\(year)/\(round)/results") else {
			assert(false, "url error!")
		}
		let task = URLSession.shared.dataTask(with: url) { data, response, error in
			guard response != nil, data != nil, error == nil else {
				assert(false, "Error: \(error?.localizedDescription ?? "Unknown")")
			}
			// 处理 data & return [Driver]
		}
		task.resume() // 发出请求
		return [Driver]()
	}
	
	/// 获取今年所有比赛（2024）& 每一场比赛的时间
	func fetchCurrentRacesInfo() -> [Race] {
		guard let url = URL(string: "http://ergast.com/api/f1/current") else { assert(false, "url error!") }
		let task = URLSession.shared.dataTask(with: url) { data, response, error in
			guard error == nil, data != nil, response != nil else {
				assert(false, "Error: \(error?.localizedDescription ?? "Unknown")")
			}
			// 处理 data & return [Race]()
		}
		task.resume()
		return [Race]()
	}
	
	/// 车手总积分统计
	func fetchDriverStandingsRanking() {
		guard let url = URL(string: "http://ergast.com/api/f1/current/driverStandings") else {
			assert(false, "url error!")
		}
		let task = URLSession.shared.dataTask(with: url) { data, response, error in
			guard error == nil, data != nil, response != nil else {
				assert(false, "Error: \(error?.localizedDescription ?? "Unknown")")
			}
			// 处理 data
		}
		task.resume()
	}
}
