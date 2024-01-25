//
//  ContentView.swift
//  RandomNumber
//
//  Created by Thanadon Boontawee on 19/1/2567 BE.
//

// rest : manage all button for good touch
// rest : move number down to center of fruit
// rest : make good effect for all text in screen
// rest : move all layer down to center screen
// rest : Text("") x4 line should trans to better syntax
// rest : Config button
// rest : move button to frame border (no need to do)
// rest : add fade in frame (no need to do)

import SwiftUI
extension Color {
    init(hex: UInt) {
        self.init(
            .sRGB,
            red: Double((hex & 0xFF0000) >> 16) / 255.0,
            green: Double((hex & 0x00FF00) >> 8) / 255.0,
            blue: Double(hex & 0x0000FF) / 255.0
        )
    }
}

struct ContentView: View {
    @State var game = Game()
    @State var guess: Double = 0.0
    @State var showResult = false
    
    var body: some View {
        ZStack {
            Color(hex: 0xFFD524)
            
            VStack {
                // Main frame
                ZStack {
                    RoundedRectangle(cornerRadius: 19)
                        .fill(Color(hex: 0xFFD524))
                        .frame(width: 327, height: 449.8)
                    RoundedRectangle(cornerRadius: 19)
                        .stroke(Color(hex: 0xA85116), lineWidth: 13)
                        // Customize the border color and width
                        .frame(width: 327, height: 449.8)
                        // Set the width and height of the square
                        .overlay(
                            VStack{
                                Text("ROUND")
                                    .foregroundColor(Color(hex: 0xA85116))
                                    .font(Font.custom("Fredoka-Regular", size: 20))
                                    .padding(.top, 75)
//                                    .padding(.bottom, 10)
//                                    .padding(.leading, 150)
//                                    .padding(.trailing, 150)
                                ZStack {
                                    RoundedRectangle(cornerRadius: 19)
                                        .fill(Color(.white))
                                        // Customize the border color and width
                                        .frame(width: 278.9, height: 65.6)
                                    RoundedRectangle(cornerRadius: 19)
                                        .stroke(Color(hex: 0xA85116), lineWidth: 8)
                                        // Customize the border color and width
                                        .frame(width: 278.9, height: 65.6)
                                        // Set the width and height of the square
                                        .overlay(
                                            Text("\(game.count)")
                                                .font(Font.custom("Fredoka-Regular", size: 20))
                                        )
                                } .padding(.bottom, 10)


                                ZStack {
                                    // Background Image
                                    Image("fruit")
                                        .aspectRatio(contentMode: .fill)
                                        .edgesIgnoringSafeArea(.all)
                                    
                                    // Text on Top
                                    Text(String(Game.toint(val: guess)))
                                        .foregroundColor(.white)
                                        .font(Font.custom("Fredoka-Regular", size: 50))
                                        .padding(.top, 40)
                                }
                                HStack {
                                    Text("0")
                                        .padding(.trailing, 5)
                                    Slider(value: $guess)
                                        .frame(width: 200)
                                        .accentColor(Color(hex: 0xA85116))
                                    Text("100")
                                        .padding(.leading, 5)
                                }
                                Spacer()
                                Image("fade")
                            }
                        )
                    Image("green")
                        .aspectRatio(contentMode: .fill)
                        .edgesIgnoringSafeArea(.all)
                        .offset(y: -255)
                    
                    Image("group-tree")
                        .aspectRatio(contentMode: .fill)
                        .edgesIgnoringSafeArea(.all)
                        .offset(x:30, y: -370)
                    
                    ZStack{
                        Image("Group-title")
                            .aspectRatio(contentMode: .fill)
                            .edgesIgnoringSafeArea(.all)
                            
                        Text("Guess me\nwhat I am?")
                            .foregroundColor(.white)
                            .font(Font.custom("Fredoka-Regular", size: 25))
                    }.offset(y: -235)
                }.padding(.top, 200)
               
                ZStack {
                    Image("Group-button")
                        .aspectRatio(contentMode: .fill)
                        .edgesIgnoringSafeArea(.all)

                    Button("HIT ME!") {
                        showResult = true
                        game.check(guess: guess)
                    }.padding()
                    .alert(isPresented: $showResult) {
                        Alert(
                            title: Text("Your result"),
                            message: Text(game.text),
                            dismissButton: .default(Text("OK")) {
                                if game.correct {
                                    guess = 0
                                    game.startNewGame()
                                }
                            }
                        )
                    }
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
        .environment(\.font,
            Font.custom("Fredoka-Regular", size: 20))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
