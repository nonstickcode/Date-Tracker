import SwiftUI

struct CalendarIconView: View {
    var month: String
    var day: String
    
    func getColor(for month: String) -> Color {
        switch month.lowercased() {
        case "jan":
            return Color(hex: "FFB347") // Caramel
        case "feb":
            return Color(hex: "DEA5A4") // Sheer Lilac
        case "mar":
            return Color(hex: "77DD77") // Fair Aqua
        case "apr":
            return Color(hex: "E97451") // Cayenne
        case "may":
            return Color(hex: "C23B22") // Bud Green
        case "jun":
            return Color(hex: "FFD700") // Aspen Gold
        case "jul":
            return Color(hex: "FF6961") // Coral Blush
        case "aug":
            return Color(hex: "FF7518") // Sun Orange
        case "sep":
            return Color(hex: "1DACD6") // Baja Blue
        case "oct":
            return Color(hex: "9FE2BF") // Cerulean
        case "nov":
            return Color(hex: "C21E56") // Claret Red
        case "dec":
            return Color(hex: "01796F") // Pagoda Blue
        default:
            return Color.gray
        }
    }

    func getTextColor(for backgroundColor: Color) -> Color {
        return Color.white // Adjust this as you like
    }
    
    var body: some View {
        let backgroundColor = getColor(for: month)
        let textColor = getTextColor(for: backgroundColor)
        
        return ZStack(alignment: .top) {
            Rectangle()
                .foregroundColor(.white)
                .frame(width: 30, height: 30)
                .overlay(
                    Rectangle()
                        .stroke(Color.gray, lineWidth: 1)
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
                .font(.headline)
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
