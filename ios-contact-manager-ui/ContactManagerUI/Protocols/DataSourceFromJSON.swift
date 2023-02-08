//
//  DataSourceFromJSON.swift
//  ContactManagerUI
//
//  Created by sei_dev on 2/8/23.
//

import Foundation

enum JSONError: Error {
    case FileNotParse
    case FileNotFound
    case FileNotLoad
}

protocol DataSourceFromJSON {
    static var filePath: String { get }
    static var fileURL: URL? { get }

    associatedtype T: Codable
    static var data: [T] { get }
    static func load() throws -> T
    static func save(data: [T]) throws
}

extension DataSourceFromJSON {
    static var fileURL: URL? { Bundle.main.url(forResource: filePath, withExtension: nil) }

    static func load<T: Decodable>() throws -> T {
        let data: Data
        guard let url = fileURL else {
            throw JSONError.FileNotFound
        }

        do {
            data = try Data(contentsOf: url)
        } catch {
            throw JSONError.FileNotLoad
        }

        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            throw JSONError.FileNotParse
        }
    }

    static func save<T:Encodable>(data: [T]) throws {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        guard let fileURL else {
            throw JSONError.FileNotFound
        }
        
        let JSONData = try encoder.encode(data)
        try JSONData.write(to: fileURL)
    }
}
