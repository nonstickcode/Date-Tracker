import SwiftUI

struct HalfModalView<Content: View>: View {
    let content: Content
    
    let padding: CGFloat = 25
    let cornerRadius: CGFloat = 20
       
    init(@ViewBuilder content: () -> Content) {
           self.content = content()
    }

    var body: some View {
            GeometryReader { geometry in
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        VStack {
                            self.content
                        }
                        .padding(padding)
                        .background(Color.white.opacity(0.9))
                        .shadow(color: Color.black.opacity(0.3), radius: 10, x: 5, y: 5)
                        .cornerRadius(cornerRadius)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: geometry.size.width - 2 * padding, maxHeight: .infinity)
                        .lineLimit(nil)
                        Spacer()
                    }
                    Spacer()
                }
                
            }
        
            .background(
                VisualEffectView(effect: UIBlurEffect(style: .light))
                    .edgesIgnoringSafeArea(.all)
            )
        }
    
    }

struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?

    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView {
        return UIVisualEffectView()
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) {
        uiView.effect = effect
    }
}
