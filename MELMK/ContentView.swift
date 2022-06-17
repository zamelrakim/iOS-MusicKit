//
//  ContentView.swift
//  MELMK
//
//  Created by Zamel Rakim on 10/8/20.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var amapi = AMAPI()
    @State var isShowingMusic = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                AddToQueue(amapi: amapi, isShowingMusic: $isShowingMusic)
                Player(amapi: amapi)
                Spacer()
                
                ListQueue(amapi: amapi)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
