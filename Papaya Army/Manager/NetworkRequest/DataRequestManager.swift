//
//  DataRequestManager.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/3/19.
//

import Foundation
import SwiftSoup

enum APIKeys: String {
	case apiKey = "It5XDanKlzbwvyk6ghXBvwzFBiudE843AJ7gzKV1"
}

struct DataRequestManager {
	static let shared = DataRequestManager()
	
	/// 获取某一年的全年的赛历
	func fetchGrandPrixSchedules(seasonId: String) async -> GrandPrixSchedulesResponse? {
		guard let url = URL(string: "https://api.sportradar.com/formula1/trial/v2/en/sport_events/sr%3Astage%3A\(seasonId.replacingOccurrences(of: "sr:stage:", with: ""))/schedule.json?api_key=\(APIKeys.apiKey.rawValue)") else {
			assertionFailure("Invalid URL string")
			return nil
		}
		
		do {
			let (dataInJson, _) = try await URLSession.shared.data(for: URLRequest(url: url))
			let decoder = JSONDecoder(); decoder.dateDecodingStrategy = .iso8601
			let data = try decoder.decode(GrandPrixSchedulesResponse.self, from: dataInJson)
			return data
		} catch {
			assertionFailure("JSON decode failed: \(error)")
			return nil
		}
	}
	
	/// 获取某个 competitor 的详细信息
	func fetchCompetitorDetailInfo(competitorId: String) async -> CompetitorDetailResponse? {
		guard let url = URL(string: "https://api.sportradar.com/formula1/trial/v2/en/competitors/sr%3Acompetitor%3A\(competitorId.replacingOccurrences(of: "sr:competitor:", with: ""))/profile.json?api_key=\(APIKeys.apiKey.rawValue)") else {
			return nil
		}
		
		do {
			let (dataInJson, _) = try await URLSession.shared.data(for: URLRequest(url: url))
			let decoder = JSONDecoder();
			let data = try decoder.decode(CompetitorDetailResponse.self, from: dataInJson)
			return data
		} catch {
			assertionFailure("JSON decode failed: \(error)")
			return nil
		}
	}
	
	func fetchConstructorDetailInfo(constructorId: String) async {
		
	}
	
	/// 获取某赛季的车手总积分的排行榜信息
	func fetchCompetitorsStandings(seasonId: String) async -> CompetitorStandingsResponse? {
		guard let url = URL(string: "https://api.sportradar.com/formula1/trial/v2/en/sport_events/sr%3Astage%3A\(seasonId.replacingOccurrences(of: "sr:stage:", with: ""))/summary.json?api_key=\(APIKeys.apiKey.rawValue)") else {
			return nil
		}
		
		do {
			let (dataInJson, _) = try await URLSession.shared.data(for: URLRequest(url: url))
			let decoder = JSONDecoder()
			let data = try decoder.decode(CompetitorStandingsResponse.self, from: dataInJson)
			return data
		} catch {
			assertionFailure("JSON decode failed: \(error)")
			return nil
		}
	}
	
	/// 每一个 Grand Prix 的所有 Stage & 每一个 Stage 的举办时间等信息
	func fetchStageSchedule(grandPrixId: String) async -> StageScheduleResponse? {
		guard let url = URL(string: "https://api.sportradar.com/formula1/trial/v2/en/sport_events/sr%3Astage%3A\(grandPrixId.replacingOccurrences(of: "sr:stage:", with: ""))/schedule.json?api_key=\(APIKeys.apiKey.rawValue)") else {
			return nil
		}
		
		do {
			let (dataInJson, _) = try await URLSession.shared.data(for: URLRequest(url: url))
			let decoder = JSONDecoder(); decoder.dateDecodingStrategy = .iso8601
			let data = try decoder.decode(StageScheduleResponse.self, from: dataInJson)
			return data
		} catch {
			assertionFailure("JSON decode failed: \(error)")
			return nil
		}
	}
	
	/// 获取某个 stage 的比赛结果
	func fetchStageResult(stageId: String) async -> StageResultResponse? {
		guard let url = URL(string: "https://api.sportradar.com/formula1/trial/v2/en/sport_events/sr%3Astage%3A\(stageId.replacingOccurrences(of: "sr:stage:", with: ""))/summary.json?api_key=\(APIKeys.apiKey.rawValue)") else {
			assertionFailure("Invalid URL string")
			return nil
		}
		
		do {
			let (dataInJson, _) = try await URLSession.shared.data(for: URLRequest(url: url))
			let decoder = JSONDecoder()
			let data = try decoder.decode(StageResultResponse.self, from: dataInJson)
			return data
		} catch {
			assertionFailure("JSON decode failed: \(error)")
			return nil
		}
	}
}
