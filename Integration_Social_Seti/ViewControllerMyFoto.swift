//
//  ViewControllerMyFoto.swift
//  Integration_Social_Seti
//
//  Created by Андрей Балобанов on 05.03.2023.
//

import UIKit
import Alamofire

class ViewControllerMyFoto: UIViewController {
        
    @IBOutlet weak var userImageView: UIImageView!
        var foto: String = ""

        override func viewDidLoad() {
            super.viewDidLoad()
            //показ выбранного фото
            DispatchQueue.global(qos: .utility).async { [weak self] in
                        AF.download(self!.foto).responseData {(response) in
                        if let data = response.value {
                            let imageData = UIImage(data: data)
                            DispatchQueue.main.async { [weak self] in
                            self!.userImageView.image = imageData
                            }
                        }
                      }
                    }

        }
        
        @IBAction func exit(_ sender: Any) { // закрыть экран
            self.dismiss(animated: true, completion: nil)
        }
    }
