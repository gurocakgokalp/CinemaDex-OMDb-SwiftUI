//
//  CellView.swift
//  filmAPI-SwiftUI
//
//  Created by Gökalp Gürocak on 27.10.2025.
//

import SwiftUI

struct CellView: View {
    var vm: idSearchingMovieViewModel?
    var imageURL = String()
    @ObservedObject var imageDClient = ImageDownloadClient()
    
    init(vm: idSearchingMovieViewModel) {
        self.vm = vm
        self.imageURL = vm.poster
        self.imageDClient.downloadImage(url: imageURL)
    }
    
    var body: some View {
        VStack {
            checkImage()
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 60)).shadow(radius: 10)
        }.overlay(alignment: .bottom, content: {
            RoundedRectangle(cornerRadius: 60)
                .foregroundStyle(LinearGradient(stops: [
                    .init(color: .white.opacity(0), location: 0.1),
                    .init(color: .black.opacity(1), location: 1)
                ]
                , startPoint: .top, endPoint: .bottom))
        })
        
        .overlay(alignment: .topTrailing, content: {
            Button(action: {
                let url = "https://www.imdb.com/title/\(vm?.imdbId ?? "")"
                UIApplication.shared.open(URL(string: url)!)
            }) {
                Image(systemName: "square.and.arrow.up").resizable().aspectRatio(contentMode: .fit).frame(width: 20)
            }
            .buttonStyle(.glass).offset(x: -30, y: 30)
        })

        .overlay(alignment: .bottomLeading) {
            VStack(alignment: .leading, spacing: 5) {
                Text(vm?.released ?? "2022").font(.system(size: 22)).foregroundStyle(.gray)
                Text(vm?.title ?? "Red").font(.system(size: 35).bold()).foregroundStyle(.white)
                HStack{
                    Image("imdb").resizable().scaledToFit().frame(width: 50).clipShape(RoundedRectangle(cornerRadius: 10))
                    Text(vm?.imbdRating ?? "7.6").font(.system(size: 30).bold()).foregroundStyle(.gray)
                }
                
            }.padding().offset(x: 30, y: -30)
        }
    }
    func checkImage() -> Image{
        if let data = self.imageDClient.gelenData {
            return Image(uiImage: UIImage(data: data) ?? UIImage(named: "rednotice")!)
        } else {
            return Image("rednotice")
        }
    }
    
}

#Preview {
    //CellView().previewLayout(.sizeThatFits)
}
