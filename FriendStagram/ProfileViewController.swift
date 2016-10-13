//
//  ProfileViewController.swift
//  FriendStagram
//
//  Created by Brandon Danis on 2016-10-06.
//  Copyright © 2016 RBSoftware. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class ProfileViewController : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var images = [
        "http://4.bp.blogspot.com/-F_6SfcFHKRE/UIjJKWfbt8I/AAAAAAAAA6w/AK5H_oGl9io/s1600/nature182.jpg",
        "http://rising.blackstar.com/wp-content/uploads/2012/08/95432c1c89bd11e1a9f71231382044a1_7-450x450.jpg",
        "https://s-media-cache-ak0.pinimg.com/originals/58/50/77/585077f705e1e1e6385940fee0e6a4d7.jpg",
        "http://blog.ink361.com/wp-content/uploads/2014/11/@hamiltonguevara-.jpg",
        "https://s-media-cache-ak0.pinimg.com/564x/94/a9/db/94a9db37f653d29075f14611c1bd7359.jpg",
        "http://blogcdn.befunky.com/wp-content/uploads/2015/11/Screen-shot-2015-11-09-at-12.55.33-PM.png",
        "http://imgs.abduzeedo.com/files/paul0v2/livefolk/livefolk-07.jpg",
        "http://hahaha.in/wp-content/uploads/2013/04/8e744a5aa38511e2b8e822000a1fbcc7_72.jpg",
        "http://s1.favim.com/610/150710/art-background-beautiful-dark-Favim.com-2933701.jpg",
        "http://66.media.tumblr.com/tumblr_mdd8uyvpgQ1reash6o2_1280.jpg",
        "http://stupiddope.com/wp-content/uploads/2014/07/cory-staudacher-instagram-03.jpg",
        "http://static.boredpanda.com/blog/wp-content/uploads/2015/09/nature-photography-men-of-instagram-16__605.jpg",
        "http://41.media.tumblr.com/eb2d4401b40f60d004c99d289a059590/tumblr_nqeudeGrEZ1u7vbhko2_1280.jpg",
        "http://s14.favim.com/610/160212/adventure-fun-girl-nature-Favim.com-3985099.jpg",
        "http://s8.favim.com/610/150421/alternative-art-background-beautiful-Favim.com-2669488.jpg",
        "http://s7.favim.com/610/151205/beach-boho-bright-instagram-Favim.com-3708977.jpg"];
    
    @IBOutlet var collectionView : UICollectionView!
    
    var following = false
    
    override func viewDidLoad() {
        print("Profile View Loaded")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        print("Uh-Oh")
    }
    
    //removing status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // amount of cell in collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    // creating cells
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        let imageView = cell.viewWithTag(1) as! UIImageView
        
        //let imageURL = images
        imageView.sd_setImage(with: URL(string: images[indexPath.row]), placeholderImage: UIImage(named: "kyle"))
        
        return cell
    }
    
    //setting collection view header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        print("Getting header")
        
        var reusableview : UICollectionReusableView
            
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerCell", for: indexPath)
            
        header.backgroundColor = UIColor.white
        
        let followButton = header.viewWithTag(1) as! UIButton
        followButton.addTarget(self, action: #selector(followButtonClicked(_:)), for: UIControlEvents.touchUpInside)
        followButton.titleLabel!.font = UIFont(name: "FontAwesome", size: 20)
        followButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        followButton.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        followButton.layer.cornerRadius = followButton.frame.width/2
        
        if(following){
            followButton.backgroundColor = UIColor(red:0.22, green:0.79, blue:0.45, alpha:1.00)
            followButton.setTitle("\u{f00c}", for: .normal)
        }else{
            followButton.backgroundColor = UIColor.black
            followButton.setTitle("\u{f067}", for: .normal)
        }
        
        let profilePicture = header.viewWithTag(2) as! UIImageView
        profilePicture.layer.cornerRadius = profilePicture.frame.size.width/2
        profilePicture.clipsToBounds = true
        profilePicture.image = UIImage(named: "bg")
            
        reusableview = header
        
        return reusableview
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        print("Dealocating header")
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "imageView") as! ImageViewController
        vc.setup(imageURL: images[indexPath.row], username: "Person's Name Is Too Long")
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    //set cell sizes
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/3, height: collectionView.frame.width/3)
    }
    
    //set cell left/right padding
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    //set cell bottom padding
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func followButtonClicked(_ sender: UIButton) {
        
        if(following){
            following = false
            sender.backgroundColor = UIColor.black
            sender.setTitle("\u{f067}", for: .normal)
        }else{
            following = true
            sender.backgroundColor = UIColor(red:0.22, green:0.79, blue:0.45, alpha:1.00)
            sender.setTitle("\u{f00c}", for: .normal)
        }
    }
    
    
}
