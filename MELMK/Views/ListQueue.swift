//
//  ListQueue.swift
//  MELMK
//
//  Created by Zamel Rakim on 2/28/21.
//

import SwiftUI
import MediaPlayer

struct ListQueue: View {
    @ObservedObject var amapi = AMAPI()
    @State var isShowingQueue = false
    
    var body: some View {
        Button(action: {self.isShowingQueue.toggle()}) {
            Text("Queue")
        }
        .sheet(isPresented: self.$isShowingQueue) {
            if (amapi.queue != nil && amapi.queue?.count != 0) {
                List() {
                    ForEach(amapi.queue!, id: \.persistentID) { track in
                        Text("\(track.value(forProperty: MPMediaItemPropertyTitle) as! String)\n\(track.value(forProperty: MPMediaItemPropertyArtist) as! String)")
                    }
                    .onDelete(perform: amapi.removeFromQueue)
                }
            } else {
                Text("Queue Empty")
            }
        }
    }
}

struct ListQueue_Previews: PreviewProvider {
    static var previews: some View {
        ListQueue(amapi: AMAPI())
    }
}
