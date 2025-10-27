//
//  Webservice.swift
//  filmAPI-SwiftUI
//
//  Created by Gökalp Gürocak on 27.10.2025.
//
import Foundation

class Webservice {
    
    func fetchSearchingDatas (url: String) async throws -> SearchFilmsResult {
        let url = URL(string: url)
        let (data, _) = try await URLSession.shared.data(from: url!)
        let decoder = JSONDecoder()
        return try decoder.decode(SearchFilmsResult.self, from: data)
    }
    
    func fetchIDDatas (url: String) async throws -> idSearchFilmsResult {
        let url = URL(string: url)
        let (data, _) = try await URLSession.shared.data(from: url!)
        let decoder = JSONDecoder()
        return try decoder.decode(idSearchFilmsResult.self, from: data)
    }
}
