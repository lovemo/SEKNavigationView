//
//  MainViewController.swift
//  NavigationViewDemo
//
//  Created by Mac on 16/8/24.
//  Copyright © 2016年 Mac. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Demo示例"
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = ViewController()
        vc.isShowNavgationViewButton = indexPath.row == 1
        navigationController?.pushViewController(vc, animated: true)
    }
}
