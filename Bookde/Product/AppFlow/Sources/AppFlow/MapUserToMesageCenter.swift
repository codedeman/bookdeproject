//
//  File.swift
//  
//
//  Created by Kevin on 12/9/23.
//

import Foundation
import MessageCenter
import Authenticate
extension UserChat {

    func mapToUserChat(user: UserProfile) -> UserChat {
        return UserChat(email: user.email ?? "",
                        profileUrl:  "",
                        uiid: user.uid
        )
    }

}
