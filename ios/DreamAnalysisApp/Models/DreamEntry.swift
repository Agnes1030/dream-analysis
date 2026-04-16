import Foundation
import SwiftData

@Model
final class DreamEntry {
    var id: UUID
    var createdAt: Date
    var rawTranscript: String
    var followUpAnswer: String?
    var interpretationSummary: String?
    var reflectionSnippet: String?
    var tags: [String]
    var emotionalMarkers: [String]
    var isArchived: Bool

    init(
        rawTranscript: String,
        followUpAnswer: String? = nil,
        interpretationSummary: String? = nil,
        reflectionSnippet: String? = nil,
        tags: [String] = [],
        emotionalMarkers: [String] = []
    ) {
        self.id = UUID()
        self.createdAt = Date()
        self.rawTranscript = rawTranscript
        self.followUpAnswer = followUpAnswer
        self.interpretationSummary = interpretationSummary
        self.reflectionSnippet = reflectionSnippet
        self.tags = tags
        self.emotionalMarkers = emotionalMarkers
        self.isArchived = false
    }
}
