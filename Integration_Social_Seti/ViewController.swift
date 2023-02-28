//
//  ViewController.swift
//  Integration_Social_Seti
//
//  Created by Андрей Балобанов on 14.11.2022.
//

import UIKit
import VK_ios_sdk
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    var auth = false
    var user = VKModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let sdkInstance = VKSdk.initialize(withAppId: self.user.kVK_APP_ID)
        sdkInstance?.register(self)
    }
    override func viewDidAppear(_ animated:Bool) {
        super.viewDidAppear(true)
        if auth {
            showApp()
            print("выполнено открытие экрана добавления фото")
        }
    }
    
    @IBAction func autorizationVK(_ sender: Any) {
        VKSdk.wakeUpSession(["email"], complete: { [self] (state, error) in
            if state == .authorized && error == nil && VKSdk.accessToken() != nil {
                print("авторизация уже есть")
                self.user.userToken = VKSdk.accessToken().accessToken
                self.auth = true
                self.showApp()
            } else {
                VKSdk.authorize(["email"])
                print("нужна авторизация")
            }
        })
    }
}
    
extension ViewController: VKSdkDelegate {
    
        func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
print("токен получили записали")
            if result.token != nil && result.error == nil {
                    self.user.userToken = result.token.accessToken
                    self.auth = true
                    print("ВХОД ВЫПОЛНЕН")
            } else {
                print("ОШИБКА ")
                print("\(String(describing: result.error))")
            }
        }
        
        func showApp() {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let newVC = storyboard.instantiateViewController(withIdentifier: "ViewControllerVK") as! ViewControllerVK
            present(newVC, animated: true, completion: nil)
            newVC.userToken = self.user.userToken
            print("закрыли сафари открыли экран для добавления фото")
        }
        
        func vkSdkUserAuthorizationFailed() {
            print("vkSdkUserAuthorizationFailed")
        }
        
    }
