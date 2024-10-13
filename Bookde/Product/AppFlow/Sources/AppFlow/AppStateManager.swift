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
    public var diContainer: AppDIContainer
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

class Configuration {

}
