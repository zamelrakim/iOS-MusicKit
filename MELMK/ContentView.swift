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
            VStack(alignment: .center) {
                if amapi.isAuthorized {
                    Button(action: {self.isShowingMusic.toggle()}) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 40.0, height: 40.0)
                    } .sheet(isPresented: $isShowingMusic){
                        MediaPickerController(delegateObj: amapi)
                    }
                } else {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .foregroundColor(.gray)
                        .frame(width: 40.0, height: 40.0)
                }
                if let item = amapi.nowPlayingItem {
                    Image(uiImage: (item.artwork?.image(at: CGSize(width: 80, height: 80)))!)
                    Text(item.title ?? "")
                    Text(item.albumArtist ?? "")
                    HStack(alignment: .center, spacing: 2.0) {
                        Button(action: amapi.startOrPrev) {
                            Image(systemName: "backward.fill")
                                .font(.largeTitle)
                        }
                        let imgSysName = (amapi.player!.playbackState.rawValue == 1) ? "pause.fill" : "play.fill"
                        Button(action: amapi.playPause) {
                            Image(systemName:imgSysName)
                                .font(.largeTitle)
                                .padding(.horizontal, 50)
                        }
                        Button(action: amapi.player!.skipToNextItem) {
                            Image(systemName:"forward.fill")
                                .font(.largeTitle)
                        }
                    }
                    .padding()
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
