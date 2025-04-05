//
//  DriverDetailView.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/4/5.
//

import SwiftUI

struct DriverDetailView: View {
	var driverNumber: Int
	@State var driver: Driver?
    var body: some View {
		VStack {
			Text("\(driver?.fullName ?? "unknown"): \(driver?.nationality ?? "unknown")")
		}
		.onAppear {
			DriverManager.shared.retrieveDriverInfo(driverNumber: driverNumber) { driver in
				self.driver = driver
			}
		}
    }
}

#Preview {
	DriverDetailView(driverNumber: 4)
}
