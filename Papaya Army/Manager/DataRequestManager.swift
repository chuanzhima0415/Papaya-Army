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

	/// 请求一个车手的详细信息
	func fetchDriverInfo(driverNumber: Int, completionHandler: @escaping (Driver) -> Void) {
		guard let url = URL(string: "https://ergast.com/api/f1/current/driverStandings") else {
			assertionFailure("url error!")
			return
		}
		let task = URLSession.shared.dataTask(with: url) { data, response, error in
			guard let data = data, error == nil else {
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
				for result in results {
					let number = Int(try result.select("permanentnumber").text())!
					if number == driverNumber {
						let (
							birthday,
							wins,
							points,
							nationality,
							team,
							firstname,
							familyname,
							driverId,
							standingPosition
						) = try (
							result.select("driver").select("dateofbirth").text(),
							result.attr("wins"),
							result.attr("points"),
							result.select("driver").select("nationality").text(),
							result.select("constructor").select("name").text(),
							result.select("driver").select("givenname").text(),
							result.select("driver").select("familyname").text(),
							driverNumber,
							result.attr("position")
						)
						completionHandler(Driver(
							birthday: birthday,
							nationality: nationality,
							driverNumber: driverId,
							fullName: firstname + familyname,
							team: team,
							points: Int(points)!,
							wins: Int(wins)!,
							standingPos: Int(standingPosition)!
						))
						break
					}
				}
			} catch {
				assertionFailure("")
			}
		}
		task.resume()
	}

	/// 请求某站排位赛的排名
	func fetchQualifyingResults(year: Int, round: Int, completionHandler: @escaping ([Driver]) -> Void) {
		guard let url = URL(string: "http://ergast.com/api/f1/\(year)/\(round)/qualifying") else {
			assertionFailure("url error!")
			return
		}
		let task = URLSession.shared.dataTask(with: url) { data, response, error in
			guard let data = data, error == nil else {
				assertionFailure("Error: \(error?.localizedDescription ?? "Unknown")")
				return
			}
			// 处理 data & return [Driver]
		}
		task.resume() // 发出请求
	}

	/// 请求某站正赛的排名
	func fetchRaceResults(year: Int, round: Int, completionHandler: @escaping ([Driver]) -> Void) {
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
				var drivers: [Driver] = []
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
						ranking.attr("position"),
						ranking.attr("points"),
						ranking.select("driver").select("givenname").text(),
						ranking.select("driver").select("familyname").text(),
						ranking.select("status").text(),
						ranking.select("constructor").select("name").text()
					)
					drivers.append(Driver(
						fullName: driverFirstName + driverFamilyName,
						team: team,
						points: Int(points)!,
						finishedStatus: finishedStatus,
						position: Int(position)!
					))
				}
				completionHandler(drivers)
			} catch {
				assertionFailure("")
			}
		}
		task.resume() // 发出请求
	}

	/// 获取今年所有比赛（2024）& 每一场比赛的时间
	func fetchRacesSchedule(completionHandler: @escaping ([Race]) -> Void) {
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
				var result = [Race]()
				let document = try SwiftSoup.parse(html)
				let races = try document.select("race")
				for race in races {
					let (
						round,
						raceName,
						circuitName,
						country
					) = try (
						race.attr("round"),
						race.select("racename").text(),
						race.select("circuitname").text(),
						race.select("country").text()
					)
					// 填比赛时间
					let firstPractice: (date: String, time: String) = try (
						race.select("firstpractice").select("date").text(),
						race.select("firstpractice").select("time").text()
					)
					let sprint: (date: String, time: String) = try (
						race.select("sprint").select("date").text(),
						race.select("sprint").select("time").text()
					)
					let sprintQualifying: (date: String, time: String) = sprint != ("", "") ? try (
						race.select("secondpractice").select("date").text(),
						race.select("secondpractice").select("time").text()
					) : ("", "")
					let qualifying: (date: String, time: String) = try (
						race.select("qualifying").select("date").text(),
						race.select("qualifying").select("time").text()
					)
					let raceDay: (date: String, time: String) = try (
						race.select("date").first()!.text(),
						race.select("time").first()!.text()
					)
					let secondPractice: (date: String, time: String) = sprint == ("", "") ? try (
						race.select("secondpractice").select("date").text(),
						race.select("secondpractice").select("time").text()
					) : ("", "")
					let thirdPractice: (date: String, time: String) = sprint == ("", "") ? try (
						race.select("thirdpractice").select("date").text(),
						race.select("thirdpractice").select("time").text()
					) : ("", "")
					result.append(Race(
						country: country,
						round: Int(round) ?? -1,
						raceName: raceName,
						date: (
							firstPractice.date,
							secondPractice.date,
							thirdPractice.date,
							qualifying.date,
							raceDay.date,
							sprintQualifying.date,
							sprint.date
						),
						time: (
							firstPractice.time,
							secondPractice.time,
							thirdPractice.time,
							qualifying.time,
							raceDay.time,
							sprintQualifying.time,
							sprint.time
						),
						circuitName: circuitName
					))
				}
				completionHandler(result)
			} catch {
				assertionFailure("")
			}
		}
		task.resume()
	}

	/// 车手总积分统计
	/// -completionHandler: 为了把该函数里生成的 drivers 传给 retrieveDriverStandings()
	func fetchDriverStandingsRanking(completionHandler: @escaping ([Driver]) -> Void) {
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
				var drivers = [Driver]()
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
						standing.select("permanentnumber").text(),
						standing.select("name").text(),
						standing.attr("points"),
						standing.attr("wins"),
						standing.attr("position"),
						standing.select("driver").select("nationality").text()
					)
					drivers.append(Driver(
						nationality: nationality,
						driverNumber: Int(driverNumber) ?? -1,
						fullName: firstName + familyName,
						team: team,
						wins: Int(wins) ?? -1,
						standingPos: Int(standingPos) ?? -1,
						totalPoints: Int(totalPoints) ?? -1
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
