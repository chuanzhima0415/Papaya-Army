//
//  PracticeResultManager.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/4/26.
//

import Foundation

struct PracticeResultManager {
	static let shared = PracticeResultManager()
	
	func retrievePracticeNResult(year: String, round: Int, n: Int) async -> [PracticeResult]? {
		guard var response = await DataRequestManager.shared.fetchPracticeNResults(year: year, round: round, n: n) else {
			assertionFailure("fail to fetch practice1 results")
			return nil
		}
		
		switch n {
		case 1:
			response.race.practice1Results?.removeAll(where: { $0.time == nil })
			return response.race.practice1Results
		case 2:
			response.race.practice2Results?.removeAll(where: { $0.time == nil })
			return response.race.practice2Results
		case 3:
			response.race.practice3Results?.removeAll(where: { $0.time == nil })
			return response.race.practice3Results
		default:
			return nil
		}
	}
}

struct PracticeResultResponse: Codable {
	var race: Practice
	
	enum CodingKeys: String, CodingKey {
		case race = "races"
	}
}

struct Practice: Codable {
	var practice1Results: [PracticeResult]?
	var practice2Results: [PracticeResult]?
	var practice3Results: [PracticeResult]?
	
	enum CodingKeys: String, CodingKey {
		case practice1Results = "fp1Results"
		case practice2Results = "fp2Results"
		case practice3Results = "fp3Results"
	}
}

struct PracticeResult: Codable {
	var driverId: String
	var teamId: String
	var time: String?
	var driver: DriverDetailInfo
}
