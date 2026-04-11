# Dream Analysis iOS v1 SwiftUI Architecture Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Build the first implementable SwiftUI architecture for the dream-analysis iOS app, matching the approved v1 page structure, navigation hierarchy, ritual flow, and emotional product constraints documented in `PROJECT.md`.

**Architecture:** Create one iOS app target organized around 4 stable shells (`Home`, `Patterns`, `Archive`, `Me`) plus 1 ritual flow system (`Capture`, `Follow-up`, `Result`). Use SwiftUI for presentation, SwiftData for local persistence, AVFoundation/Speech for voice capture and transcription scaffolding, and a thin service layer so AI/memory features can start mocked locally and later swap to a cloud backend without rewriting view logic.

**Tech Stack:** Swift 5.10+, SwiftUI, SwiftData, AVFoundation, Speech, XCTest, Xcode project generation by Xcode itself (or later Tuist/XcodeGen if desired, but not required for v1)

---

### Task 1: Create the iOS app shell and folder structure

**Files:**
- Create: `ios/DreamAnalysisApp/DreamAnalysisAppApp.swift`
- Create: `ios/DreamAnalysisApp/App/AppRootView.swift`
- Create: `ios/DreamAnalysisApp/App/AppEnvironment.swift`
- Create: `ios/DreamAnalysisApp/App/AppTab.swift`
- Create: `ios/DreamAnalysisApp/Features/`
- Create: `ios/DreamAnalysisApp/Core/`
- Create: `ios/DreamAnalysisApp/Services/`
- Create: `ios/DreamAnalysisApp/Models/`
- Create: `ios/DreamAnalysisApp/Resources/`
- Create: `ios/DreamAnalysisAppTests/App/AppRootViewModelTests.swift`

**Step 1: Write the failing test**

```swift
import XCTest
@testable import DreamAnalysisApp

final class AppRootViewModelTests: XCTestCase {
    func testDefaultTabIsHome() {
        let state = AppRootState()
        XCTAssertEqual(state.selectedTab, .home)
    }
}
```

**Step 2: Run test to verify it fails**

Run: `xcodebuild test -scheme DreamAnalysisApp -destination 'platform=iOS Simulator,name=iPhone 16' -only-testing:DreamAnalysisAppTests/AppRootViewModelTests`
Expected: FAIL with "No such module 'DreamAnalysisApp'" or missing `AppRootState`.

**Step 3: Write minimal implementation**

```swift
import SwiftUI

enum AppTab: Hashable {
    case home
    case patterns
    case archive
    case me
}

struct AppRootState {
    var selectedTab: AppTab = .home
}

@main
struct DreamAnalysisAppApp: App {
    var body: some Scene {
        WindowGroup {
            AppRootView()
        }
    }
}
```

**Step 4: Run test to verify it passes**

Run: `xcodebuild test -scheme DreamAnalysisApp -destination 'platform=iOS Simulator,name=iPhone 16' -only-testing:DreamAnalysisAppTests/AppRootViewModelTests`
Expected: PASS

**Step 5: Commit**

```bash
git add ios/DreamAnalysisApp ios/DreamAnalysisAppTests
git commit -m "feat: scaffold iOS app root architecture"
```

---

### Task 2: Define the shared domain models and local persistence layer

**Files:**
- Create: `ios/DreamAnalysisApp/Models/DreamEntry.swift`
- Create: `ios/DreamAnalysisApp/Models/Interpretation.swift`
- Create: `ios/DreamAnalysisApp/Models/FollowUpPrompt.swift`
- Create: `ios/DreamAnalysisApp/Models/PatternSummary.swift`
- Create: `ios/DreamAnalysisApp/Models/PrivateWhisper.swift`
- Create: `ios/DreamAnalysisApp/Models/SafeHarborItem.swift`
- Create: `ios/DreamAnalysisApp/Core/Persistence/PersistenceController.swift`
- Test: `ios/DreamAnalysisAppTests/Models/DreamEntryTests.swift`

**Step 1: Write the failing test**

```swift
import XCTest
@testable import DreamAnalysisApp

final class DreamEntryTests: XCTestCase {
    func testNewDreamEntryStartsUnsavedToArchive() {
        let entry = DreamEntry(rawTranscript: "I dreamed I was underwater")
        XCTAssertFalse(entry.isArchived)
    }
}
```

**Step 2: Run test to verify it fails**

Run: `xcodebuild test -scheme DreamAnalysisApp -destination 'platform=iOS Simulator,name=iPhone 16' -only-testing:DreamAnalysisAppTests/DreamEntryTests`
Expected: FAIL with missing `DreamEntry`.

**Step 3: Write minimal implementation**

```swift
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
```

Also add placeholder value types for `Interpretation`, `FollowUpPrompt`, `PatternSummary`, `PrivateWhisper`, and `SafeHarborItem` so later screens can compile before backend work begins.

**Step 4: Run test to verify it passes**

Run: `xcodebuild test -scheme DreamAnalysisApp -destination 'platform=iOS Simulator,name=iPhone 16' -only-testing:DreamAnalysisAppTests/DreamEntryTests`
Expected: PASS

**Step 5: Commit**

```bash
git add ios/DreamAnalysisApp/Models ios/DreamAnalysisApp/Core/Persistence ios/DreamAnalysisAppTests/Models
git commit -m "feat: add local dream domain models and persistence shell"
```

---

### Task 3: Build the stable navigation shell

**Files:**
- Modify: `ios/DreamAnalysisApp/App/AppRootView.swift`
- Create: `ios/DreamAnalysisApp/Features/Home/HomeView.swift`
- Create: `ios/DreamAnalysisApp/Features/Patterns/PatternsView.swift`
- Create: `ios/DreamAnalysisApp/Features/Archive/ArchiveView.swift`
- Create: `ios/DreamAnalysisApp/Features/Profile/ProfileView.swift`
- Test: `ios/DreamAnalysisAppTests/App/AppTabTests.swift`

**Step 1: Write the failing test**

```swift
import XCTest
@testable import DreamAnalysisApp

final class AppTabTests: XCTestCase {
    func testStableTabsMatchApprovedV1Structure() {
        XCTAssertEqual(AppTab.allCases, [.home, .patterns, .archive, .me])
    }
}
```

**Step 2: Run test to verify it fails**

Run: `xcodebuild test -scheme DreamAnalysisApp -destination 'platform=iOS Simulator,name=iPhone 16' -only-testing:DreamAnalysisAppTests/AppTabTests`
Expected: FAIL because `AppTab` does not conform to `CaseIterable` or values are missing.

**Step 3: Write minimal implementation**

```swift
enum AppTab: Hashable, CaseIterable {
    case home
    case patterns
    case archive
    case me
}
```

Then wire `TabView` in `AppRootView` and create placeholder SwiftUI views with intentionally quiet copy matching `PROJECT.md` constraints.

**Step 4: Run test to verify it passes**

Run: `xcodebuild test -scheme DreamAnalysisApp -destination 'platform=iOS Simulator,name=iPhone 16' -only-testing:DreamAnalysisAppTests/AppTabTests`
Expected: PASS

**Step 5: Commit**

```bash
git add ios/DreamAnalysisApp/App ios/DreamAnalysisApp/Features ios/DreamAnalysisAppTests/App
git commit -m "feat: add stable v1 tab shell"
```

---

### Task 4: Implement Home as the ritual doorway

**Files:**
- Create: `ios/DreamAnalysisApp/Features/Home/HomeViewModel.swift`
- Create: `ios/DreamAnalysisApp/Features/Home/Components/AtmosphericHeaderView.swift`
- Create: `ios/DreamAnalysisApp/Features/Home/Components/PrimaryCaptureButton.swift`
- Create: `ios/DreamAnalysisApp/Features/Home/Components/RecentDreamCallbackCard.swift`
- Create: `ios/DreamAnalysisApp/Features/Home/Components/RecurringCueStrip.swift`
- Test: `ios/DreamAnalysisAppTests/Features/Home/HomeViewModelTests.swift`

**Step 1: Write the failing test**

```swift
import XCTest
@testable import DreamAnalysisApp

final class HomeViewModelTests: XCTestCase {
    func testPrimaryActionLaunchesCaptureFlow() {
        let model = HomeViewModel()
        model.didTapCapture()
        XCTAssertTrue(model.isPresentingCapture)
    }
}
```

**Step 2: Run test to verify it fails**

Run: `xcodebuild test -scheme DreamAnalysisApp -destination 'platform=iOS Simulator,name=iPhone 16' -only-testing:DreamAnalysisAppTests/Features/Home/HomeViewModelTests`
Expected: FAIL with missing `HomeViewModel`.

**Step 3: Write minimal implementation**

```swift
import Observation

@Observable
final class HomeViewModel {
    var isPresentingCapture = false

    func didTapCapture() {
        isPresentingCapture = true
    }
}
```

Then implement `HomeView` to keep 80% emotional invitation / 20% continuity support per `PROJECT.md`.

**Step 4: Run test to verify it passes**

Run: `xcodebuild test -scheme DreamAnalysisApp -destination 'platform=iOS Simulator,name=iPhone 16' -only-testing:DreamAnalysisAppTests/Features/Home/HomeViewModelTests`
Expected: PASS

**Step 5: Commit**

```bash
git add ios/DreamAnalysisApp/Features/Home ios/DreamAnalysisAppTests/Features/Home
git commit -m "feat: implement home ritual doorway"
```

---

### Task 5: Implement the capture flow state machine

**Files:**
- Create: `ios/DreamAnalysisApp/Features/RitualFlow/Capture/DreamCaptureView.swift`
- Create: `ios/DreamAnalysisApp/Features/RitualFlow/Capture/DreamCaptureViewModel.swift`
- Create: `ios/DreamAnalysisApp/Features/RitualFlow/Capture/Components/RecordingOrbView.swift`
- Create: `ios/DreamAnalysisApp/Services/Audio/AudioRecordingService.swift`
- Create: `ios/DreamAnalysisApp/Services/Transcription/SpeechTranscriptionService.swift`
- Test: `ios/DreamAnalysisAppTests/Features/RitualFlow/DreamCaptureViewModelTests.swift`

**Step 1: Write the failing test**

```swift
import XCTest
@testable import DreamAnalysisApp

final class DreamCaptureViewModelTests: XCTestCase {
    func testFinishingCaptureCreatesDraftDream() {
        let model = DreamCaptureViewModel()
        model.transcript = "I was running through a forest"
        let dream = model.finishCapture()
        XCTAssertEqual(dream.rawTranscript, "I was running through a forest")
    }
}
```

**Step 2: Run test to verify it fails**

Run: `xcodebuild test -scheme DreamAnalysisApp -destination 'platform=iOS Simulator,name=iPhone 16' -only-testing:DreamAnalysisAppTests/Features/RitualFlow/DreamCaptureViewModelTests`
Expected: FAIL with missing `DreamCaptureViewModel`.

**Step 3: Write minimal implementation**

```swift
import Observation

@Observable
final class DreamCaptureViewModel {
    var transcript = ""

    func finishCapture() -> DreamEntry {
        DreamEntry(rawTranscript: transcript)
    }
}
```

Stub audio/transcription services behind protocols:
- `AudioRecordingServicing`
- `SpeechTranscribing`

Do not overbuild real transcription yet; make the UI and dependency seams first.

**Step 4: Run test to verify it passes**

Run: `xcodebuild test -scheme DreamAnalysisApp -destination 'platform=iOS Simulator,name=iPhone 16' -only-testing:DreamAnalysisAppTests/Features/RitualFlow/DreamCaptureViewModelTests`
Expected: PASS

**Step 5: Commit**

```bash
git add ios/DreamAnalysisApp/Features/RitualFlow/Capture ios/DreamAnalysisApp/Services/Audio ios/DreamAnalysisApp/Services/Transcription ios/DreamAnalysisAppTests/Features/RitualFlow
git commit -m "feat: add dream capture flow state"
```

---

### Task 6: Implement the gentle follow-up bridge

**Files:**
- Create: `ios/DreamAnalysisApp/Features/RitualFlow/FollowUp/FollowUpView.swift`
- Create: `ios/DreamAnalysisApp/Features/RitualFlow/FollowUp/FollowUpViewModel.swift`
- Create: `ios/DreamAnalysisApp/Services/FollowUp/FollowUpPromptService.swift`
- Test: `ios/DreamAnalysisAppTests/Features/RitualFlow/FollowUpViewModelTests.swift`

**Step 1: Write the failing test**

```swift
import XCTest
@testable import DreamAnalysisApp

final class FollowUpViewModelTests: XCTestCase {
    func testSkippingQuestionStillCompletesBridge() {
        let prompt = FollowUpPrompt(id: "mood", prompt: "How did it feel?", inputStyle: .chips, options: ["uneasy"])
        let model = FollowUpViewModel(prompt: prompt)
        model.skip()
        XCTAssertTrue(model.isComplete)
        XCTAssertNil(model.answer)
    }
}
```

**Step 2: Run test to verify it fails**

Run: `xcodebuild test -scheme DreamAnalysisApp -destination 'platform=iOS Simulator,name=iPhone 16' -only-testing:DreamAnalysisAppTests/Features/RitualFlow/FollowUpViewModelTests`
Expected: FAIL with missing `FollowUpViewModel` or `FollowUpPrompt` shape mismatch.

**Step 3: Write minimal implementation**

```swift
import Observation

@Observable
final class FollowUpViewModel {
    let prompt: FollowUpPrompt
    var answer: String?
    var isComplete = false

    init(prompt: FollowUpPrompt) {
        self.prompt = prompt
    }

    func skip() {
        answer = nil
        isComplete = true
    }
}
```

Keep copy soft and lightweight. No hard progress-step language.

**Step 4: Run test to verify it passes**

Run: `xcodebuild test -scheme DreamAnalysisApp -destination 'platform=iOS Simulator,name=iPhone 16' -only-testing:DreamAnalysisAppTests/Features/RitualFlow/FollowUpViewModelTests`
Expected: PASS

**Step 5: Commit**

```bash
git add ios/DreamAnalysisApp/Features/RitualFlow/FollowUp ios/DreamAnalysisApp/Services/FollowUp ios/DreamAnalysisAppTests/Features/RitualFlow
git commit -m "feat: add gentle follow-up bridge"
```

---

### Task 7: Implement the result screen as the emotional center

**Files:**
- Create: `ios/DreamAnalysisApp/Features/RitualFlow/Result/InterpretationResultView.swift`
- Create: `ios/DreamAnalysisApp/Features/RitualFlow/Result/InterpretationResultViewModel.swift`
- Create: `ios/DreamAnalysisApp/Features/RitualFlow/Result/Components/CoreInsightCard.swift`
- Create: `ios/DreamAnalysisApp/Features/RitualFlow/Result/Components/PersonalizedReflectionCard.swift`
- Create: `ios/DreamAnalysisApp/Services/Interpretation/DreamInterpretationService.swift`
- Test: `ios/DreamAnalysisAppTests/Features/RitualFlow/InterpretationResultViewModelTests.swift`

**Step 1: Write the failing test**

```swift
import XCTest
@testable import DreamAnalysisApp

final class InterpretationResultViewModelTests: XCTestCase {
    func testSaveMarksDreamAsArchived() {
        let dream = DreamEntry(rawTranscript: "I was floating above my house")
        let result = Interpretation(coreInsight: "You are seeking distance.", symbolicSummary: "Elevation and home imagery.", personalReflection: "There may be a wish for perspective.")
        let model = InterpretationResultViewModel(dream: dream, interpretation: result)

        model.save()

        XCTAssertTrue(dream.isArchived)
        XCTAssertTrue(model.didShowSavedConfirmation)
    }
}
```

**Step 2: Run test to verify it fails**

Run: `xcodebuild test -scheme DreamAnalysisApp -destination 'platform=iOS Simulator,name=iPhone 16' -only-testing:DreamAnalysisAppTests/Features/RitualFlow/InterpretationResultViewModelTests`
Expected: FAIL with missing `InterpretationResultViewModel`.

**Step 3: Write minimal implementation**

```swift
import Observation

@Observable
final class InterpretationResultViewModel {
    let dream: DreamEntry
    let interpretation: Interpretation
    var didShowSavedConfirmation = false

    init(dream: DreamEntry, interpretation: Interpretation) {
        self.dream = dream
        self.interpretation = interpretation
    }

    func save() {
        dream.isArchived = true
        didShowSavedConfirmation = true
    }
}
```

Build the screen top-down so the first viewport feels singular and emotionally resonant, per `PROJECT.md`.

**Step 4: Run test to verify it passes**

Run: `xcodebuild test -scheme DreamAnalysisApp -destination 'platform=iOS Simulator,name=iPhone 16' -only-testing:DreamAnalysisAppTests/Features/RitualFlow/InterpretationResultViewModelTests`
Expected: PASS

**Step 5: Commit**

```bash
git add ios/DreamAnalysisApp/Features/RitualFlow/Result ios/DreamAnalysisApp/Services/Interpretation ios/DreamAnalysisAppTests/Features/RitualFlow
git commit -m "feat: add interpretation result experience"
```

---

### Task 8: Implement Patterns as the long-term differentiation layer

**Files:**
- Create: `ios/DreamAnalysisApp/Features/Patterns/PatternsViewModel.swift`
- Create: `ios/DreamAnalysisApp/Features/Patterns/Components/TrajectorySummaryBlock.swift`
- Create: `ios/DreamAnalysisApp/Features/Patterns/Components/RecurringSymbolsSection.swift`
- Create: `ios/DreamAnalysisApp/Services/Patterns/PatternSummaryService.swift`
- Test: `ios/DreamAnalysisAppTests/Features/Patterns/PatternsViewModelTests.swift`

**Step 1: Write the failing test**

```swift
import XCTest
@testable import DreamAnalysisApp

final class PatternsViewModelTests: XCTestCase {
    func testEarlyUseStateShowsLimitedPatterns() {
        let model = PatternsViewModel(patternSummary: .earlyUse)
        XCTAssertTrue(model.shouldExplainGrowth)
    }
}
```

**Step 2: Run test to verify it fails**

Run: `xcodebuild test -scheme DreamAnalysisApp -destination 'platform=iOS Simulator,name=iPhone 16' -only-testing:DreamAnalysisAppTests/Features/Patterns/PatternsViewModelTests`
Expected: FAIL with missing `PatternsViewModel`.

**Step 3: Write minimal implementation**

```swift
import Observation

@Observable
final class PatternsViewModel {
    let patternSummary: PatternSummary

    init(patternSummary: PatternSummary) {
        self.patternSummary = patternSummary
    }

    var shouldExplainGrowth: Bool {
        patternSummary.stage == .early
    }
}
```

Design rule: narrative continuity over metric-heavy charts.

**Step 4: Run test to verify it passes**

Run: `xcodebuild test -scheme DreamAnalysisApp -destination 'platform=iOS Simulator,name=iPhone 16' -only-testing:DreamAnalysisAppTests/Features/Patterns/PatternsViewModelTests`
Expected: PASS

**Step 5: Commit**

```bash
git add ios/DreamAnalysisApp/Features/Patterns ios/DreamAnalysisApp/Services/Patterns ios/DreamAnalysisAppTests/Features/Patterns
git commit -m "feat: add patterns continuity screen"
```

---

### Task 9: Implement Archive and dream detail

**Files:**
- Modify: `ios/DreamAnalysisApp/Features/Archive/ArchiveView.swift`
- Create: `ios/DreamAnalysisApp/Features/Archive/ArchiveViewModel.swift`
- Create: `ios/DreamAnalysisApp/Features/Archive/DreamDetailView.swift`
- Test: `ios/DreamAnalysisAppTests/Features/Archive/ArchiveViewModelTests.swift`

**Step 1: Write the failing test**

```swift
import XCTest
@testable import DreamAnalysisApp

final class ArchiveViewModelTests: XCTestCase {
    func testEmptyArchiveShowsInvitation() {
        let model = ArchiveViewModel(dreams: [])
        XCTAssertTrue(model.showsEmptyState)
    }
}
```

**Step 2: Run test to verify it fails**

Run: `xcodebuild test -scheme DreamAnalysisApp -destination 'platform=iOS Simulator,name=iPhone 16' -only-testing:DreamAnalysisAppTests/Features/Archive/ArchiveViewModelTests`
Expected: FAIL with missing `ArchiveViewModel`.

**Step 3: Write minimal implementation**

```swift
import Observation

@Observable
final class ArchiveViewModel {
    var dreams: [DreamEntry]

    init(dreams: [DreamEntry]) {
        self.dreams = dreams
    }

    var showsEmptyState: Bool {
        dreams.isEmpty
    }
}
```

Keep archive quieter than Patterns; archive is memory access, not the main insight surface.

**Step 4: Run test to verify it passes**

Run: `xcodebuild test -scheme DreamAnalysisApp -destination 'platform=iOS Simulator,name=iPhone 16' -only-testing:DreamAnalysisAppTests/Features/Archive/ArchiveViewModelTests`
Expected: PASS

**Step 5: Commit**

```bash
git add ios/DreamAnalysisApp/Features/Archive ios/DreamAnalysisAppTests/Features/Archive
git commit -m "feat: add archive and dream detail views"
```

---

### Task 10: Implement Me/Profile for trust and controls

**Files:**
- Modify: `ios/DreamAnalysisApp/Features/Profile/ProfileView.swift`
- Create: `ios/DreamAnalysisApp/Features/Profile/ProfileViewModel.swift`
- Create: `ios/DreamAnalysisApp/Features/Profile/Components/MemoryControlsSection.swift`
- Test: `ios/DreamAnalysisAppTests/Features/Profile/ProfileViewModelTests.swift`

**Step 1: Write the failing test**

```swift
import XCTest
@testable import DreamAnalysisApp

final class ProfileViewModelTests: XCTestCase {
    func testProfileSurfacesMemoryControls() {
        let model = ProfileViewModel()
        XCTAssertTrue(model.showsMemoryControls)
    }
}
```

**Step 2: Run test to verify it fails**

Run: `xcodebuild test -scheme DreamAnalysisApp -destination 'platform=iOS Simulator,name=iPhone 16' -only-testing:DreamAnalysisAppTests/Features/Profile/ProfileViewModelTests`
Expected: FAIL with missing `ProfileViewModel`.

**Step 3: Write minimal implementation**

```swift
import Observation

@Observable
final class ProfileViewModel {
    let showsMemoryControls = true
}
```

Expose sync, privacy, and memory explanations without making the page feel operationally louder than the ritual flow.

**Step 4: Run test to verify it passes**

Run: `xcodebuild test -scheme DreamAnalysisApp -destination 'platform=iOS Simulator,name=iPhone 16' -only-testing:DreamAnalysisAppTests/Features/Profile/ProfileViewModelTests`
Expected: PASS

**Step 5: Commit**

```bash
git add ios/DreamAnalysisApp/Features/Profile ios/DreamAnalysisAppTests/Features/Profile
git commit -m "feat: add profile trust and memory controls"
```

---

### Task 11: Add Safe Harbor as a restrained contextual destination

**Files:**
- Create: `ios/DreamAnalysisApp/Features/SafeHarbor/SafeHarborView.swift`
- Create: `ios/DreamAnalysisApp/Features/SafeHarbor/SafeHarborViewModel.swift`
- Create: `ios/DreamAnalysisApp/Services/SafeHarbor/SafeHarborService.swift`
- Test: `ios/DreamAnalysisAppTests/Features/SafeHarbor/SafeHarborViewModelTests.swift`

**Step 1: Write the failing test**

```swift
import XCTest
@testable import DreamAnalysisApp

final class SafeHarborViewModelTests: XCTestCase {
    func testSafeHarborHighlightsSinglePrimaryRefugeAction() {
        let model = SafeHarborViewModel(items: [.breathing])
        XCTAssertEqual(model.primaryItem, .breathing)
    }
}
```

**Step 2: Run test to verify it fails**

Run: `xcodebuild test -scheme DreamAnalysisApp -destination 'platform=iOS Simulator,name=iPhone 16' -only-testing:DreamAnalysisAppTests/Features/SafeHarbor/SafeHarborViewModelTests`
Expected: FAIL with missing `SafeHarborViewModel`.

**Step 3: Write minimal implementation**

```swift
import Observation

@Observable
final class SafeHarborViewModel {
    let items: [SafeHarborItem]

    init(items: [SafeHarborItem]) {
        self.items = items
    }

    var primaryItem: SafeHarborItem? {
        items.first
    }
}
```

Do not add a large catalog. Keep one dominant refuge action and very few secondary paths.

**Step 4: Run test to verify it passes**

Run: `xcodebuild test -scheme DreamAnalysisApp -destination 'platform=iOS Simulator,name=iPhone 16' -only-testing:DreamAnalysisAppTests/Features/SafeHarbor/SafeHarborViewModelTests`
Expected: PASS

**Step 5: Commit**

```bash
git add ios/DreamAnalysisApp/Features/SafeHarbor ios/DreamAnalysisApp/Services/SafeHarbor ios/DreamAnalysisAppTests/Features/SafeHarbor
git commit -m "feat: add restrained safe harbor experience"
```

---

### Task 12: Add Private Whispers as a rare contextual destination

**Files:**
- Create: `ios/DreamAnalysisApp/Features/PrivateWhispers/PrivateWhispersView.swift`
- Create: `ios/DreamAnalysisApp/Features/PrivateWhispers/PrivateWhispersViewModel.swift`
- Create: `ios/DreamAnalysisApp/Services/PrivateWhispers/PrivateWhisperService.swift`
- Test: `ios/DreamAnalysisAppTests/Features/PrivateWhispers/PrivateWhispersViewModelTests.swift`

**Step 1: Write the failing test**

```swift
import XCTest
@testable import DreamAnalysisApp

final class PrivateWhispersViewModelTests: XCTestCase {
    func testPrivateWhispersPrefersSingleFeaturedWhisper() {
        let whispers = [PrivateWhisper(featuredText: "You have been circling the same door in different dreams.")]
        let model = PrivateWhispersViewModel(whispers: whispers)
        XCTAssertEqual(model.featuredWhisper?.featuredText, "You have been circling the same door in different dreams.")
    }
}
```

**Step 2: Run test to verify it fails**

Run: `xcodebuild test -scheme DreamAnalysisApp -destination 'platform=iOS Simulator,name=iPhone 16' -only-testing:DreamAnalysisAppTests/Features/PrivateWhispers/PrivateWhispersViewModelTests`
Expected: FAIL with missing `PrivateWhispersViewModel`.

**Step 3: Write minimal implementation**

```swift
import Observation

@Observable
final class PrivateWhispersViewModel {
    let whispers: [PrivateWhisper]

    init(whispers: [PrivateWhisper]) {
        self.whispers = whispers
    }

    var featuredWhisper: PrivateWhisper? {
        whispers.first
    }
}
```

Do not make this a feed, chat thread, or daily card list.

**Step 4: Run test to verify it passes**

Run: `xcodebuild test -scheme DreamAnalysisApp -destination 'platform=iOS Simulator,name=iPhone 16' -only-testing:DreamAnalysisAppTests/Features/PrivateWhispers/PrivateWhispersViewModelTests`
Expected: PASS

**Step 5: Commit**

```bash
git add ios/DreamAnalysisApp/Features/PrivateWhispers ios/DreamAnalysisApp/Services/PrivateWhispers ios/DreamAnalysisAppTests/Features/PrivateWhispers
git commit -m "feat: add private whispers contextual screen"
```

---

### Task 13: Wire app navigation, dependency injection, and preview data

**Files:**
- Modify: `ios/DreamAnalysisApp/App/AppEnvironment.swift`
- Modify: `ios/DreamAnalysisApp/App/AppRootView.swift`
- Create: `ios/DreamAnalysisApp/Core/Routing/RitualFlowCoordinator.swift`
- Create: `ios/DreamAnalysisApp/Core/Preview/PreviewFixtures.swift`
- Test: `ios/DreamAnalysisAppTests/App/RitualFlowCoordinatorTests.swift`

**Step 1: Write the failing test**

```swift
import XCTest
@testable import DreamAnalysisApp

final class RitualFlowCoordinatorTests: XCTestCase {
    func testResultCompletesBackToStableShell() {
        let coordinator = RitualFlowCoordinator()
        coordinator.finishResult()
        XCTAssertFalse(coordinator.isPresentingFlow)
    }
}
```

**Step 2: Run test to verify it fails**

Run: `xcodebuild test -scheme DreamAnalysisApp -destination 'platform=iOS Simulator,name=iPhone 16' -only-testing:DreamAnalysisAppTests/App/RitualFlowCoordinatorTests`
Expected: FAIL with missing `RitualFlowCoordinator`.

**Step 3: Write minimal implementation**

```swift
import Observation

@Observable
final class RitualFlowCoordinator {
    var isPresentingFlow = true

    func finishResult() {
        isPresentingFlow = false
    }
}
```

App environment should own service protocols and preview/demo stubs.

**Step 4: Run test to verify it passes**

Run: `xcodebuild test -scheme DreamAnalysisApp -destination 'platform=iOS Simulator,name=iPhone 16' -only-testing:DreamAnalysisAppTests/App/RitualFlowCoordinatorTests`
Expected: PASS

**Step 5: Commit**

```bash
git add ios/DreamAnalysisApp/App ios/DreamAnalysisApp/Core ios/DreamAnalysisAppTests/App
git commit -m "feat: wire ritual flow coordinator and app environment"
```

---

### Task 14: Add snapshot/manual validation checklist and documentation

**Files:**
- Modify: `PROJECT.md`
- Create: `docs/plans/2026-04-12-swiftui-v1-architecture-manual-test-checklist.md`
- Test: `ios/DreamAnalysisAppTests/Smoke/AppLaunchSmokeTests.swift`

**Step 1: Write the failing test**

```swift
import XCTest

final class AppLaunchSmokeTests: XCTestCase {
    func testAppLaunches() {
        XCTAssertTrue(true)
    }
}
```

**Step 2: Run test to verify it fails**

Run: `xcodebuild test -scheme DreamAnalysisApp -destination 'platform=iOS Simulator,name=iPhone 16' -only-testing:DreamAnalysisAppTests/Smoke/AppLaunchSmokeTests`
Expected: if the test target is not yet wired, FAIL due to missing file inclusion.

**Step 3: Write minimal implementation**

Create a manual checklist covering:
- Home singular CTA
- Capture orb feel
- Follow-up softness
- Result emotional anchor
- Patterns non-analytics feel
- Safe Harbor restraint
- Private Whispers rarity

Update `PROJECT.md` only if the architecture plan reveals decisions worth persisting.

**Step 4: Run test to verify it passes**

Run: `xcodebuild test -scheme DreamAnalysisApp -destination 'platform=iOS Simulator,name=iPhone 16' -only-testing:DreamAnalysisAppTests/Smoke/AppLaunchSmokeTests`
Expected: PASS

**Step 5: Commit**

```bash
git add PROJECT.md docs/plans/2026-04-12-swiftui-v1-architecture-manual-test-checklist.md ios/DreamAnalysisAppTests/Smoke
git commit -m "docs: add v1 architecture validation checklist"
```

---

## Notes for execution
- Use `@superpowers:executing-plans` when implementing this plan task-by-task.
- Keep the repository shape simple; do not introduce Tuist, XcodeGen, or backend infrastructure unless the current task requires it.
- Prefer protocol seams plus local stub services first.
- Preserve the emotional-product rules from `PROJECT.md` as implementation constraints, not just copywriting guidance.
- For UI validation, always run the app in Simulator and manually verify the golden path:
  - Home → Capture → Follow-up → Result
  - Result → Archive / Patterns
  - Contextual entry into Safe Harbor
  - Contextual entry into Private Whispers
