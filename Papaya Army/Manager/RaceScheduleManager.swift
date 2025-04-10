//
//  RaceScheduleManager.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/4/9.
//

import Foundation

struct RaceScheduleManager {
	static let shared = RaceScheduleManager()

	struct RaceTime: Codable {
		var firstPractice: Date // 一练时间：YY-MM-DD xx:xx:xx
		var secondPractice: Date? // 二练时间：YY-MM-DD xx:xx:xx
		var thirdPractice: Date? // 三练时间：YY-MM-DD xx:xx:xx
		var sprintQualifying: Date? // 冲刺排位赛时间：YY-MM-DD xx:xx:xx
		var sprint: Date? // 冲刺赛时间：YY-MM-DD xx:xx:xx
		var qualifying: Date // 排位赛时间：YY-MM-DD xx:xx:xx
		var race: Date // 正赛时间：YY-MM-DD xx:xx:xx
		
		init(firstPractice: Date, secondPractice: Date?, thirdPractice: Date?, sprintQualifying: Date?, sprint: Date?, qualifying: Date, race: Date) {
			self.firstPractice = firstPractice
			self.secondPractice = secondPractice
			self.thirdPractice = thirdPractice
			self.sprintQualifying = sprintQualifying
			self.sprint = sprint
			self.qualifying = qualifying
			self.race = race
		}
	}

	/// 只保存每场比赛的举行日期、地点、第几场……，总之，不会保存每场比赛的结果
	struct RaceSchedule: Codable {
		var country: String // 举办比赛的国家
		var round: Int // 比赛的站数
		var raceName: String // 比赛的站的名字
		var raceTime: RaceTime // 比赛（一练、二练、三练等）时间
		var circuitName: String // 赛道名称
	}

	func retrieveRaceSchedule(completionHandler: @escaping ([RaceSchedule]) -> Void) {
		DataRequestManager.shared.fetchRacesSchedule { races in
			completionHandler(races)
		}
	}
}
