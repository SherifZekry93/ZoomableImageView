//
//  ImageView.swift
//  ChatAppLBTA
//
//  Created by Sherif  Wagih on 12/15/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit
class ZommableImageView: UIImageView
{
    var startingFrame:CGRect?
    lazy var zoomingImageView:UIImageView  = {
        let image = UIImageView()
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleZoomOut)))
        image.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleZoomPan)))
        return image
    }()
    lazy var blackBGView : UIView = {
        let bg = UIView()
        bg.backgroundColor = .black
        return bg
    }()
    override init(frame: CGRect) {
        super.init(frame:.zero)
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(zoomInImage)))
    }
    init()
    {
        super.init(frame: .zero)
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(zoomInImage)))
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(zoomInImage)))
    }
    fileprivate func zoomOut(_ zoomOutImage: UIImageView) {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            zoomOutImage.frame = self.startingFrame!
            self.blackBGView.alpha = 0
        }, completion: { (completed) in
            self.zoomingImageView.removeFromSuperview()
        })
    }
    
    @objc func handleZoomOut(tapGesture:UITapGestureRecognizer)
    {
        if let zoomOutImage = tapGesture.view as? UIImageView
        {
            zoomOut(zoomOutImage)
        }
    }
    @objc func zoomInImage(gesture: UITapGestureRecognizer) {
        guard let image = gesture.view as? UIImageView else {return}
        startingFrame = image.superview?.convert(image.frame, to: nil)
        zoomingImageView.frame = startingFrame!
        zoomingImageView.image = image.image
        blackBGView.alpha = 0
        if let keyWindow =   UIApplication.shared.keyWindow
        {
            blackBGView.frame = keyWindow.frame
            keyWindow.addSubview(blackBGView)
            let height = startingFrame!.height / startingFrame!.width * keyWindow.frame.width
            keyWindow.addSubview(zoomingImageView)
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                self.zoomingImageView.frame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
                self.zoomingImageView.center = keyWindow.center
                self.blackBGView.alpha = 1
            }, completion: nil)
        }
    }
    @objc func handleZoomPan(_ gesture:UIPanGestureRecognizer)
    {
        let velocity = gesture.velocity(in: self)
        let translation = gesture.translation(in: self)
        guard let  zoomOutImage = gesture.view as? UIImageView else {return}

        switch gesture.state {
        case .ended:
            if abs(velocity.x) < 700
            {
                UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.6, options: .curveEaseInOut, animations: {
                    zoomOutImage.transform = .identity
                }, completion: nil)
            }
        case .changed:
                if abs(velocity.y) > 700
                {
                    zoomOut(zoomOutImage)
                }
                else
                {
                    zoomOutImage.transform = CGAffineTransform(translationX: zoomOutImage.frame.origin.x, y: translation.y)
                }
        default:
            print()
        }
        
        /*let translation = gesture.translation(in: nil)
         if let zoomOutImage = gesture.view as? UIImageView
         {
         guard let startingFrame = startingFrame else {return}
         /*UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
         self.blackBGView.alpha = abs(1/translation.y)
         }, completion: nil)*/
         switch gesture.state
         {
         case .changed:
         let velocity = gesture.velocity(in: nil)
         if abs(velocity.y) > 500
         {
         zoomOut(zoomOutImage)
         }
         else
         {
         //zoomOutImage.transform = CGAffineTransform(translationX: zoomOutImage.frame.origin.x, y: translation.y)
         }
         case .ended:
         print("ended")
         /*zoomOutImage.transform = .identity
         UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
         if self.blackBGView.alpha !=  1
         {
         self.blackBGView.alpha = 1
         }
         }, completion: nil)*/
         default:
         print("hello")
         }
         }*/
    }
}
