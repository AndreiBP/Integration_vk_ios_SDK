//
//  VKModel.swift
//  Integration_Social_Seti
//
//  Created by Андрей Балобанов on 10.01.2023.
//

import Foundation
import VK_ios_sdk
import Alamofire


class VKModel {
    static let shared = VKModel()
    let kVK_APP_ID = "51476553"
    let permissions = NSArray(objects: "email", "wall", "photos") as [AnyObject]
    var userToken = ""
    
    var userEmail = String()
    
    func vkLogin(completion: @escaping (Bool) -> ()) {
        VKSdk.wakeUpSession(self.permissions, complete: { (state, error) in
            if state == .authorized && error == nil && VKSdk.accessToken() != nil {
                print("авторизован")
                completion(true)
            } else if state == .initialized {
                print("требуется авторизация")
                VKSdk.authorize(self.permissions)
            } else {
                if error != nil {
                    print("ошибка авторизации")
                }
                completion(false)
            }
        })
    }
}
struct Data: Codable {
    let response: Response
}

struct Response: Codable {
    let count: Int?
    let items: [Items]
}
struct Items: Codable {
    let sizes: [Sizes]
}
struct Sizes: Codable {
    let url: String
}
