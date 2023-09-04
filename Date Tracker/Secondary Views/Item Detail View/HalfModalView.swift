//
//  HalfModalView.swift
//  Date Tracker
//
//  Created by Cody McRoy on 9/4/23.
//

import SwiftUI

struct HalfModalView<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                VStack {
                    self.content
                }
                .frame(width: geometry.size.width, height: geometry.size.height * 0.3)
                .background(Color.white)
                .cornerRadius(20)
                .shadow(radius: 30)
                Spacer()
            }
            .background(Color.clear.edgesIgnoringSafeArea(.all))
        }
       
    }
}



//struct HalfModalView_Previews: PreviewProvider {
//    static var previews: some View {
//        HalfModalView()
//    }
//}
