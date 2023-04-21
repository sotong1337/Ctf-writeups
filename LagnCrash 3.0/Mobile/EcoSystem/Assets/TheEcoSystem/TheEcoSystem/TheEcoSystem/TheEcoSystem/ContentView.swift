//
//  ContentView.swift
//  The EcoSystem
//
//  Created by Carl Ian Voller on 5/10/22.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var viewController: RootViewController
        
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "pencil")
                    .font(.system(size: 50))
                    .foregroundColor(Color.white)
                    .foregroundColor(.accentColor)
                    .padding(.trailing, 40)
                VStack {
                    Text("The World's first Cross Platform completely private notes app!")
                        .font(.system(size: 15))
                    HStack {
                        Image(systemName: "iphone")
                        Image(systemName: "ipad")
                        Image(systemName: "applewatch")
                        Image(systemName: "laptopcomputer")
                    }
                    .padding(.top, 1)
                }
            }
            .padding(.bottom, 5)
            Text("We will automatically handoff your notes to your other Apple devices for you!\nGo ahead! Try it!")
                .multilineTextAlignment(.center)
            TextField(text: $viewController.text) {
                
            }
                .padding(10)
                .background(Color.black)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewController: RootViewController())
    }
}
