//
//  DriverDetailView.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/4/5.
//

import SwiftUI

struct DriverDetailView: View {
//	var fileURL: StorageManager.FileManagers<DriverManager.DriverDetail> {
//		StorageManager.FileManagers(filename: "Driver\(driverNumber)'s detail")
//	}
//	var driverNumber: Int
//	@State var driverDetailInfo: DriverManager.DriverDetail?
//    var body: some View {
//		VStack {
//			Text("\(driverDetailInfo?.driverBasicInfo.fullName ?? "unknown"): \(driverDetailInfo?.driverBasicInfo.nationality ?? "unknown")")
//		}
//		.onAppear {
//			if let driverDetail = fileURL.loadDataFromFileManager() {
//				self.driverDetailInfo = driverDetail
//			} else {
//				DriverManager.shared.retrieveDriverInfo(driverNumber: driverNumber) {
//					fileURL.saveDataToFileManager($0)
//					self.driverDetailInfo = $0
//				}
//			}
//		}
//    }
	
	var body: some View {
		Text("hello world")
	}
}

#Preview {
//	DriverDetailView(driverNumber: 4)
	DriverDetailView()
}
