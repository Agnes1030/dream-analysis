import SwiftUI

struct MemoryControlsSection: View {
    @Bindable var viewModel: ProfileViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Memory and privacy")
                .font(.headline)

            ForEach(Array(viewModel.memorySectionRows.enumerated()), id: \.offset) { _, row in
                switch row {
                case let .control(title, detail, isEnabled):
                    controlRow(title: title, detail: detail, isOn: binding(for: title, fallback: isEnabled))
                case let .infoCard(title, detail):
                    infoCard(title: title, detail: detail)
                case let .explanation(title, detail):
                    explanationRow(title: title, detail: detail)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
    }

    private func binding(for title: String, fallback: Bool) -> Binding<Bool> {
        switch title {
        case "Use prior patterns":
            $viewModel.usePriorPatternsInInterpretation
        case "Surface continuity cues":
            $viewModel.surfaceContinuityCuesOnReturn
        default:
            Binding(get: { fallback }, set: { _ in })
        }
    }

    @ViewBuilder
    private func controlRow(title: String, detail: String, isOn: Binding<Bool>) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Toggle(isOn: isOn) {
                Text(title)
                    .font(.subheadline.weight(.semibold))
            }
            .tint(.primary)

            Text(detail)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }

    @ViewBuilder
    private func infoCard(title: String, detail: String) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.subheadline.weight(.semibold))

            Text(detail)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.tertiarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
    }

    @ViewBuilder
    private func explanationRow(title: String, detail: String) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.subheadline.weight(.semibold))

            Text(detail)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    MemoryControlsSection(viewModel: ProfileViewModel())
        .padding()
}
