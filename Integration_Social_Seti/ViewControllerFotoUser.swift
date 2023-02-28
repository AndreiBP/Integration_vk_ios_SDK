//
//  ViewControllerFotoUser.swift
//  Integration_Social_Seti
//
//  Created by Андрей Балобанов on 28.01.2023.
//

import UIKit
import Alamofire

class ViewControllerFotoUser: UIViewController {
    
    @IBOutlet weak var userImageView: UIImageView!
    
    var userFoto: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(userFoto)
        DispatchQueue.global(qos: .utility).async { [weak self] in
            AF.download(self!.userFoto).responseData {(response) in
                if let data = response.value {
                    let imageData = UIImage(data: data)
                    DispatchQueue.main.async { [weak self] in
                        self!.userImageView.image = imageData
                    }
                }
            }
        }
    }
    
    @IBAction func exitButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
