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
                if let item = amapi.nowPlayingItem {
                    Image(uiImage: (item.artwork?.image(at: CGSize(width: 80, height: 80)))!)
                    Text(item.title ?? "")
                    Text(item.albumArtist ?? "")
                    HStack() {
                        Image(systemName:"backward.fill")
                        Image(systemName:"play.fill")
                        Image(systemName:"forward.fill")
                    }
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
