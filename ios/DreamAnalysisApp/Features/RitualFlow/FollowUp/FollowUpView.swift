import SwiftUI

struct FollowUpView: View {
    @State private var viewModel: FollowUpViewModel
    @State private var textAnswer = ""

    let onSkip: () -> Void
    let onSelectOption: (String) -> Void
    let onSubmitText: (String?) -> Void

    init(
        viewModel: FollowUpViewModel,
        onSkip: @escaping () -> Void = {},
        onSelectOption: @escaping (String) -> Void = { _ in },
        onSubmitText: @escaping (String?) -> Void = { _ in }
    ) {
        _viewModel = State(initialValue: viewModel)
        self.onSkip = onSkip
        self.onSelectOption = onSelectOption
        self.onSubmitText = onSubmitText
    }

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [
                        Color(red: 0.05, green: 0.06, blue: 0.13),
                        Color(red: 0.11, green: 0.10, blue: 0.23),
                        Color(red: 0.20, green: 0.16, blue: 0.30)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack(alignment: .leading, spacing: 24) {
                    Spacer(minLength: 12)

                    VStack(alignment: .leading, spacing: 10) {
                        Text("A little more, if you'd like")
                            .font(.title2.weight(.semibold))
                            .foregroundStyle(.white)

                        Text(viewModel.prompt.prompt)
                            .font(.body)
                            .foregroundStyle(Color.white.opacity(0.84))
                    }

                    responseSection

                    Button("Skip for now") {
                        viewModel.skip()
                        onSkip()
                    }
                    .buttonStyle(.bordered)
                    .foregroundStyle(Color.white.opacity(0.9))

                    Spacer()
                }
                .padding(24)
            }
            .navigationTitle("Gentle follow-up")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    @ViewBuilder
    private var responseSection: some View {
        switch viewModel.prompt.inputStyle {
        case .chips:
            VStack(alignment: .leading, spacing: 12) {
                ForEach(viewModel.prompt.options, id: \.self) { option in
                    Button(option) {
                        viewModel.selectOption(option)
                        onSelectOption(option)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color.white.opacity(0.18))
                    .foregroundStyle(.white)
                }
            }
        case .text:
            VStack(alignment: .leading, spacing: 12) {
                TextField("A few words, if you want", text: $textAnswer, axis: .vertical)
                    .textFieldStyle(.roundedBorder)

                Button("Continue") {
                    viewModel.submitTextAnswer(textAnswer)
                    onSubmitText(viewModel.answer)
                }
                .buttonStyle(.borderedProminent)
                .tint(Color(red: 0.81, green: 0.74, blue: 0.98))
                .foregroundStyle(Color(red: 0.16, green: 0.10, blue: 0.28))
            }
        }
    }
}

#Preview {
    FollowUpView(
        viewModel: FollowUpViewModel(
            prompt: FollowUpPrompt(
                id: "feeling",
                prompt: "If it fits, what feeling stayed with you most?",
                inputStyle: .chips,
                options: ["Uneasy", "Calm", "Curious"]
            )
        )
    )
}
