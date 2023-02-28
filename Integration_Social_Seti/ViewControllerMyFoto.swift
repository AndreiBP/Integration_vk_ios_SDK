//
//  ViewControllerMyFoto.swift
//  Integration_Social_Seti
//
//  Created by Андрей Балобанов on 28.01.2023.
//

import UIKit
import Alamofire

class ViewControllerMyFoto: UIViewController {

    var myFoto:[Items] = []
    var myCountFoto: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myCountFoto = myFoto.count
    }
}

extension ViewControllerMyFoto: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = UIScreen.main.bounds.size.width / 2.0 - 1
        let h = UIScreen.main.bounds.size.width / 1.2
        return CGSize(width: w, height: h )
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        print(indexPath)
        let vc1 = storyboard!.instantiateViewController(identifier: "ViewControllerFotoUser") as! ViewControllerFotoUser
        vc1.userFoto = myFoto[indexPath.row].sizes[3].url
        present(vc1, animated: true, completion: nil)
       
    }
    
func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return myFoto.count
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCellMyFoto
    let item = myFoto[indexPath.row].sizes[3].url
    
    DispatchQueue.global(qos: .utility).async { [weak self] in
    AF.download(item).responseData {(response) in
        if let data = response.value {
            let imageData = UIImage(data: data)
            DispatchQueue.main.async { [weak self] in
                cell.myImageView.image = imageData
            }
        }
      }
    }
    return cell
    }
}
