//
//  DetailView.swift
//  filmAPI-SwiftUI
//
//  Created by Gökalp Gürocak on 27.10.2025.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var mainViewModel = MovieMainViewModel()
    @ObservedObject var imageDClient = ImageDownloadClient()
    var imdbId = String()
    //burasi hatali olabilir (dikkat)
    init(id: String) {
        self.imdbId = id
    }
    
    var body: some View {
        VStack {
            checkImage()
                .resizable().clipShape(RoundedRectangle(cornerRadius: 0)).opacity(0.8)
                .aspectRatio(contentMode: .fit).ignoresSafeArea().overlay(alignment: .bottom, content: {
                    RoundedRectangle(cornerRadius: 0)
                        .foregroundStyle(LinearGradient(stops: [
                            .init(color: .white.opacity(0), location: 0.1),
                            .init(color: colorScheme == .dark ? .black.opacity(1.5):.white.opacity(1.2), location: 1)
                        ]
                        , startPoint: .top, endPoint: .bottom))
                }).offset(y: -400).overlay{
                    HStack{
                        checkImage().resizable().aspectRatio(contentMode: .fit).frame(width: 130).clipShape(RoundedRectangle(cornerRadius:15)).shadow(radius: 20).overlay(alignment: .bottom, content: {
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundStyle(LinearGradient(stops: [
                                    .init(color: .white.opacity(0), location: 0.1),
                                    .init(color: colorScheme == .dark ? .black.opacity(0.8):.white.opacity(0), location: 1)
                                ]
                                , startPoint: .top, endPoint: .bottom))
                        })
                        Spacer()
                        VStack(alignment: .trailing) {
                            Text("\(mainViewModel.movieDetail?.type ?? "....") - \(mainViewModel.movieDetail?.runtime ?? "...")").bold().foregroundStyle(.gray).multilineTextAlignment(.trailing)
                            Text(mainViewModel.movieDetail?.title ?? "...").fontWeight(.heavy).font(.largeTitle)
                                .multilineTextAlignment(.trailing)
                            Text(mainViewModel.movieDetail?.released ?? "...")
                            
                            HStack{
                                Image("imdb").resizable().scaledToFit().frame(width: 30).clipShape(RoundedRectangle(cornerRadius: 10))
                                Text(mainViewModel.movieDetail?.imbdRating ?? "...").bold().foregroundStyle(.gray)
                            }
                            Text(mainViewModel.movieDetail?.genre ?? "...").bold().multilineTextAlignment(.trailing)
                        }
                    }.offset(y: -200).padding()
                }
                .overlay(alignment: .top) {
                        VStack {
                            HStack{
                                Text("Actors:").bold()
                                Spacer()
                                Text(mainViewModel.movieDetail?.actors ?? "..").foregroundStyle(.gray)
                                    .multilineTextAlignment(.trailing)
                            }
                            HStack{
                                Text("Director:").bold()
                                Spacer()
                                Text(mainViewModel.movieDetail?.Director ?? "...").foregroundStyle(.gray)
                                    .multilineTextAlignment(.trailing)
                                
                            }
                            HStack{
                                Text("Writer:").bold()
                                Spacer()
                                Text(mainViewModel.movieDetail?.writer ?? "...").foregroundStyle(.gray)
                                    .multilineTextAlignment(.trailing)
                            }
                            Spacer(minLength: 40)
                            ScrollView {
                                Text(mainViewModel.movieDetail?.Plot ?? "..")
                            }
                            
                        }.padding().offset(y: 220)
                }
            
        }.onAppear{
            print("Started")
            Task {
                await mainViewModel.fetchId(id: imdbId)
                if let posterURL = mainViewModel.movieDetail?.poster {
                                    imageDClient.downloadImage(url: posterURL)
                }
            }
        }
    }
    func checkImage() -> Image{
        if let data = self.imageDClient.gelenData {
            return Image(uiImage: UIImage(data: data) ?? UIImage(named: "rednotice")!)
        } else {
            print("didnot come data")
            return Image("rednotice")
        }
    }
}

#Preview {
    DetailView(id: "")
}
