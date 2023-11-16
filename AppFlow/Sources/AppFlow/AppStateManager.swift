
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

    var subscription = Set<AnyCancellable>()

    @Published var appState: [AppState] = []
    @Published var myAuthState: AuthenticateState = .none
    @Published var messageState: NewMessageState

    private var diContainer: AppDIContainer

    public init(
        diContainer: AppDIContainer = .init(
            dependencies: .init(
                authUseCase: ImplAuthenticateUseCase(),
                mesageUseCase: ImplMessageUseCase()
            )
        )
    ) {
        messageState = .init(user: nil)
        self.diContainer = diContainer
    }

    @MainActor func messageViewModel() -> MessageNewFeedViewModel {
        let vm = MessageNewFeedViewModel(useCase: diContainer.dependencies.mesageUseCase)

        vm.state.sink { error in

        } receiveValue: { [weak self] messageState in
            switch messageState {
            case .startCreateNewMessage(let user):
                self?.messageState = .init(user: user)
                self?.appState.append(.startCreateNewMessage(user: user))
            default:
                break
            }
        }.store(in: &subscription)

        return vm
    }


    @MainActor func signInViewModel() -> SignInViewModel {
        let vm = SignInViewModel(
            useCase: diContainer.dependencies.authUseCase
        )

        vm.state.sink { error in

        } receiveValue: { [weak self] state in
            switch state {
            case .finished:
                self?.appState.append(.startHome)
            case .startSignUp:
                self?.appState.append(.startSignUp)
            case .userAuthenticated:
                self?.appState.append(.startHome)
            default:
                break
            }
        }.store(in: &subscription)

        return vm
    }

    func signUpViewModel() -> SignUpViewModel {
        let vm = SignUpViewModel(useCase: diContainer.dependencies.authUseCase)
        return vm
    }

    func newMesageViewModel(user: UserChat) -> NewMessageViewModel {
        messageState.$user.sink { usechat in
            print("❤️",usechat)
        }.store(in: &subscription)
        let vm = NewMessageViewModel(
            usecase: diContainer.dependencies.mesageUseCase,
            user: user
        )
        return vm
    }
}
