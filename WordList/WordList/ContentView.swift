//
//  ContentView.swift
//  WordList
//
//  Created by Mac on 2025/06/27.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 32) {
                Text("My単語帳")
                    .font(.largeTitle)
                
                NavigationLink {
                    QuizView()
                } label: {
                    Text("QUIZ START")
                        .font(.title)
                        .foregroundStyle(.white)
                        .padding(.vertical, 12)
                        .frame(maxWidth: .infinity)
                        .background(Color.orange)
                        .clipShape(.capsule)
                }
                
                NavigationLink {
                    WordListView()
                } label: {
                    Text("単語一覧")
                        .font(.title)
                        .foregroundStyle(.white)
                        .padding(.vertical, 12)
                        .frame(maxWidth: .infinity)
                        .background(Color.orange)
                        .clipShape(.capsule)
                }
            }
            .padding(.horizontal, 60)
        }
    }
}

#Preview {
    ContentView()
}
