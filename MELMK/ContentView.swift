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
            VStack(alignment: .leading) {
                let authStr = amapi.isAuthorized ? "Music Authorized" : "Music Is Not Authorized"
                Text(authStr)
                Button(action: {self.isShowingMusic.toggle()}) {
                    Text("Select Music")
                } .sheet(isPresented: $isShowingMusic){
                    MediaPickerController(delegateObj: amapi)
                }
                if let img = amapi.nowPlayingItem {
                    Image(uiImage: (img.artwork?.image(at: CGSize(width: 100, height: 100)))!)
                }
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
