//
//  ContentView.swift
//  Animations
//
//  Created by Joshua Rosado Olivencia on 9/27/24.
//

import SwiftUI


// Creating OUR OWN custom view modifier to be able to use it how many times we want

struct CornerRotateModifier: ViewModifier{ // view modifier
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View{ // function
        content
        .rotationEffect(.degrees(amount), anchor:anchor)// rotation with custom .degree and anchor
        .clipped()// clipped to maintain it inside the object
    }
}

extension AnyTransition{ // extension of the func to be use
    static var pivot: AnyTransition{ // named pivot
        // modifier with constant inserted
        // starting at -90 degrees anchored at top left side
        .modifier(active: CornerRotateModifier(amount: -90, anchor: .topLeading),
                  identity: CornerRotateModifier(amount: 0, anchor: .topTrailing))
        // ending at 0 degrees anchored at top right side
        //
    }
}

struct ContentView: View {
    @State private var isShowingRed = false
    
    var body: some View {
        ZStack {
            Rectangle() // create rectangle shape
                .fill(.blue) // filled in with blue color
                .frame(width: 200, height: 200) // size
            
            if isShowingRed { // if Bool is true
                Rectangle() // create a rectangle shape
                .fill(.red) // filled with red color
                .frame(width: 200, height: 200) // size
                .transition(.pivot) // adding transition of ".pivot"
                // ".pivot" = Modifier that we created
            }
        }
        .onTapGesture { // add a gesture when we tap the button
            withAnimation { // with animation included when
                isShowingRed.toggle() // we toggle bool (false to true and true to false
            }
        }
        
    }
}

#Preview {
    ContentView()
}
