// 
//  ImageView.swift
//
//  Created by Den Jo on 2021/03/20.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI
import Combine

struct ImageView: View {
    
    // MARK: - Value
    // MARK: Public
    var url: URL? = nil
    
    // MARK: Private
    @State private var cancelable: AnyCancellable? = nil
    @State private var image: UIImage?             = nil
    @State private var isProgressing               = false
    
    // MARK: - View
    // MARK: Public
    var body: some View {
        ZStack {
            if let image = image {
                GeometryReader {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: $0.size.width, height: $0.size.height)
                }
            }
            
            if isProgressing {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(1, anchor: .center)
            }
        }
        .onAppear {
            isProgressing = true

            cancelable = ImageDataManager.shared.download(url: self.url)
                .sink(receiveCompletion: { error in
                    
                }, receiveValue: {
                    self.isProgressing = false
                    self.image = $0
                })
        }
        .onDisappear {
            cancelable?.cancel()
        }
    }
}

#if DEBUG
struct ImageView_Previews: PreviewProvider {
    
    static var previews: some View {
        let view = ImageView()
        
        Group {
            view
                .previewDevice("iPhone 8")
                .preferredColorScheme(.light)
            
            view
                .previewDevice("iPhone 12")
                .preferredColorScheme(.dark)
        }
    }
}
#endif
