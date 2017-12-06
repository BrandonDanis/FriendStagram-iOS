//
//  ProfileViewCell.swift
//  FriendStagram
//
//  Created by Brandon Danis on 2017-12-05.
//  Copyright © 2017 Brandon Danis. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewCell : UICollectionViewCell {
    
    var post : Post? = nil {
        didSet {
            imageView.image = UIImage(named: "placeholder")
            
            if let imageString = post?.image_url {
                NetworkManager.shared.GetImageByUrl(imageString) { (image) in
                    guard image != nil else { return }
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                }
            }
        }
    }
    
    private let imageView : UIImageView = {
        let view = UIImageView(image: UIImage(named: "placeholder"))
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        
        ApplyConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func ApplyConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
    }
}
