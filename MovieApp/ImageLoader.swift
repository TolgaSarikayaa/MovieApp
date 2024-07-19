//
//  ImageLoader.swift
//  MovieApp
//
//  Created by Tolga Sarikaya on 19.07.24.
//

import Foundation
import SwiftUI
import Combine


class ImageLoader: ObservableObject {
    @Published var image: UIImage?
       private var url: URL?
       private var cancellable: AnyCancellable?

       init(url: URL?) {
           self.url = url
       }
    
    func load() {
        guard let url = url else {return}
        
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)
    }
    
    deinit {
        cancellable?.cancel()
    }

}

struct SearchResponse: Decodable {
    let search: [Movie]
}
