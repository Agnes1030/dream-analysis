import SwiftUI

struct InterpretationResultView: View {
    @State private var viewModel: InterpretationResultViewModel
    private let onComplete: () -> Void

    init(
        viewModel: InterpretationResultViewModel,
        onComplete: @escaping () -> Void = {}
    ) {
        _viewModel = State(initialValue: viewModel)
        self.onComplete = onComplete
    }

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [
                        Color(red: 0.05, green: 0.05, blue: 0.12),
                        Color(red: 0.12, green: 0.10, blue: 0.24),
                        Color(red: 0.24, green: 0.18, blue: 0.35)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 20) {
                        topReflection

                        CoreInsightCard(text: viewModel.interpretation.coreInsight)

                        symbolicLayer

                        PersonalizedReflectionCard(text: viewModel.interpretation.personalReflection)

                        saveSection
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 24)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        viewModel.complete()
                        onComplete()
                    }
                    .foregroundStyle(Color.white.opacity(0.88))
                }
            }
            .navigationTitle("Your reflection")
            .navigationBarTitleDisplayMode(.inline)
            .alert("Saved to your archive", isPresented: $viewModel.didShowSavedConfirmation) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("You can come back to this dream whenever you want.")
            }
        }
    }

    private var topReflection: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("A first feeling")
                .font(.caption.weight(.semibold))
                .textCase(.uppercase)
                .foregroundStyle(Color.white.opacity(0.62))

            Text(viewModel.interpretation.coreInsight)
                .font(.system(.largeTitle, design: .serif, weight: .semibold))
                .foregroundStyle(.white)

            Text("Take what feels true, and let the rest stay open. This reading is meant to be a gentle companion to what your dream may be holding.")
                .font(.body)
                .foregroundStyle(Color.white.opacity(0.78))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(24)
        .background(Color.white.opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .stroke(Color.white.opacity(0.10), lineWidth: 1)
        )
    }

    private var symbolicLayer: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Symbolic layer")
                .font(.headline)
                .foregroundStyle(.white)

            Text(viewModel.interpretation.symbolicSummary)
                .font(.body)
                .foregroundStyle(Color.white.opacity(0.82))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(22)
        .background(Color.white.opacity(0.06))
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .stroke(Color.white.opacity(0.08), lineWidth: 1)
        )
    }

    private var saveSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Button("Save this dream") {
                viewModel.save()
            }
            .buttonStyle(.borderedProminent)
            .tint(Color(red: 0.81, green: 0.74, blue: 0.98))
            .foregroundStyle(Color(red: 0.16, green: 0.10, blue: 0.28))

            Text("Keep this reflection close if you want to return to it later.")
                .font(.subheadline)
                .foregroundStyle(Color.white.opacity(0.72))
        }
    }
}

#Preview {
    InterpretationResultView(
        viewModel: InterpretationResultViewModel(
            dream: DreamEntry(rawTranscript: "I was walking through a blue garden at night."),
            interpretation: Interpretation(
                coreInsight: "Part of you may be looking for calm without losing closeness.",
                symbolicSummary: "Night colors, a garden, and wandering imagery can suggest inward tending, privacy, and emotional renewal.",
                personalReflection: "This dream may be reflecting a wish to move more gently with feelings that have been hard to name in the daytime."
            )
        )
    )
}
