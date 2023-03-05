//
//  ViewControllerVK.swift
//  Integration_Social_Seti
//
//  Created by Андрей Балобанов on 16.11.2022.
//

import UIKit
import VK_ios_sdk
import Alamofire

class ViewControllerVK: UIViewController {
        
        var user = VKModel()
        var userToken = ""
        let image = UIImage(named: "foto")
        var userFoto:[Items] = []
        
        override func viewDidAppear(_ animated:Bool) {
            super.viewDidAppear(true)
            let url = "https://api.vk.com/method/photos.get?album_id=wall&v=5.131&access_token=\(self.userToken)"

            AF.request(url).responseDecodable(of:Data.self ) { response in
                if let data = response.value{
                    self.userFoto = data.response.items
                    print(self.userFoto[1].sizes[3].url)
                } else { print("ошибка получения фото")}
            }
        }
        
        @IBAction func exitButton(_ sender: Any) {
            VKSdk.forceLogout()
            self.dismiss(animated: true, completion: nil)
        }
        
        @IBAction func loadImageButton(_ sender: Any) {
            let vc = storyboard!.instantiateViewController(withIdentifier: "ViewControllerFotoUser") as! ViewControllerFotoUser
            present(vc, animated: true, completion: nil)
            vc.userFoto = self.userFoto
            vc.count = userFoto.count
        }
    }
