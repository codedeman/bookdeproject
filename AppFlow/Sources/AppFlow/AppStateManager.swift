
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
    private var diContainer: AppDIContainer

    public init(
        diContainer: AppDIContainer = .init(
            dependencies: .init(
                authUseCase: ImplAuthenticateUseCase(),
                mesageUseCase: ImplMessageUseCase()
            )
        )
    ) {
        
        self.diContainer = diContainer
    }

    @MainActor func messageViewModel() -> MessageNewFeedViewModel {
        let vm = MessageNewFeedViewModel(useCase: diContainer.dependencies.mesageUseCase)

        vm.state.sink { error in

        } receiveValue: { [weak self] messageState in
            switch messageState {
            case .startCreateNewMessage(let user):
                print("➡️ user",user)
                self?.appState.append(.startCreateNewMessage)
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

    func newMesageViewModel() -> NewMessageViewModel {
        let vm = NewMessageViewModel(usecase: diContainer.dependencies.mesageUseCase)
        return vm
    }
}
