//
//  ContentView.swift
//  MELMK
//
//  Created by Zamel Rakim on 10/8/20.
//

import SwiftUI
import MediaPlayer

struct ContentView: View {
    @ObservedObject var amapi = AMAPI()
    @State var isShowingMusic = false
    @State var isShowingQueue = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                AddToQueue(amapi: amapi, isShowingMusic: $isShowingMusic)
                Player(amapi: amapi)
                Spacer()
                
                Button(action: {self.isShowingQueue.toggle()}) {
                    Text("Queue")
                }
                .sheet(isPresented: self.$isShowingQueue) {
                    if (amapi.queue != nil && amapi.queue?.count != 0) {
                        List(amapi.queue!, id: \.persistentID) { track in
                            Text(track.value(forProperty: MPMediaItemPropertyTitle) as! String)
                            Text(track.value(forProperty: MPMediaItemPropertyArtist) as! String)
                        }
                    } else {
                        Text("Queue Empty")
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
