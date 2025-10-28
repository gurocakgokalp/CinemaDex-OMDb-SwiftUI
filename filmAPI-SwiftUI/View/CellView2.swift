//
//  CellView.swift
//  filmAPI-SwiftUI
//
//  Created by Gökalp Gürocak on 27.10.2025.
//

import SwiftUI

struct ImageViewFilm: View {
    var imageURL: String = "https://m.media-amazon.com/images/M/MV5BZmM4NzZiMzctM2M3OS00MWNhLWFiYzQtODRjMTEzYWVmMTc4XkEyXkFqcGc@._V1_SX300.jpg"
    @ObservedObject var imageDClient = ImageDownloadClient()
    
    init(image: String) {
        self.imageURL = image
        self.imageDClient.downloadImage(url: image)
    }
    
    var body: some View {
            checkImage()
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 30)).shadow(radius: 0)
        
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
    
}
