import SwiftUI

struct ButtonContent {
    let text: String
    let imageView: AnyView
}

public func extractMonthDay(from eventDate: Date) -> (String, String) {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM"
    let monthString = formatter.string(from: eventDate).uppercased()
    
    formatter.dateFormat = "dd"
    let dayString = formatter.string(from: eventDate)
    
    return (monthString, dayString)
}


struct ItemButtonView: View {
    var item: Item?
    
    @Binding var noDataPresent: Bool
    
    struct ButtonContent {
        let text: String
        let imageView: AnyView
    }
    
    
    
    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.9))
                .shadow(color: Color.black.opacity(0.3), radius: 10, x: 5, y: 5)
            
            HStack(alignment: .center) {
                
                if let item = item, let eventDate = item.eventDate {
                    let (monthString, dayString) = extractMonthDay(from: eventDate)
                    
                    CalendarIconView(month: monthString, day: dayString)
                        .padding(.leading, 20)
                        .frame(width: 40)
                        .shadow(color: .gray.opacity(0.5), radius: 2, x: 2, y: 2)
                        .padding([.top, .bottom], 15)
//                        .border(Color.black, width: 2)
                    
                }
                
                
                
                Spacer()
                
                VStack(spacing: 3) {
                    if let item = item, let eventDate = item.eventDate {
                        let topLineContent = buttonContentTopLine(for: item, on: eventDate)
                        let bottomLineContent = buttonContentBottomLine(for: item, on: eventDate)
                        
                        HStack {
                            Text(topLineContent.text)
                                .boldButtonTextStyle()
                                .lineLimit(1) // Limit to 1 line
                                .truncationMode(.tail) // Truncate with an ellipsis at the end
                            topLineContent.imageView
                        }
                        
                        HStack {
                            Text(bottomLineContent.text)
                                .modifier(MainButtonTextStyle())
                            bottomLineContent.imageView
                        }
                        
                    } else {
                        noDataView
                            
                    }
                }
                Spacer()
                
                Spacer()
                    .padding(.trailing, 20)
                    .frame(width: 40)
                
            }
           
        }
        
        
        
        .frame(height: 60)
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
            Spacer ()
            Text("No data available.")
                .emptyButtonBoldTextStyle()
                
            Spacer ()
            HStack {
                Spacer ()
                Text("Tap the ")
                    .emptyButtonTextStyle()
                    .padding(.trailing, -15)
                Image(systemName: "plus.app")
                    .padding(0)
                    .bold()
                    
                Text(" to add a new event.")
                    .emptyButtonTextStyle()
                    .padding(.leading, -15)
                Spacer()
            }
            Spacer ()
            
        }
        
        
    }
    
    private func buttonContentTopLine(for item: Item, on eventDate: Date) -> ButtonContent {
        let name = item.name ?? "Unknown"
        let eventType = item.eventType ?? "Unknown"
        let daysUntil = daysUntilEvent(eventDate)
        
        if daysUntil == 365 && (eventType == "Birthday" || eventType == "Anniversary") {
            return ButtonContent (text: "\(name)'s \(eventType) was yesterday!", imageView: AnyView(Image(systemName: "figure.wave.circle").foregroundColor(.brown)))
        } else if daysUntil == 365 && eventType == "Vacation" {
            return ButtonContent (text: "\(name)'s \(eventType) was yesterday!", imageView: AnyView(Image(systemName: "figure.wave.circle.fill").foregroundColor(.purple)))
        } else if daysUntil == 365 && eventType == "Holiday" {
            return ButtonContent (text: "\(name) was yesterday!", imageView: AnyView(Image(systemName: "figure.wave.circle.fill").foregroundColor(.purple)))
        } else if daysUntil == 0 && (eventType == "Birthday" || eventType == "Anniversary") {
            return ButtonContent (text: "\(name)'s \(eventType) is Today!", imageView: AnyView(Image(systemName: "party.popper.fill").foregroundColor(.purple)))
        } else if daysUntil == 0 && eventType == "Vacation" {
            return ButtonContent (text: "\(name)'s \(eventType) is Today!", imageView: AnyView(Image(systemName: "calendar.badge.exclamationmark").foregroundColor(.purple)))
        } else if daysUntil == 0 && eventType == "Holiday" {
            return ButtonContent (text: "\(name) is Today!", imageView: AnyView(Image(systemName: "calendar.badge.exclamationmark").foregroundColor(.purple)))
        } else if daysUntil == 1 && (eventType == "Birthday" || eventType == "Anniversary") {
            return ButtonContent (text: "\(name)'s \(eventType) is Tomorrow!", imageView: AnyView(Image(systemName: "party.popper").foregroundColor(.purple)))
        } else if daysUntil == 1 && eventType == "Vacation" {
            return ButtonContent (text: "\(name)'s \(eventType) is Tomorrow!", imageView: AnyView(Image(systemName: "calendar.badge.clock").foregroundColor(.purple)))
        } else if daysUntil == 1 && eventType == "Holiday" {
            return ButtonContent (text: "\(name) is Tomorrow!", imageView: AnyView(Image(systemName: "calendar.badge.clock").foregroundColor(.purple)))
        } else if eventType == "Holiday" {
            return ButtonContent (text: "\(name) is in \(daysUntil) days", imageView: AnyView(EmptyView()))
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
