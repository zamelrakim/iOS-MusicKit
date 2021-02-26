//
//  Player.swift
//  MELMK
//
//  Created by Zamel Rakim on 2/25/21.
//

import SwiftUI

struct Player: View {
    @ObservedObject var amapi: AMAPI
    
    var body: some View {
        if let item = amapi.nowPlayingItem {
            Image(uiImage: (item.artwork?.image(at: CGSize(width: 80, height: 80)))!)
            Text(item.title ?? "")
            Text(item.albumArtist ?? "")

            PlayerControls(amapi: amapi)
                .padding()
        }
    }
}

struct Player_Previews: PreviewProvider {
    static var previews: some View {
        Player(amapi: AMAPI())
    }
}
