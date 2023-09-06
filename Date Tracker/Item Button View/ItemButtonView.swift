import SwiftUI

struct ItemButtonView: View {
    var item: Item?
    
    @Binding var noDataPresent: Bool
    
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(Color.white)
            .frame(height: 60)
            .overlay(
                VStack(spacing: 3) {
                    if let item = item, let eventDate = item.eventDate {
                        let (mainText, imageView) = buttonContent(for: item, on: eventDate)
                        
                        let isFutureEvent = eventDate > Date()
                        let dateFormatterString = isFutureEvent ? dateFormatter.string(from: eventDate) : shortDateFormatter.string(from: eventDate)
                        
                        HStack {
                            Text(mainText)
                                .boldButtonTextStyle()
                            imageView
                        }
                        
                        Text("\(dayOfWeek(eventDate)) \(dateFormatterString)")
                            .mainButtonTextStyle()
                        
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
                .emptyButtonTextStyle()
            HStack {
                Text("Tap ")
                    .emptyButtonTextStyle()
                Image(systemName: "plus.app")
                    .bold()
                    .padding(-6)
                Text(" to add new event.")
                    .emptyButtonTextStyle()
            }
            Spacer()
        }
    }
    
    private func buttonContent(for item: Item, on eventDate: Date) -> (String, AnyView) {
        let name = item.name ?? "Unknown"
        let eventType = item.eventType ?? "Unknown"
        let daysUntil = daysUntilEvent(eventDate)
        
        if daysUntil == 365 && (eventType == "Birthday" || eventType == "Anniversary") {
            return ("\(name)'s \(eventType) is Today!", AnyView(Image(systemName: "party.popper.fill").foregroundColor(.purple)))
        } else if daysUntil == 365 && (eventType == "Holiday" || eventType == "Vacation") {
            return ("\(name)'s \(eventType) is Today!", AnyView(Image(systemName: "calendar.badge.exclamationmark").foregroundColor(.purple)))
        } else if daysUntil == 0 && (eventType == "Birthday" || eventType == "Anniversary") {
            return ("\(name)'s \(eventType) is Tomorrow!", AnyView(Image(systemName: "party.popper").foregroundColor(.purple)))
        } else if daysUntil == 0 && (eventType == "Holiday" || eventType == "Vacation") {
            return ("\(name)'s \(eventType) is Tomorrow!", AnyView(Image(systemName: "calendar.badge.clock").foregroundColor(.purple)))
        } else {
            return ("\(name)'s \(eventType) is in \(daysUntil) days", AnyView(EmptyView()))
        }
    }
}
