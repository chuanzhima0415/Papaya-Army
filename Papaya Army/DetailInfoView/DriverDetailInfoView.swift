//
//  DriverDetailView.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/4/5.
//

import SwiftUI

struct DriverDetailInfoView: View {
	var driverDetail: DriverDetailInfo
	var body: some View {
		VStack {
			Text("\(driverDetail.firstName + " " + driverDetail.lastName)")
			Text("\(driverDetail.nationality)")
		}
		.font(.headline.weight(.bold))
	}
}

#Preview {
	DriverDetailInfoView(driverDetail: DriverDetailInfo(
		firstName: "xxx",
		lastName: "xxx",
		nationality: "xxx",
		shortName: "xxx",
		birthday: "xxx-xxx-xxx",
		number: 4,
		url: "xxxx"
	))
}
