//
//  Movie.swift
//  filmAPI-SwiftUI
//
//  Created by Gökalp Gürocak on 27.10.2025.
//
import Foundation

//isme göre genel search fetch
struct SearchFilmsResult: Decodable {
    let Response: String
    let Search: [SearchingFilm]
    let totalResults: String
}

struct SearchingFilm: Decodable {
    let Title: String
    let Year: String
    let imdbID: String
    let `Type`: String // iki tirnak icin aldim ya isim oluyor iste
    let Poster: String
}


//ID'ye göre veri cekme

struct idSearchFilmsResult: Decodable {
    let Title: String
    let Year: String
    let imdbID: String
    let imdbRating: String
    let `Type`: String
    let Poster: String
    let Rated: String
    let Released: String
    let Runtime: String
    let Genre: String
    let Writer: String
    let Director: String
    let Plot: String
    let Actors: String
    let Response: String
}

