import SwiftUI

struct HalfModalView<Content: View>: View {
    let content: Content
    
    @State private var contentWidth: CGFloat = 0
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
                            .fixedSize(horizontal: true, vertical: false)
                            .background(
                                GeometryReader { proxy in
                                    Color.clear.onAppear {
                                        self.contentWidth = proxy.size.width
                                    }
                                }
                            )
                    }
                    .padding(padding)
                    .shadow(radius: 50)
                    .frame(width: contentWidth + padding * 2)
                    .background(Color.white)
                    .cornerRadius(cornerRadius)
                    .frame(minHeight: 0, maxHeight: .infinity)
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
