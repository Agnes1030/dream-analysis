import SwiftUI

struct HomeView: View {
    @State private var viewModel = HomeViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [
                        Color(red: 0.08, green: 0.08, blue: 0.16),
                        Color(red: 0.16, green: 0.12, blue: 0.25),
                        Color(red: 0.30, green: 0.20, blue: 0.38)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        AtmosphericHeaderView()

                        PrimaryCaptureButton {
                            viewModel.didTapCapture()
                        }

                        VStack(alignment: .leading, spacing: 16) {
                            RecentDreamCallbackCard()
                            RecurringCueStrip()
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 28)
                }
            }
            .navigationTitle("Dream space")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $viewModel.isPresentingCapture) {
                DreamCaptureView()
            }
        }
    }
}

#Preview {
    HomeView()
}
