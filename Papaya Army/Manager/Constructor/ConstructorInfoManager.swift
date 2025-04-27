//
//  ConstructorInfoManager.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/4/27.
//

import Foundation

struct ConstructorInfoManager {
	static let shared = ConstructorInfoManager()
	
	func retrieveConstructorInfo(teamId: String) async -> [ConstructorInfo]? {
		guard let response = await DataRequestManager.shared.fetchConstructorInfo(teamId: teamId) else {
			assertionFailure("fail to fetch constructor info")
			return nil
		}
		
		return response.constructorInfos
	}
}

struct ConstructorInfoResponse: Codable {
	var constructorInfos: [ConstructorInfo]
	
	enum CodingKeys: String, CodingKey {
		case constructorInfos = "team"
	}
}

struct ConstructorInfo: Codable {
	var constructorId: String
	var constructorName: String {
		let parts = constructorId.split(separator: "_")
		var fullName = ""
		for part in parts {
			fullName += part.capitalized + " "
		}
		return fullName
	}
	var constructorNationality: String?
	var firstAppeareance: Int?
	var constructorsChampionships: Int?
	var driversChampionships: Int?
	var url: String
	
	enum CodingKeys: String, CodingKey {
		case constructorId = "teamId"
		case constructorNationality = "teamNationality"
		case firstAppeareance, constructorsChampionships, driversChampionships, url
	}
}
