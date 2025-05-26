//
//  TabModel.swift
//  FloatingTabBar
//
//  Created by 马传智 on 2025/5/7.
//

import SwiftUI

enum TabModel: Hashable {
	case schedule, standing
	
	var iconName: String {
		switch self {
		case .schedule:
			return "calendar"
		case .standing:
			return "trophy"
		}
	}
	
	var title: String {
		switch self {
		case .schedule:
			return "schedule"
		case .standing:
			return "standing"
		}
	}
	
	var color: Color {
		switch self {
		case .schedule:
			return .red
		case .standing:
			return .secondary
		}
	}
}
