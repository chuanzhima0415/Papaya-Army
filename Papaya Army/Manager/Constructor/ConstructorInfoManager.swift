//
//  ConstructorInfoManager.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/4/27.
//

import Foundation
import SwiftUI

enum ConstructorColor {
	static let mercedes = (red: 0.306, green: 0.671, blue: 0.620)
	static let ferrari = (red: 0.608, green: 0.118, blue: 0.125)
	static let red_bull = (red: 0.169, green: 0.200, blue: 0.286)
	static let mclaren = (red: 0.882, green: 0.498, blue: 0.184)
	static let alpine = (red: 0.243, green: 0.553, blue: 0.788)
	static let aston_martin = (red: 0.212, green: 0.431, blue: 0.329)
	static let sauber = (red: 0.357, green: 0.639, blue: 0.290)
	static let visa_rb = (red: 0.318, green: 0.416, blue: 0.706)
	static let haas = (red: 0.522, green: 0.533, blue: 0.541)
	static let williams = (red: 0.196, green: 0.400, blue: 0.831)
}

enum ConstructorLikeColor {
	static let mclaren = Color.black
	static let mercedes = Color.black
	static let red_bull = Color.red
}

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
		return fullName.trimmingCharacters(in: .whitespaces)
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
