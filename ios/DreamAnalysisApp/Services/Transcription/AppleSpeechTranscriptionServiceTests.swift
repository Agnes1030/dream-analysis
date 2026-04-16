import XCTest
@testable import DreamAnalysisApp

final class AppleSpeechTranscriptionServiceTests: XCTestCase {
    func testRequestPermissionsReturnsAuthorizedForPreviewStub() async {
        let service = AppEnvironment.preview().speechTranscriptionService

        let status = await service.requestPermissions()

        XCTAssertEqual(status, .authorized)
    }

    func testPreviewStubProvidesTranscriptEvents() throws {
        let service = AppEnvironment.preview().speechTranscriptionService
        let stream = try service.startTranscribing(locale: Locale(identifier: "zh-CN"))
        var events: [SpeechTranscriptionEvent] = []
        let expectation = expectation(description: "Receive preview transcription events")

        Task {
            for await event in stream {
                events.append(event)
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)

        XCTAssertEqual(events.first, .started)
        XCTAssertTrue(events.contains(.finished(finalText: "I was walking through a silver field.")))
    }
}
