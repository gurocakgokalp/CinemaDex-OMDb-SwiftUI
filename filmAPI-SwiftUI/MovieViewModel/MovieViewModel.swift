//
//  MovieViewModel.swift
//  filmAPI-SwiftUI
//
//  Created by Gökalp Gürocak on 27.10.2025.
//

import Foundation
import SwiftUI

class MovieMainViewModel: ObservableObject {
    
    @Published var movies = [SearchingMovieViewModel]()
    @Published var movieDetail: idSearchingMovieViewModel?
    
    func fetchSearchng(title: String) async {
        do{
            let fetchedSearch = try await Webservice().fetchSearchingDatas(url: "https://www.omdbapi.com/?s=\(title)&apikey=aac83354")
            self.movies
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func fetchId(id: String) async {
        
    }
    
}

struct SearchingMovieViewModel: Identifiable {
    var id: String {
        return self.imdbId
    }
    
    let movie: SearchingFilm
    
    var title: String {
        return self.movie.Title
    }
    
    var year: String {
        return self.movie.Year
    }
    
    var imdbId: String {
        return self.movie.imdbID
    }
    
    var poster: String {
        return self.movie.Poster
    }
    
    var type: String {
        return self.movie.Type
    }
}

struct idSearchingMovieViewModel {
    let movie: idSearchFilmsResult
    var title: String {
        return self.movie.Title
    }
    var year: String {
        return self.movie.Year
    }
    var imdbId: String {
        return self.movie.imdbID
    }
    var poster: String {
        return self.movie.Poster
    }
    var type: String {
        return self.movie.Type
    }
    var imbdRating: String {
        return self.movie.imdbRating
    }
    var rated: String {
        return self.movie.Rated
    }
    var released: String {
        return self.movie.Released
    }
    var actors: String {
        return self.movie.Actors
    }
    var genre: String {
        return self.movie.Genre
    }
    var Director: String {
        return self.movie.Director
    }
    var writer: String {
        return self.movie.Writer
    }
    var Plot: String {
        return self.movie.Plot
    }
    var runtime: String {
        return self.movie.Runtime
    }
}
