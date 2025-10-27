//
//  ContentView.swift
//  filmAPI-SwiftUI
//
//  Created by Gökalp Gürocak on 27.10.2025.
//

import SwiftUI

struct ContentView: View {
    @State var SearchViewModel: tableSearchingFilmViewModel?
    @State var searchingString: String? = "Kutsal"
    
    var body: some View {
        VStack {
            Button {
                
            } label: {
                Text("Fetch Datas")
            }

        }
        .padding()
    }
    
}



#Preview {
    ContentView()
}
