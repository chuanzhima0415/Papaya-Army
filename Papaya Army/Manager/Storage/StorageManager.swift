//
//  StorageManager.swift
//  Papaya Army
//
//  Created by 马传智 on 2025/4/9.
//

import Foundation

/// 用来本地存储的库
struct StorageManager {
	struct UserDefault {
		static let shared = UserDefault()
		private var userDefault = UserDefaults.standard

		/// 把数据写进 NSUserDefault 里
		func saveDataToUserDefault(_ data: Codable, forKey key: String) {
			do {
				let encoder = JSONEncoder()
				let dataInJson = try encoder.encode(data)
				userDefault.set(dataInJson, forKey: key)
			} catch {
				assertionFailure()
			}
		}

		/// 把数据从 NSUserDefault 读出
		func loadDataFromUserDefault<T: Codable>(forKey key: String) -> T? {
			guard let dataInJson = userDefault.data(forKey: key) else { return nil }
			do {
				let decoder = JSONDecoder()
				let data = try decoder.decode(T.self, from: dataInJson)
				return data
			} catch {
				return nil
			}
		}
	}

	struct FileManagers<T: Codable> {
		let filename: String // 文件名
		var fileURL: URL { // 生成文件路径的 URL
			FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(filename, conformingTo: .json)
		}

		func saveDataToFileManager(_ data: T?) {
			do {
				let encoder = JSONEncoder()
				let dataInJson = try encoder.encode(data)
				try dataInJson.write(to: fileURL)
			} catch {
				assertionFailure()
			}
		}

		func loadDataFromFileManager() -> T? {
			do {
				let dataInJson = try Data(contentsOf: fileURL)
				let decoder = JSONDecoder()
				let data = try decoder.decode(T.self, from: dataInJson)
				return data
			} catch {
				return nil
			}
		}
	}
}
