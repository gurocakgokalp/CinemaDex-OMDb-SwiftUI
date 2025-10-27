//
//  ContentView.swift
//  filmAPI-SwiftUI
//
//  Created by Gökalp Gürocak on 27.10.2025.
//

import SwiftUI

struct ContentView: View {
    @State var SearchViewModel: tableSearchingFilmViewModel?
    
    var body: some View {
        VStack {
            Button {
                Task {
                    await fetchDatas()
                }
            } label: {
                Text("Fetch Datas")
            }

        }
        .padding()
    }
    
    func fetchDatas() async {
        do {
            let fetchedData = try await Webservice().fetchSearchingDatas(url: "https://www.omdbapi.com/?s=recep&apikey=aac83354")
            self.SearchViewModel = tableSearchingFilmViewModel(movieArray: fetchedData.Search)
            print("Fetched: \(fetchedData.totalResults)")
        } catch let error{
            print("1: \(error.localizedDescription)")
        }
        
    }
}



#Preview {
    ContentView()
}
