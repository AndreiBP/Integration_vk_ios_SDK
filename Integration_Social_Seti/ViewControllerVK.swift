//
//  ViewControllerVK.swift
//  Integration_Social_Seti
//
//  Created by Андрей Балобанов on 25.01.2023.
//

import UIKit
import VK_ios_sdk
import Alamofire

class ViewControllerVK: UIViewController {

    var user = VKModel()
    var userToken = "0"
    let image = UIImage(named: "foto")
    var userFoto:[Items] = []
    
    
   
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        //user_id=51476553& - это в новой версии не надо
        let url = "https://api.vk.com/method/photos.get?album_id=wall&v=5.131&access_token=\(self.userToken)"
        print(userToken)
        AF.request(url).responseDecodable(of: Data.self ) { response in
            if let data = response.value{
                self.userFoto = data.response.items
                print("фото получены")

            } else { print("ошибка получения фото")}
        }
    }
    
    @IBAction func exitVKButton(_ sender: Any) {
        VKSdk.forceLogout()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func loadMayImageTheVKButton(_ sender: Any) {
        //передаем выбранного фото дальше
        let vc = storyboard!.instantiateViewController(withIdentifier: "ViewControllerMyFoto") as! ViewControllerMyFoto
        present(vc, animated: true, completion: nil)
        vc.myFoto = self.userFoto
        vc.myCountFoto = userFoto.count
    }
}
