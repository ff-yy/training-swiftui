//
//  ResultView.swift
//  Gacha
//
//  Created by Mac on 2025/06/27.
//

import SwiftUI

struct ResultView: View {
    @Environment(\.dismiss) var dismiss
    @State var backGroundImageName: String = "bgRed"
    @State var characterImageName: String = "iphone"
    @State var star: String = "⭐️⭐️"
    @State private var imageOffset = 0.0
    let animationHeight: CGFloat = -50
    var body: some View {
        ZStack {
            Image(backGroundImageName)
                .resizable()
                .ignoresSafeArea()
            Image(characterImageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 350, height: 350)
                .offset(y: CGFloat(imageOffset) - 50)
                .onAppear {
                    withAnimation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true)){
                        imageOffset = animationHeight
                    }
                }
            VStack {
                HStack {
                    Button("閉じる") {
                        dismiss()
                    }
                    .padding(40)
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    .font(.title)
                    Spacer()
                }
                Spacer()
                Text(star)
                    .font(.largeTitle)
                    .padding(.bottom, 50)
            }
        }
        .onAppear{
            let number = Int.random(in: 0..<9)
            print(number)
            switch number {
            case 9:
                //乱数が9だった時の処理
                backGroundImageName = "bgBlue"
                characterImageName = "IoTMesh"
                star = "⭐️⭐️⭐️⭐️⭐️"
            case 8:
                //乱数が8だった時の処理
                backGroundImageName = "bgGreen"
                characterImageName = "camera"
                star = "⭐️⭐️⭐️⭐️"
            case 0...7:
                //乱数が0から7だった時の処理
                backGroundImageName = "bgRed"
                characterImageName = "iphone"
                star = "⭐️⭐️"
            default:
                //デフォルトの処理(今回は使わないよ！)
                backGroundImageName = ""
                characterImageName = ""
                star = ""
            }
        }

    }
}

#Preview {
    ResultView()
}
