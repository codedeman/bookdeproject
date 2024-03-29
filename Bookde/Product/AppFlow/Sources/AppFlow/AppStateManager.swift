import Combine
import DBService
import Authenticate
import FirebaseAuth
import MessageCenter

public enum AppStep: Hashable {
    case startAuth
    case startHome
    case finish
}

public final class AppStateManager: ObservableObject {

    private var subscription = Set<AnyCancellable>()
    @Published private var messageState: NewMessageState
    @Published  var myAuthState: MyAuthenticateState = .init(id: "")
    @Published var myAppState: MyAppState = .init(appState: .startSignIn)
    @Published var appState: [AppState] = []
    private var diContainer: AppDIContainer
    public init(
        diContainer: AppDIContainer = .init(
            dependencies: .init(
                authUseCase: ImplAuthenticateUseCase(),
                mesageUseCase: ImplMessageUseCase()
            )
        )
    ) {
        messageState = .init(user: .init(email: "", profileUrl: "", uiid: ""))
        self.myAuthState = .init(id: "")
        self.diContainer = diContainer
        let myAuthPublisher = $myAuthState
            .flatMap { $0.$user }
            .compactMap { $0 }
            .map {
                MyAppState(
                    appState: .startCreateNewMessage(
                        user: .init(
                            email: $0.email ?? "",
                            profileUrl: "",
                            uiid: $0.uid
                        )
                    )
                )
            }
            .assertNoFailure()
            .share()

        myAuthPublisher
            .assign(to: &$myAppState)

    }

    @MainActor func messageViewModel() -> MessageNewFeedViewModel {
        return MessageNewFeedViewModel(
            useCase: diContainer
                .dependencies
                .mesageUseCase
        )
    }

    @MainActor func signInViewModel() -> SignInViewModel {
        return SignInViewModel(
            useCase: diContainer
                .dependencies
                .authUseCase
        )
    }

    func signUpViewModel() -> SignUpViewModel {
        return  SignUpViewModel(
            useCase: diContainer
                .dependencies
                .authUseCase
        )
    }
    @MainActor
    func newMesageViewModel(user: UserChat) -> NewMessageViewModel {
        return NewMessageViewModel(
            usecase: diContainer
                .dependencies
                .mesageUseCase,
            user: user
        )
    }
}
