//
//  PlayerControls.swift
//  MELMK
//
//  Created by Zamel Rakim on 2/25/21.
//

import SwiftUI

struct PlayerControls: View {
    @ObservedObject var amapi: AMAPI
    
    var body: some View {
        HStack(alignment: .center, spacing: 2.0) {
            Button(action: amapi.startOrPrev) {
                Image(systemName: "backward.fill")
                    .font(.largeTitle)
            }
            let imgSysName = (amapi.isPlaying ?? false) ? "pause.fill" : "play.fill"
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
    }
}

struct PlayerControls_Previews: PreviewProvider {
    static var previews: some View {
        PlayerControls(amapi: AMAPI())
    }
}
