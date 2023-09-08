import SwiftUI

struct ButtonContent {
    let text: String
    let imageView: AnyView
}


struct ItemButtonView: View {
    var item: Item?
    
    @Binding var noDataPresent: Bool
    
    struct ButtonContent {
        let text: String
        let imageView: AnyView
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(Color.white)
            .frame(height: 60)
            .overlay(
                VStack(spacing: 3) {
                    if let item = item, let eventDate = item.eventDate {
                        let topLineContent = buttonContentTopLine(for: item, on: eventDate)
                        let bottomLineContent = buttonContentBottomLine(for: item, on: eventDate)
                        
                        
                        HStack {
                            Text(topLineContent.text)
                                .boldButtonTextStyle()
                            topLineContent.imageView
                        }
                        
                        HStack {
                            Text(bottomLineContent.text)
                                .mainButtonTextStyle()
                            bottomLineContent.imageView
                        }
                        
                        
                        
                    } else {
                        noDataView
                    }
                }
            )
            .onAppear(perform: checkForData)
            .padding(.top, 8)
            .padding([.leading, .trailing], 16)
    }
    
    private func checkForData() {
        if item == nil {
            noDataPresent = true
        }
    }
   

    
    private var noDataView: some View {
        VStack {
            Spacer()
            Text("No data available.")
                .emptyButtonBoldTextStyle()
            HStack {
                Text("Tap the ")
                    .emptyButtonTextStyle()
                Image(systemName: "plus.app")
                    .bold()
                    .padding(-6)
                Text(" to add a new event.")
                    .emptyButtonTextStyle()
            }
            Spacer()
        }
    }
    
    private func buttonContentTopLine(for item: Item, on eventDate: Date) -> ButtonContent {
        let name = item.name ?? "Unknown"
        let eventType = item.eventType ?? "Unknown"
        let daysUntil = daysUntilEvent(eventDate)
        
        if daysUntil == 365 && (eventType == "Birthday" || eventType == "Anniversary") {
            return ButtonContent (text: "\(name)'s \(eventType) was yesterday!", imageView: AnyView(Image(systemName: "figure.wave.circle").foregroundColor(.brown)))
        } else if daysUntil == 365 && (eventType == "Holiday" || eventType == "Vacation") {
            return ButtonContent (text: "\(name)'s \(eventType) was yesterday!", imageView: AnyView(Image(systemName: "figure.wave.circle.fill").foregroundColor(.purple)))
        } else if daysUntil == 0 && (eventType == "Birthday" || eventType == "Anniversary") {
            return ButtonContent (text: "\(name)'s \(eventType) is Today!", imageView: AnyView(Image(systemName: "party.popper.fill").foregroundColor(.purple)))
        } else if daysUntil == 0 && (eventType == "Holiday" || eventType == "Vacation") {
            return ButtonContent (text: "\(name)'s \(eventType) is Today!", imageView: AnyView(Image(systemName: "calendar.badge.exclamationmark").foregroundColor(.purple)))
        } else if daysUntil == 1 && (eventType == "Birthday" || eventType == "Anniversary") {
            return ButtonContent (text: "\(name)'s \(eventType) is Tomorrow!", imageView: AnyView(Image(systemName: "party.popper").foregroundColor(.purple)))
        } else if daysUntil == 1 && (eventType == "Holiday" || eventType == "Vacation") {
            return ButtonContent (text: "\(name)'s \(eventType) is Tomorrow!", imageView: AnyView(Image(systemName: "calendar.badge.clock").foregroundColor(.purple)))
        } else {
            return ButtonContent (text: "\(name)'s \(eventType) is in \(daysUntil) days", imageView: AnyView(EmptyView()))
        }
    }
    
    
    private func buttonContentBottomLine(for item: Item, on eventDate: Date) -> ButtonContent {
        let daysUntil = daysUntilEvent(eventDate)
        let isFutureEvent = eventDate > Date()
        let dateFormatterString = isFutureEvent ? dateFormatter.string(from: eventDate) : shortDateFormatter.string(from: eventDate)
        
        
        if daysUntil == 365 {
            return ButtonContent (text: "on \(dateFormatterString)", imageView:  AnyView(EmptyView()))
        } else {
            return ButtonContent (text: "\(dayOfWeek(eventDate)) \(dateFormatterString)", imageView: AnyView(EmptyView()))
        }
    }
}





    
