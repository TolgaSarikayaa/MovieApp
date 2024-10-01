//
//  MainView.swift
//  MovieApp
//
//  Created by Tolga Sarikaya on 19.07.24.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Quiz Game", systemImage: "gamecontroller.fill")
                }
//            MoviesView()
//                .tabItem {
//                    Label("Search", systemImage: "magnifyingglass.circle.fill")
//                }
        }
    }
}


