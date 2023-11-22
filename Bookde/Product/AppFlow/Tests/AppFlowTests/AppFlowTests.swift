import XCTest
import AuthenticateMocks
import MessageCenter
@testable import AppFlow
@testable import Authenticate

final class AppFlowTests: XCTestCase {

    var sut: AppStateManager?
    override func setUp() {
        super.setUp()
        sut = .init(
            diContainer: .init(
                dependencies: .init(
                    authUseCase: ImplMockAuthenticateUseCase(isSucess: true),
                    mesageUseCase: ImplMessageUseCase())
            )
        )
    }

    override  func tearDown() {
        super.tearDown()
        sut = nil
    }

    func testNavigateWhenSignInSuccess() async throws {
        let vm =  await sut?.signInViewModel()
        await vm?.signUp(email: "kevin@gmail.com", passworld: "123")
        XCTAssertEqual(sut?.appState.last, .startHome)
    }

    func testDidTapSingUp() async throws {
        let vm =  await sut?.signInViewModel()
        await vm?.didTapSignUp()
        XCTAssertEqual(sut?.appState.last, .startSignUp)
    }

}
