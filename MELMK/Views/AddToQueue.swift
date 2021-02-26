//
//  AddToQueue.swift
//  MELMK
//
//  Created by Zamel Rakim on 2/25/21.
//

import SwiftUI

struct AddToQueue: View {
    @ObservedObject var amapi: AMAPI
    @Binding var isShowingMusic: Bool
    
    var body: some View {
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
    }
}

struct AddToQueue_Previews: PreviewProvider {
    static var previews: some View {
        AddToQueue(amapi: AMAPI(), isShowingMusic: .constant(false))
    }
}
