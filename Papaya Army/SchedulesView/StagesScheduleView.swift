//
//  StagesView.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/4/11.
//

import SwiftUI

/// 列举某一站的所有 stages
struct StagesScheduleView: View {
	var grandPrixSchedule: GrandPrixSchedule
	private var schedules: [(String, Date)] {
		var ret = [(stageName: String, startDate: Date)]()
		/*
		 child.label               child.value
		     race:                   StartDate
		     qualifying:             StartDate
		     practice1:              StartDate
		     practice2:              StartDate
		     practice3:              StartDate
		     sprintQualifying:       StartDate
		     sprintRace:             StartDate
		  */
		let mirror = Mirror(reflecting: grandPrixSchedule.stageSchedule)
		for child in mirror.children {
			if let stage = child.label, let startDate = (child.value as? StartDate)?.fullDate {
				ret.append((stage, startDate))
			}
		}
		return ret.sorted(by: { $0.startDate < $1.startDate })
	}

	var body: some View {
		NavigationStack {
			List(schedules, id: \.0) { stageName, startDate in
				HStack {
					if Date() >= startDate {
						NavigationLink {
							switch stageName {
							case "race":
								RaceResultView(year: "2025", round: grandPrixSchedule.round)
							case "qualifying":
								QualifyingResultView(year: "2025", round: grandPrixSchedule.round)
							case "practice1",
							     "practice2",
							     "practice3":
								PracticeNResultView(year: "2025", round: grandPrixSchedule.round, n: Int(String(stageName.last!))!)
							case "sprintQualifying":
								SprintQualifyingResultView(year: "2025", round: grandPrixSchedule.round)
							case "sprintRace":
								SprintRaceResultView(year: "2025", round: grandPrixSchedule.round)
							default:
								EmptyView()
							}
						} label: {
							VStack(alignment: .leading) {
								Text("\(stageNameFormatter(stage: stageName))")
									.font(.sheetStageFont)
								Text(dateFormatter(utcdate: startDate))
									.font(.sheetStartTimeOfStageFont)
							}
						}
					} else {
						VStack(alignment: .leading) {
							Text("\(stageNameFormatter(stage: stageName))")
								.font(.sheetStageFont)
							Text(dateFormatter(utcdate: startDate))
								.font(.sheetStartTimeOfStageFont)
						}
					}
				}
			}
			.navigationTitle(grandPrixSchedule.gpName)
		}
	}

	func stageNameFormatter(stage: String) -> String {
		guard let index = stage.firstIndex(where: { $0.isUppercase }) else { return stage.capitalized }
		return (stage[stage.startIndex ..< index] + " " + stage[index ..< stage.endIndex]).capitalized
	}
	
	func dateFormatter(utcdate: Date) -> String {
		let formatter = DateFormatter()
		formatter.dateFormat = "MM-dd HH:mm"
		formatter.timeZone = .current
		
		return formatter.string(from: utcdate)
	}
}

#Preview {
	StagesScheduleView(
		grandPrixSchedule: GrandPrixSchedule(
			gpId: "xxxx",
			stageSchedule: StageSchedule(race: StartDate(date: "2025-03-16", time: "04:00:00Z"), qualifying: StartDate(date: "2025-03-15", time: "05:00:00Z"), practice1: StartDate(date: "2025-03-14", time: "01:30:00Z"), practice2: StartDate(date: "2025-03-14", time: "05:00:00Z"), practice3: StartDate(date: "2025-03-15", time: "01:30:00Z"), sprintQualifying: StartDate(date: nil, time: nil), sprintRace: StartDate(date: nil, time: nil)),
			laps: 57,
			round: 1,
			circuit: Circuit(
				circuitId: "xxxx",
				circuitName: "xxxx",
				country: "xxxx",
				city: "xxxx",
				circuitLength: "xxxx",
				lapRecord: "xxxx",
				firstParticipationYear: 1,
				corners: 1,
				fastestLapDriverId: "xxxx",
				fastestLapTeamId: "xxxx",
				fastestLapYear: 1,
				url: "xxxx"
			)
		)
	)
}
