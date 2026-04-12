import Foundation
import SwiftData

@Model
final class DreamEntry {
    var id: UUID
    var createdAt: Date
    var rawTranscript: String
    var followUpAnswer: String?
    var isArchived: Bool

    init(rawTranscript: String) {
        self.id = UUID()
        self.createdAt = Date()
        self.rawTranscript = rawTranscript
        self.followUpAnswer = nil
        self.isArchived = false
    }
}
