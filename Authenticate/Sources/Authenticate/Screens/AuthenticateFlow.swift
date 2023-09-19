//
//  SwiftUIView.swift
//  
//
//  Created by Kevin on 9/24/23.
//

//import Combine
//import DBService
//protocol Navigable: AnyObject, Identifiable, Hashable {}
//
//extension Navigable {
//    public static func == (lhs: Self, rhs: Self) -> Bool {
//        lhs.id == rhs.id
//    }
//    public func hash(into hasher: inout Hasher) {
//        hasher.combine(id)
//    }
//}
//
//public enum AuthenticationStep: Hashable {
//    case startSignUp
//    case finish
//}
//
//public final class AuthenticateFlow: ObservableObject {
//    @Published var navigationPath: [AuthenticationStep] = []
//    var subscription = Set<AnyCancellable>()
//    let step = PassthroughSubject<UserProfile, Never>()
//    @Published var isDismissed: Bool = false
//    public init(navigationPath: [AuthenticationStep]) {
//        self.navigationPath = navigationPath
//    }
//    
//    func startFlow() -> SignInViewModel {
//        let signUpUseCase = SignUpUseCaseImpl()
//        let signInViewModel = SignInViewModel(useCase: signUpUseCase)
//
//        return signInViewModel
//    }
//
//    public func startSignUp() -> SignUpView {
//        let signUpUseCase = SignUpUseCaseImpl()
//        let viewModel: SignInViewModel = .init(useCase: signUpUseCase)
//        
//        let signUpView = SignUpView(viewModel: .init(useCase: signUpUseCase))
//        return signUpView
//    }
//
//    func dissmissViewModel(user: UserProfile) {
////        self.navigationPath.removeLast()
//    }
//
//
//    func showErrorView() {
//
//
//    }
//
//    
//}
