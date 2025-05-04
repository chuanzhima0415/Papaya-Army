//
//  FontStyles.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/5/3.
//

import Foundation
import SwiftUI

extension Font {
	static var constructorStandingPosFont: Font {
		Font.custom("Hiragino Kaku Gothic Std W8", size: 28)
	}

	static var sheetNavTitleFont: Font {
		Font.custom("Seymour One", size: 22)
	}

	static var sheetStageFont: Font {
		Font.custom("Sansita One", size: 17)
	}

	static var sheetCircuitNameFont: Font {
		Font.custom("Seymour One", size: 15)
	}

	static var sheetCircuitInfoFont: Font {
		Font.custom("Seymour One", size: 15)
	}

	static var sheetCircuitLengthUnitFont: Font {
		Font.custom("Seymour One", size: 11)
	}
	
	static var sheetStartTimeOfStageFont: Font {
		Font.custom("Racing Sans One", size: 11)
	}
}
