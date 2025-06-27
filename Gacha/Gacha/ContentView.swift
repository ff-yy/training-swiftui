//
//  ContentView.swift
//  Gacha
//
//  Created by Mac on 2025/06/27.
//

import SwiftUI

struct ContentView: View {
    @State var showSheet = false

    var body: some View {
        ZStack {
            Image("gacha")
                .resizable()
                .ignoresSafeArea()
            Button {
                showSheet = true
            } label: {
                Image("Presentbox")
                    .resizable()
                    .scaledToFit()
            }
        }
        .fullScreenCover(isPresented: $showSheet) {
            ResultView()
        }

    }
}

#Preview {
    ContentView()
}
