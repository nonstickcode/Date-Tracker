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
                .padding(20)
                .shadow(radius: 50)
                .frame(width: geometry.size.width)
                .background(Color.white)
                .frame(minHeight: 0, maxHeight: .infinity)
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
