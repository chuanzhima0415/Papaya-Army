//
//  CircuitInfoManager.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/4/26.
//

import Foundation

struct Circuit: Codable, Equatable {
	var circuitId: String
	var circuitName: String
	var country: String
	var city: String
	var circuitLength: String
	var lapRecord: String
	var firstParticipationYear: Int
	var corners: Int
	var fastestLapDriverId: String
	var fastestLapTeamId: String
	var fastestLapYear: Int
	var url: String
}
