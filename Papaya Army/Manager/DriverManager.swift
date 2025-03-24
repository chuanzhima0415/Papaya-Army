//
//  DriverManager.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/3/14.
//

import Foundation

struct Driver {
	var name: String
	var team: String
	var points: Int /// 每次比赛获得的积分
	var finishingStatus: String /// 完赛状态
}

// 单例模式
struct DriverManager {
	var drivers = [Driver]()
	static let shared = DriverManager()
	
	func retrieveDriverRaceResult() -> [Driver] {
		let driver1 = Driver(name: "VER", team: "Red Bull", points: 26, finishingStatus: "Finished")
		let driver2 = Driver(name: "NOR", team: "Mclaren", points: 24, finishingStatus: "Finished")
		let driver3 = Driver(name: "PIA", team: "Mclaren", points: 24, finishingStatus: "Finished")
		let driver4 = Driver(name: "LAW", team: "Red Bull", points: 24, finishingStatus: "Finished")
		let driver5 = Driver(name: "HAM", team: "Ferrari", points: 24, finishingStatus: "Finished")
		let driver6 = DataRequestManager.shared.fetchDriverInfo(driverNumber: 1)
		return [driver1, driver2, driver3, driver4, driver5, driver6]
	}
}
