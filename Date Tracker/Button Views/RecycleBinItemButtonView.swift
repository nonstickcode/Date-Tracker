//
//  RecycleBinItemButtonView.swift
//  Date Tracker
//
//  Created by Cody McRoy on 9/7/23.
//

import SwiftUI

struct RecycleBinItemButtonView: View {
    var item: Item?
    
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(Color.white)
            .frame(height: 60)
            .overlay(
                VStack(spacing: 3) {
                    if let item = item, let eventDate = item.eventDate {
                        HStack {
                            Text(item.name ?? "Unknown")
                                
                        }
                        
                        HStack {
                            Text(dateFormatter.string(from: eventDate))
                                .mainButtonTextStyle()
                        }
                    } else {
                        // Placeholder for no data
                        Text("No Data")
                            .foregroundColor(Color.gray)
                    }
                }
            )
            .padding(.top, 8)
            .padding([.leading, .trailing], 16)
    }
}


struct RecycleBinItemButtonView_Previews: PreviewProvider {
    static var previews: some View {
        RecycleBinItemButtonView()
    }
}
