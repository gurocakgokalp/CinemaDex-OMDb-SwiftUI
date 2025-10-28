//
//  ContentView.swift
//  filmAPI-SwiftUI
//
//  Created by Gökalp Gürocak on 27.10.2025.
//

import SwiftUI

enum TabViewSelection {
    case Home
    case Favourite
    case Search
}

struct ContentView: View {
    @State var tabState: TabViewSelection = .Home
    @ObservedObject var mainViewModel = MovieMainViewModel()
    @ObservedObject var mainViewModel2 = MovieMainViewModel()
    @ObservedObject var mainViewModel3 = MovieMainViewModel()
    let tempMovie = idSearchingMovieViewModel(movie: idSearchFilmsResult(Title: "...", Year: "...", imdbID: "...", imdbRating: "...", Type: "...", Poster: "...", Rated: "...", Released: "...", Runtime: "...", Genre: "...", Writer: "...", Director: "...", Plot: "...", Actors: "...", Response: "..."))
    @State var searching: String = ""
    
    var body: some View {
        TabView(selection: $tabState) {
            Tab("Home", systemImage: "house", value: .Home) {
                NavigationStack {
                    List {
                        Section(header: Text("Featured Films")) {
                            ScrollView(.horizontal, showsIndicators: false){
                                HStack {
                                    NavigationLink(destination: DetailView(id: mainViewModel.movieDetail?.imdbId ?? "")) {
                                        CellView(vm: mainViewModel.movieDetail ?? tempMovie)
                                    }
                                    NavigationLink(destination: DetailView(id: mainViewModel2.movieDetail?.imdbId ?? "")) {
                                        CellView(vm: mainViewModel2.movieDetail ?? tempMovie)
                                    }
                                    NavigationLink(destination: DetailView(id: mainViewModel3.movieDetail?.imdbId ?? "")) {
                                        CellView(vm: mainViewModel3.movieDetail ?? tempMovie)
                                    }
                                }.scrollTargetLayout()
                            }
                        }
                        
                    }.navigationTitle("Find Movies, TV Shows").scrollIndicators(.never)
                }.onAppear{
                    Task {
                        await mainViewModel.fetchId(id: "tt7991608")
                        await mainViewModel2.fetchId(id: "tt1193516")
                        await mainViewModel3.fetchId(id: "tt7399138")
                    }
                }
            }
            Tab("About", systemImage: "info.circle", value: .Favourite) {
                
            }
            Tab(value: .Search ,role: .search) {
                NavigationStack {
                    ScrollView{
                        
                        ForEach(mainViewModel.movies) { movie in
                            NavigationLink(destination: DetailView(id: movie.imdbId), label: {
                                    HStack{
                                        ImageViewFilm(image: movie.poster).frame(width: 100)
                                        VStack(alignment: .leading, spacing: 1){
                                            Text(movie.title).font(.title2).bold().foregroundStyle(.primary).foregroundStyle(.white)
                                            Text("\(movie.year) - \(movie.type)").foregroundStyle(.gray)
                                        }.padding()
                                        Spacer()
                                    }
                                })
                            }
                        
                    }.padding([.top, .leading, .trailing])

                    .navigationTitle("Search")
                        .searchable(text: $searching)
                        .onChange(of: searching){
                            Task {
                                await mainViewModel.fetchSearchng(title: searching)
                            }
                        }
                }
            }
        }.tabBarMinimizeBehavior(.onScrollDown)
    }
    
}



#Preview {
    ContentView()
}
