import SwiftUI

struct CalendarIconView: View {
    var month: String
    var day: String
    
    func getColor(for month: String) -> (bgColor: Color, textColor: Color) {
        switch month.lowercased() {
        case "jan":
            return (Color(hex: "FFB347"), Color(hex: "000000")) // Caramel
        case "feb":
            return (Color(hex: "DEA5A4"), Color(hex: "000000")) // Sheer Lilac
        case "mar":
            return (Color(hex: "77DD77"), Color(hex: "000000")) // Fair Aqua
        case "apr":
            return (Color(hex: "E97451"), Color(hex: "FFFFFF")) // Cayenne
        case "may":
            return (Color(hex: "C23B22"), Color(hex: "FFFFFF")) // Bud Green
        case "jun":
            return (Color(hex: "FFD700"), Color(hex: "000000")) // Aspen Gold
        case "jul":
            return (Color(hex: "FF6961"), Color(hex: "FFFFFF")) // Coral Blush
        case "aug":
            return (Color(hex: "FF7518"), Color(hex: "FFFFFF")) // Sun Orange
        case "sep":
            return (Color(hex: "1DACD6"), Color(hex: "FFFFFF")) // Baja Blue
        case "oct":
            return (Color(hex: "000000"), Color(hex: "FFFF00")) // Halloween Black and Yellow
        case "nov":
            return (Color(hex: "C21E56"), Color(hex: "FFFFFF")) // Claret Red
        case "dec":
            return (Color(hex: "01796F"), Color(hex: "FFFFFF")) // Pagoda Blue
        default:
            return (Color(hex: "808080"), Color(hex: "000000"))
        }
    }

   
    
    var body: some View {
        let colors = getColor(for: month)
        let backgroundColor = colors.bgColor
        let textColor = colors.textColor
        
        return ZStack(alignment: .top) {
            Rectangle()
                .foregroundColor(.white)
                .frame(width: 30, height: 30)
                .overlay(
                    Rectangle()
                        .stroke(Color.gray, lineWidth: 0.5)
                )
            Rectangle()
                .foregroundColor(backgroundColor)
                .frame(width: 30, height: 12)
                .overlay(
                    Text(month)
                        .foregroundColor(textColor)
                        .font(.system(size: 10))
                        .bold()
                )
            Text(day)
                .foregroundColor(.black)
                .font(.subheadline)
                .fontWeight(.bold)
                .offset(y: 11)
        }
    }
}

struct CalendarIconView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarIconView(month: "JAN", day: "1")
    }
}
