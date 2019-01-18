//
//  ViewController.swift
//  ZoomableImageView
//
//  Created by Sherif  Wagih on 12/15/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let zoommableImageView:ZommableImageView = {
        let zoom = ZommableImageView()
        zoom.translatesAutoresizingMaskIntoConstraints = false
        zoom.image = #imageLiteral(resourceName: "zoommein")
        return zoom
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(zoommableImageView)
        zoommableImageView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        zoommableImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
         zoommableImageView.widthAnchor.constraint(equalToConstant:50).isActive = true
         zoommableImageView.heightAnchor.constraint(equalToConstant:50).isActive = true
    }
    
    
}

