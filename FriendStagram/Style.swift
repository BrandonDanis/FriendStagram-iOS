//
//  Style.swift
//  FriendStagram
//
//  Created by Brandon Danis on 2017-04-16.
//  Copyright © 2017 RBSoftware. All rights reserved.
//

import Foundation
import UIKit

struct Style {
    
    //Defining styles to be used in the app
    
    static var navigation_title_color = UIColor.black
    
    //tab bar
    static var tab_tint_color = UIColor(red:0.20, green:0.60, blue:0.86, alpha:1.00)
    static var tab_bar_tint_color : UIColor? = nil
    
    //Image Feed view
    static var feed_background_color = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.00) //background color of feed listview
    static var feed_cell_background_color = UIColor(red:0.90, green:0.90, blue:0.90, alpha:1.00) //background color of cell
    static var feed_cell_content_background_color = UIColor.white //background color of cell content
    static var feed_cell_like_button_color = UIColor(red:0.75, green:0.23, blue:0.19, alpha:1.00)
    
    //Profile view colors
    static var profile_header_background_color = UIColor.white
    static var profile_not_following_background_color = UIColor.black
    static var profile_following_background_color = UIColor(red:0.22, green:0.79, blue:0.45, alpha:1.00)
    static var profile_follow_button_title_color = UIColor.white
    static var profile_username_label_color = UIColor.black
    
}
