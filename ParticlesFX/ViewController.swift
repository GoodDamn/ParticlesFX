//
//  ViewController.swift
//  ParticlesFX
//
//  Created by GoodDamn on 18/01/2024.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ViewController: viewDidLoad()")
        
        view.backgroundColor = .black
        
        let particles = Particles(
            frame: view.frame
        )
        
        view.addSubview(particles)
        
        particles.start()
    }


}

