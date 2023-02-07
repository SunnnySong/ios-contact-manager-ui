//
//  ModelData.swift
//  ContactManagerUI
//
//  Created by 송선진 on 2023/02/01.
//

import Foundation

final class ModelData {
    // TODO: Error 처리하기
    let fileName = "contacts.json"
    var fileURL: URL? {
        return Bundle.main.url(forResource: fileName, withExtension: nil)
    }
    
    lazy var contacts: [UserInfo] = (try? load(fileURL: fileURL)) ?? []
}

func load<T: Decodable>(fileURL: URL?) throws -> T {
    let data: Data
    
    guard let fileURL = fileURL else {
        throw ContactError.FileNotFound
    }
    
    do {
        data = try Data(contentsOf: fileURL)
    } catch {
        throw ContactError.FileNotLoad
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        throw ContactError.FileNotParse
    }
}
    
func write<T: Encodable>(fileURL: URL?, newData: T) throws {
    
    guard let fileURL = fileURL else {
        throw ContactError.FileNotFound
    }
    
    do {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        let updatedData = try encoder.encode(newData)
        try? updatedData.write(to: fileURL)
    } catch {
        throw ContactError.FileNotParse
    }
}
