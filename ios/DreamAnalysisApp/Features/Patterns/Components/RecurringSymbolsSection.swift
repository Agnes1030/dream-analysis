import SwiftUI

struct RecurringSymbolsSection: View {
    let symbols: [PatternSummary.RecurringSymbol]

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Recurring symbols")
                .font(.headline)

            ForEach(symbols) { symbol in
                VStack(alignment: .leading, spacing: 4) {
                    Text(symbol.name)
                        .font(.body.weight(.semibold))

                    Text(symbol.note)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(16)
                .background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    RecurringSymbolsSection(symbols: PatternSummary.earlyUse.recurringSymbols)
        .padding()
}
