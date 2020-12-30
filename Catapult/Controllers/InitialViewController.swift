//
//  InitialViewController.swift
//  Catapult
//
//  Created by Alison Soong on 12/26/20.
//

import UIKit

class InitialViewController: UIViewController {

    @IBOutlet weak var StartButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        StartButton.layer.cornerRadius = StartButton.frame.size.height / 5
        
        self.tabBarController?.tabBar.isHidden = true
        
        navigationController?.navigationBar.isHidden = true
        
        // scroll reset
//        initialScrollView.setContentOffset(CGPoint.zero, animated: true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.tabBarController?.selectedIndex = 1
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        let curView  = storyBoard.instantiateViewController(withIdentifier: "Step1") as! Step1ViewController
//        self.present(curView, animated: true, completion: nil)
    }
    
    @IBAction func StartPressed(_ sender: UIButton) {
        
        self.tabBarController?.selectedIndex = 1
//        let selectedIndex = tabBarController?.selectedViewController
//        print(selectedIndex)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
