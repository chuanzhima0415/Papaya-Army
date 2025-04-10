//
//  DataRequestManager.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/3/19.
//

import Foundation
import SwiftSoup

struct DataRequestManager {
	static let shared = DataRequestManager()
	
	private func dateStringConvertToDate(dateString: String) -> Date! {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd HH:mm:ssZ"
		formatter.locale = Locale(identifier: "en_US_POSIX")
		formatter.timeZone = TimeZone(secondsFromGMT: 0)
		return formatter.date(from: dateString)
	}
	
	/// 请求一个车手的详细信息
	func fetchDriverInfo(driverNumber: Int, completionHandler: @escaping (DriverManager.DriverDetail) -> Void) {
		guard let url = URL(string: "https://ergast.com/api/f1/current/driverStandings") else {
			assertionFailure("url error!")
			return
		}
		let task = URLSession.shared.dataTask(with: url) { data, _, error in
			guard let data, error == nil else {
				assertionFailure("Error: \(error?.localizedDescription ?? "Unknown")")
				return
			}
			guard let html = String(data: data, encoding: .utf8) else {
				assertionFailure("data cannot convert into html")
				return
			}
			do {
				let document = try SwiftSoup.parse(html)
				let results = try document.select("driverstanding")
				var driverDetail: DriverManager.DriverDetail?
				for result in results {
					let number = try Int(result.select("permanentnumber").text())!
					if number == driverNumber {
						let (birthday, wins, totalPoints, nationality, team, firstname, familyname, standingPosition) = try (
							result.select("driver").select("dateofbirth").text(),
							result.attr("wins"),
							result.attr("points"),
							result.select("driver").select("nationality").text(),
							result.select("constructor").select("name").text(),
							result.select("driver").select("givenname").text(),
							result.select("driver").select("familyname").text(),
							result.attr("position")
						)
						
						driverDetail = DriverManager
							.DriverDetail(
								driverBasicInfo: DriverManager
									.Driver(
										nationality: nationality,
										driverNumber: driverNumber,
										fullName: firstname + familyname,
										constructor: team,
										wins: Int(wins)!,
										standingPos: Int(standingPosition)!,
										totalPoints: Int(totalPoints)!
									),
								birth: birthday
							)
						break
					}
				}
				if let driverDetail { completionHandler(driverDetail) }
			} catch {
				assertionFailure("")
			}
		}
		task.resume()
	}
	
	// 请求某站排位赛的排名
//	func fetchQualifyingResults(year: Int, round: Int, completionHandler: @escaping ([RaceResultManager.QualifyingResult]) -> Void) {
//		guard let url = URL(string: "https://ergast.com/api/f1/\(year)/\(round)/qualifying") else {
//			assertionFailure("url error!")
//			return
//		}
//		let task = URLSession.shared.dataTask(with: url) { data, response, error in
//			guard let data, error == nil else {
//				assertionFailure("Error: \(error?.localizedDescription ?? "Unknown")")
//				return
//			}
//				// 处理 data & return [Driver]
//			guard let html = String(data: data, encoding: .utf8) else {
//				assertionFailure("data cannot convert into html")
//				return
//			}
//			do {
//				let document = try SwiftSoup.parse(html)
//				let rankings = try document.select("qualifyingresult")
//				for ranking in rankings {
//					let (
//						qualifyingPos,
//						firstname,
//						familyname,
//						laptime
//					) = try (
//						Int(ranking.attr("position"))!,
//						ranking.select("driver").select("givenname").text(),
//						ranking.select("driver").select("familyname").text(),
//						ranking.select("q1").text(), ranking.select("q1").text()
//					)
//				}
//			} catch {
//				assertionFailure("")
//			}
//		}
//		task.resume() // 发出请求
//	}
	
	/// 请求某站正赛的排名
	func fetchRaceResults(year: Int, round: Int, completionHandler: @escaping ([RaceResultManager.RaceResult]) -> Void) {
		guard let url = URL(string: "https://ergast.com/api/f1/\(year)/\(round)/results") else {
			assertionFailure("url error!")
			return
		}
		let task = URLSession.shared.dataTask(with: url) { data, _, error in
			guard let data, error == nil else {
				assertionFailure("Error: \(error?.localizedDescription ?? "Unknown")")
				return
			}
			// 处理 data & return [Driver]
			guard let html = String(data: data, encoding: .utf8) else {
				assertionFailure("data cannot convert into html")
				return
			}
			do {
				var results: [RaceResultManager.RaceResult] = []
				let document = try SwiftSoup.parse(html)
				let rankings = try document.select("result")
				for ranking in rankings {
					let (
						position,
						points,
						driverFirstName,
						driverFamilyName,
						finishedStatus,
						team
					) = try (
						Int(ranking.attr("position"))!,
						Int(ranking.attr("points"))!,
						ranking.select("driver").select("givenname").text(),
						ranking.select("driver").select("familyname").text(),
						ranking.select("status").text(),
						ranking.select("constructor").select("name").text()
					)
					results
						.append(
							RaceResultManager
								.RaceResult(
									points: points,
									finishingStatus: finishedStatus,
									position: position,
									driverName: driverFirstName + driverFamilyName,
									constructor: team
								)
						)
				}
				completionHandler(results)
			} catch {
				assertionFailure("")
			}
		}
		task.resume() // 发出请求
	}
	
	/// 获取今年所有比赛（2024）& 每一场比赛的时间
	func fetchRacesSchedule(completionHandler: @escaping ([RaceScheduleManager.RaceSchedule]) -> Void) {
		guard let url = URL(string: "https://ergast.com/api/f1/current") else { assertionFailure("url error!")
			return
		}
		let task = URLSession.shared.dataTask(with: url) { data, _, error in
			guard let data, error == nil else {
				assertionFailure("Error: \(error?.localizedDescription ?? "Unknown")")
				return
			}
			// 处理 data & return [Race]()
			guard let html = String(data: data, encoding: .utf8) else {
				assertionFailure("data cannot convert into html")
				return
			}
			do {
				var schedules = [RaceScheduleManager.RaceSchedule]()
				let document = try SwiftSoup.parse(html)
				let races = try document.select("race")
				for race in races {
					let (round, raceName, circuitName, country) = try (
						Int(race.attr("round"))!,
						race.select("racename").text(),
						race.select("circuitname").text(),
						race.select("country").text()
					)
					// 填比赛时间
					let firstPractice: Date = try dateStringConvertToDate(
						dateString: "\(race.select("firstpractice").select("date").text()) \(race.select("firstpractice").select("time").text())"
					)
					let sprint: Date? = try dateStringConvertToDate(dateString: "\(race.select("sprint").select("date").text()) \(race.select("sprint").select("time").text())")
					let sprintQualifying: Date? = try sprint == nil ? nil : dateStringConvertToDate(dateString: "\(race.select("secondpractice").select("date").text()) \(race.select("secondpractice").select("time").text())")
					let qualifying: Date = try dateStringConvertToDate(
						dateString: "\(race.select("qualifying").select("date").text()) \(race.select("qualifying").select("time").text())"
					)
					let raceDay: Date = try dateStringConvertToDate(dateString: "\(race.select("date").first()!.text()) \(race.select("time").first()!.text())")
					let secondPractice: Date? = try sprint == nil ? nil : dateStringConvertToDate(dateString: "\(race.select("secondpractice").select("date").text()) \(race.select("secondpractice").select("time").text())")
					let thirdPractice: Date? = try sprint == nil ? nil : dateStringConvertToDate(dateString: "\(race.select("thirdpractice").select("date").text()) \(race.select("thirdpractice").select("time").text())")
					schedules
						.append(
							RaceScheduleManager
								.RaceSchedule(
									country: country,
									round: round,
									raceName: raceName,
									raceTime: .init(
										firstPractice: firstPractice,
										secondPractice: secondPractice,
										thirdPractice: thirdPractice,
										sprintQualifying: sprintQualifying,
										sprint: sprint,
										qualifying: qualifying,
										race: raceDay
									),
									circuitName: circuitName
								)
						)
				}
				completionHandler(schedules)
			} catch {
				assertionFailure("")
			}
		}
		task.resume()
	}
	
	/// 车手总积分统计
	/// -completionHandler: 为了把该函数里生成的 drivers 传给 retrieveDriverStandings()
	func fetchDriverStandingsRanking(completionHandler: @escaping ([DriverManager.Driver]) -> Void) {
		guard let url = URL(string: "https://ergast.com/api/f1/current/driverStandings") else {
			assertionFailure("url error!")
			return
		}
		let task = URLSession.shared.dataTask(with: url) { data, _, error in
			guard error == nil, let data else {
				assertionFailure("Error: \(error?.localizedDescription ?? "Unknown")")
				return
			}
			// 处理 data
			guard let html = String(data: data, encoding: .utf8) else {
				assertionFailure("cannot convert data into html")
				return
			}
			do {
				var drivers = [DriverManager.Driver]()
				let document = try SwiftSoup.parse(html)
				let standings = try document.select("driverstanding")
				for standing in standings {
					let (
						firstName,
						familyName,
						driverNumber,
						team,
						totalPoints,
						wins,
						standingPos,
						nationality
					) = try (
						standing.select("givenname").text(),
						standing.select("familyname").text(),
						Int(standing.select("permanentnumber").text())!,
						standing.select("name").text(),
						Int(standing.attr("points"))!,
						Int(standing.attr("wins"))!,
						Int(standing.attr("position"))!,
						standing.select("driver").select("nationality").text()
					)
					drivers.append(DriverManager.Driver(
						nationality: nationality,
						driverNumber: driverNumber,
						fullName: firstName + familyName,
						constructor: team,
						wins: wins,
						standingPos: standingPos,
						totalPoints: totalPoints
					))
				}
				completionHandler(drivers)
			} catch {
				assertionFailure()
			}
		}
		task.resume()
	}
}
