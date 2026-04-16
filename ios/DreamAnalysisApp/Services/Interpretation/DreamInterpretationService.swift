import Foundation

protocol DreamInterpretationServicing {
    func interpret(dream: DreamEntry) -> Interpretation
}

struct DreamInterpretationService: DreamInterpretationServicing {
    func interpret(dream: DreamEntry) -> Interpretation {
        let transcript = dream.rawTranscript.trimmingCharacters(in: .whitespacesAndNewlines)
        let normalizedTranscript = transcript.isEmpty ? "this dream" : transcript
        let lowercasedTranscript = normalizedTranscript.lowercased()
        let motifs = detectedMotifs(in: lowercasedTranscript)
        let followUpAnswer = dream.followUpAnswer?.trimmingCharacters(in: .whitespacesAndNewlines)
        let groundedFollowUp = (followUpAnswer?.isEmpty == false) ? followUpAnswer : nil

        return Interpretation(
            coreInsight: coreInsight(for: motifs, transcript: normalizedTranscript),
            symbolicSummary: symbolicSummary(for: motifs),
            personalReflection: personalReflection(for: motifs, followUpAnswer: groundedFollowUp, transcript: normalizedTranscript)
        )
    }

    private func detectedMotifs(in transcript: String) -> [Motif] {
        Motif.allCases.filter { motif in
            motif.keywords.contains { transcript.contains($0) }
        }
    }

    private func coreInsight(for motifs: [Motif], transcript: String) -> String {
        if let primaryMotif = motifs.first {
            return primaryMotif.coreInsight
        }

        return "This dream seems to be circling something that still wants a little attention, even if its meaning is not fully clear yet."
    }

    private func symbolicSummary(for motifs: [Motif]) -> String {
        if motifs.isEmpty {
            return "The imagery here feels open-ended, which can sometimes point to a mood or concern that is still taking shape in the background."
        }

        let summaries = Array(motifs.prefix(2)).map(\.summary)

        if summaries.count == 1 {
            return summaries[0]
        }

        return summaries.dropFirst().reduce(summaries[0]) { partial, next in
            partial + " " + next
        }
    }

    private func personalReflection(for motifs: [Motif], followUpAnswer: String?, transcript: String) -> String {
        if let followUpAnswer {
            let motifPrompt = motifs.first?.reflectionPrompt ?? "which part of this dream still feels most alive for you"
            return "Because you connected it to \"\(followUpAnswer)\", it may help to notice whether that same feeling is what gives the dream its weight. You might gently stay with \(motifPrompt)."
        }

        if let primaryMotif = motifs.first {
            return primaryMotif.reflection
        }

        return "You might gently notice what feeling from this dream lingered longest after waking, and whether it connects with anything present in your life right now."
    }
}

private enum Motif: CaseIterable {
    case home
    case family
    case water
    case animals
    case pursuit
    case fallingFlying
    case darknessLight
    case roadsRooms

    var keywords: [String] {
        switch self {
        case .home:
            ["home", "house", "kitchen", "bedroom", "childhood home", "front door"]
        case .family:
            ["mother", "mom", "father", "dad", "grandmother", "grandma", "grandfather", "grandpa", "sister", "brother", "family"]
        case .water:
            ["water", "ocean", "sea", "river", "lake", "rain", "flood", "shore", "wave"]
        case .animals:
            ["dog", "cat", "bird", "horse", "snake", "animal", "wolf", "bear"]
        case .pursuit:
            ["chasing", "chased", "running", "escape", "hiding", "pursued"]
        case .fallingFlying:
            ["falling", "fell", "flying", "flew", "floating", "height", "sky", "above"]
        case .darknessLight:
            ["dark", "darkness", "night", "shadow", "light", "sun", "sunlight", "bright"]
        case .roadsRooms:
            ["road", "path", "street", "hallway", "room", "door", "stairs", "corridor"]
        }
    }

    var coreInsight: String {
        switch self {
        case .home:
            return "The dream seems close to questions of belonging, safety, or the parts of life that are meant to feel like home."
        case .family:
            return "The presence of family imagery can suggest old bonds, expectations, or memories are quietly shaping the feeling of this dream."
        case .water:
            return "Water imagery often carries emotional movement, as if something in you is being felt before it can be neatly explained."
        case .animals:
            return "Animal imagery can point to instinctive feelings or needs that are trying to be noticed in a more direct way."
        case .pursuit:
            return "A dream of pursuit can reflect pressure, avoidance, or the sense that something unresolved is asking not to be outrun."
        case .fallingFlying:
            return "Changes in height or movement can suggest a shifting sense of control, freedom, or distance from everyday concerns."
        case .darknessLight:
            return "The contrast between darkness and light can reflect a search for clarity while moving through uncertainty."
        case .roadsRooms:
            return "Passageways and rooms often suggest movement through inner space, as if the dream is tracing how you are approaching a threshold or decision."
        }
    }

    var summary: String {
        switch self {
        case .home:
            return "Home imagery can reflect questions of comfort, familiarity, or where you feel most settled inside yourself."
        case .family:
            return "Family figures often bring in memory, loyalty, and the emotional patterns we carry from earlier chapters of life."
        case .water:
            return "Water here gives the dream an emotional texture, suggesting feelings that may be deep, changeable, or difficult to hold all at once."
        case .animals:
            return "The animal presence can symbolize instinct, protection, or a feeling that reacts before words arrive."
        case .pursuit:
            return "Being chased or urgently moving can symbolize pressure, avoidance, or an issue that wants acknowledgement."
        case .fallingFlying:
            return "The sense of height or distance suggests a wish for perspective, release, or steadiness while things feel in motion."
        case .darknessLight:
            return "Darkness and light together can symbolize the movement between not knowing and beginning to see more clearly."
        case .roadsRooms:
            return "Doors, hallways, and rooms often symbolize transitions, boundaries, and the feeling of moving from one inner state into another."
        }
    }

    var reflection: String {
        switch self {
        case .home:
            return "It may help to notice what currently feels steady or unsettled in your sense of home, routine, or belonging."
        case .family:
            return "You might gently ask whether this dream touches an older family feeling that is still active in a quieter form."
        case .water:
            return "You might gently notice which feelings have been harder to name lately, especially ones that rise quickly or shift from moment to moment."
        case .animals:
            return "It may be worth noticing where your instincts have been trying to protect you or get your attention recently."
        case .pursuit:
            return "You might reflect on whether there is a pressure in waking life that feels easier to keep moving around than to face directly."
        case .fallingFlying:
            return "It may help to notice whether you have been wanting more freedom, more perspective, or more ground beneath you lately."
        case .darknessLight:
            return "You might ask yourself where clarity is beginning to emerge, even if the full picture still feels incomplete."
        case .roadsRooms:
            return "It may help to notice whether you are in the middle of a transition, or standing at the edge of one."
        }
    }

    var reflectionPrompt: String {
        switch self {
        case .home:
            return "what feels most like home, and what no longer does"
        case .family:
            return "which family feeling or memory seems closest to the surface"
        case .water:
            return "which emotions have been hardest to contain or put into words"
        case .animals:
            return "where your instincts have been speaking most clearly"
        case .pursuit:
            return "what has felt difficult to stop and face directly"
        case .fallingFlying:
            return "where you have been wanting more freedom or steadiness"
        case .darknessLight:
            return "where clarity is appearing, even if gradually"
        case .roadsRooms:
            return "what threshold or transition you may be moving through"
        }
    }
}
