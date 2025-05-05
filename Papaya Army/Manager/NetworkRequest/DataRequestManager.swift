//
//  DataRequestManager.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/3/19.
//

import Foundation

struct DataRequestManager {
	static let shared = DataRequestManager()
	
	/// 获取当年的所有大奖赛行程
	func fetchCurrentGrandPrixSchedules() async -> GrandPrixSchedulesResponse? {
		guard let url = URL(string: "https://f1api.dev/api/current") else {
			assertionFailure("fail to convert into url")
			return nil
		}
		
		do {
			let (dataInJson, _) = try await URLSession.shared.data(from: url)
			let decoder = JSONDecoder()
			let data = try decoder.decode(GrandPrixSchedulesResponse.self, from: dataInJson)
			return data
		} catch {
			assertionFailure("Error description: \(error)")
			return nil
		}
	}
	
	/// 获取当前赛季的 driver standings
	func fetchCurrentDriverStandings() async -> DriversStandingsReponse? {
		guard let url = URL(string: "https://f1api.dev/api/current/drivers-championship") else {
			assertionFailure("fail to convert into url")
			return nil
		}
		
		do {
			let (dataInJson, _) = try await URLSession.shared.data(from: url)
			let decoder = JSONDecoder()
			let data = try decoder.decode(DriversStandingsReponse.self, from: dataInJson)
			return data
		} catch {
			assertionFailure("Error description: \(error)")
			return nil
		}
	}
	
	/// 获取某场正赛的比赛成绩
	func fetchSpecificRaceResult(year: String, round: Int) async -> RaceResultResponse? {
		guard let url = URL(string: "https://f1api.dev/api/\(year)/\(round)/race") else {
			assertionFailure("fail to convert into url")
			return nil
		}
		
		do {
			let (dataInJson, response) = try await URLSession.shared.data(from: url)
			
			guard let httpResponse = response as? HTTPURLResponse else {
				assertionFailure("\(URLError(.badServerResponse))")
				return nil
			}
			
			guard httpResponse.statusCode == 200 else {
				if httpResponse.statusCode == 500 {
					print("\(httpResponse.statusCode): Internal server error")
				} else {
					print("\(httpResponse.statusCode): Resource not found")
				}
				return .init(status: httpResponse.statusCode)
			}
			
			let decoder = JSONDecoder()
			let data = try decoder.decode(RaceResultResponse.self, from: dataInJson)
			return data
		} catch {
			assertionFailure("Error description: \(error)")
			return nil
		}
	}
	
	/// 获取某场排位赛的比赛成绩
	func fetchQualifyingResults(year: String, round: Int) async -> QualifyingResultResponse? {
		guard let url = URL(string: "https://f1api.dev/api/\(year)/\(round)/qualy") else {
			assertionFailure("fail to convert into url")
			return nil
		}
		
		do {
			let (dataInJson, response) = try await URLSession.shared.data(from: url)
			
			guard let httpResponse = response as? HTTPURLResponse else {
				assertionFailure("\(URLError(.badServerResponse))")
				return nil
			}
			
			guard httpResponse.statusCode == 200 else {
				if httpResponse.statusCode == 500 {
					print("\(httpResponse.statusCode): Internal server error")
				} else {
					print("\(httpResponse.statusCode): Resource not found")
				}
				return .init(status: httpResponse.statusCode)
			}
			
			let decoder = JSONDecoder()
			let data = try decoder.decode(QualifyingResultResponse.self, from: dataInJson)
			return data
		} catch {
			assertionFailure("Error description: \(error)")
			return nil
		}
	}
	
	/// 获取某一站的某一场练习赛成绩
	func fetchPracticeNResults(year: String, round: Int, n: Int) async -> PracticeResultResponse? {
		guard let url = URL(string: "https://f1api.dev/api/\(year)/\(round)/fp\(n)") else {
			assertionFailure("fail to convert into url")
			return nil
		}
		
		do {
			let (dataInJson, response) = try await URLSession.shared.data(from: url)
			
			guard let httpResponse = response as? HTTPURLResponse else {
				assertionFailure("\(URLError(.badServerResponse))")
				return nil
			}
			
			guard httpResponse.statusCode == 200 else {
				if httpResponse.statusCode == 500 {
					print("\(httpResponse.statusCode): Internal server error")
				} else {
					print("\(httpResponse.statusCode): Resource not found")
				}
				return .init(status: httpResponse.statusCode)
			}
			
			let decoder = JSONDecoder()
			let data = try decoder.decode(PracticeResultResponse.self, from: dataInJson)
			return data
		} catch {
			assertionFailure("Error description: \(error)")
			return nil
		}
	}
	
	func fetchSprintRaceResults(year: String, round: Int) async -> SprintRaceResponse? {
		guard let url = URL(string: "https://f1api.dev/api/\(year)/\(round)/sprint/race") else {
			assertionFailure("fail to convert into url")
			return nil
		}
		
		do {
			let (dataInJson, response) = try await URLSession.shared.data(from: url)
			
			guard let httpResponse = response as? HTTPURLResponse else {
				assertionFailure("\(URLError(.badServerResponse))")
				return nil
			}
			
			guard httpResponse.statusCode == 200 else {
				if httpResponse.statusCode == 500 {
					print("\(httpResponse.statusCode): Internal server error")
				} else {
					print("\(httpResponse.statusCode): Resource not found")
				}
				return .init(status: httpResponse.statusCode)
			}
			
			let decoder = JSONDecoder()
			let data = try decoder.decode(SprintRaceResponse.self, from: dataInJson)
			return data
		} catch {
			assertionFailure("Error description: \(error)")
			return nil
		}
	}
	
	func fetchSprintQualifyingResult(year: String, round: Int) async -> SprintQualifyingResultResponse? {
		guard let url = URL(string: "https://f1api.dev/api/\(year)/\(round)/sprint/qualy") else {
			assertionFailure("fail to convert into url")
			return nil
		}
		
		do {
			let (dataInJson, response) = try await URLSession.shared.data(from: url)
			
			guard let httpResponse = response as? HTTPURLResponse else {
				assertionFailure("\(URLError(.badServerResponse))")
				return nil
			}
			
			guard httpResponse.statusCode == 200 else {
				if httpResponse.statusCode == 500 {
					print("\(httpResponse.statusCode): Internal server error")
				} else {
					print("\(httpResponse.statusCode): Resource not found")
				}
				return .init(status: httpResponse.statusCode)
			}
			
			let decoder = JSONDecoder()
			let data = try decoder.decode(SprintQualifyingResultResponse.self, from: dataInJson)
			return data
		} catch {
			assertionFailure("Error description: \(error)")
			return nil
		}
	}
	
	func fetchCurrentConstructorStandings() async -> ConstructorStandingsResopnse? {
		guard let url = URL(string: "https://f1api.dev/api/current/constructors-championship") else {
			assertionFailure("fail to convert into url")
			return nil
		}
		
		do {
			let (dataInJson, response) = try await URLSession.shared.data(from: url)
			let decoder = JSONDecoder()
			let data = try decoder.decode(ConstructorStandingsResopnse.self, from: dataInJson)
			return data
		} catch {
			assertionFailure("Error description: \(error)")
			return nil
		}
	}
	
	func fetchConstructorInfo(teamId: String) async -> ConstructorInfoResponse? {
		guard let url = URL(string: "https://f1api.dev/api/current/teams/\(teamId)") else {
			assertionFailure("fail to convert into url")
			return nil
		}
		
		do {
			let (dataInJson, _) = try await URLSession.shared.data(from: url)
			let decoder = JSONDecoder()
			let data = try decoder.decode(ConstructorInfoResponse.self, from: dataInJson)
			return data
		} catch {
			assertionFailure("Error description: \(error)")
			return nil
		}
	}
}
