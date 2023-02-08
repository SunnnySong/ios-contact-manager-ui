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
    var filePath: String { get }
    var fileURL: URL? { get }

    associatedtype T: Codable
    var data: [T] { get }
    func load() throws -> T
    func save(data: [T]) throws
}

extension DataSourceFromJSON {
    var fileURL: URL? { Bundle.main.url(forResource: filePath, withExtension: nil) }

    func load<T: Decodable>() throws -> T {
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

    func save<T:Encodable>(data: [T]) throws {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        guard let fileURL else {
            throw JSONError.FileNotFound
        }
        
        let JSONData = try encoder.encode(data)
        try JSONData.write(to: fileURL)
    }
}
