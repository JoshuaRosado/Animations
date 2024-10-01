//
//  ContentView.swift
//  Animations
//
//  Created by Joshua Rosado Olivencia on 9/27/24.
//

import SwiftUI

struct ContentView: View {
    @State private var dragAmount = CGSize.zero // current location

    
    let letters = Array("Hello SwiftUI")
    @State private var enabled = false
    @State private var dragAmount2 = CGSize.zero
    
    
    var body: some View {
        Section{

            LinearGradient(colors: [.yellow, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
                .frame(width: 300, height: 200)
                .clipShape(.rect(cornerRadius: 10))
                .offset(dragAmount) // which lets us adjust the X and Y coordinate of a view without moving other views around it.
                .gesture( // inside of gesture
                    DragGesture() // Built in dragGesture func
                        .onChanged{ dragAmount = $0.translation} // can be move any where
                        .onEnded{_ in
                            // ADDING animation when it's released ONLY
                            withAnimation(.bouncy) {
                                dragAmount = .zero} // when released it will go back to the default location
                        }
                )
            // ADDING animation to the whole body
            //            .animation(.spring(duration:0.4, bounce: 0.6), value: dragAmount)
        }
        Section{
            HStack(spacing: 0) {
                ForEach( 0..<letters.count, id: \.self) { // For each letter from 0 up to letters total count
                    num in // one number coming in
                    Text(String(letters[num])) // display a string of the array[index]
                        .padding(5)
                        .font(.title)
                        .background(enabled ? .blue: .red)
                        .offset(dragAmount2)
                    // ADDING animation, linear with a delay that goes +1 / 20 every time it loops
                        .animation(.linear.delay(Double(num) / 20),value: dragAmount2)
                    
                }
            }
            .gesture(
                DragGesture()
                    .onChanged { dragAmount2 = $0.translation}
                    .onEnded{ _ in
                        dragAmount2 = .zero
                        enabled.toggle()
                    }
            )
            
            
            
            
        }
    }
}

#Preview {
    ContentView()
}
