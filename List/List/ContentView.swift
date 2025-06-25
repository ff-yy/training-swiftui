//
//  ContentView.swift
//  List
//
//  Created by Mac on 2025/06/26.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                ForEach(Animal.allCases, id: \.self) { animal in
                    NavigationLink(destination: DetailView(animal: animal)) {
                        HStack {
                            Image(animal.iconName)
                            Text(animal.name)
                        }
                    }
                }
            }
            .navigationTitle("動物")
        }
    }
}


#Preview {
    ContentView()
}

