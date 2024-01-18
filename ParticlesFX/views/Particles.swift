//
//  Particles.swift
//  ParticlesFX
//
//  Created by GoodDamn on 18/01/2024.
//

import Foundation
import UIKit


class Particles
    : UIView {
    
    private let TAG = "Particles:"
    
    private let mLayers = 5
    private let mObjs = 20
    
    // 100 particles = 5 * 20
    
    private var mParticles: [Particle] = []
    
    private var mElapsedTime: Float = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        for _ in 0..<mLayers {
            let a = CAShapeLayer()
            
            a.fillColor = UIColor
                .white
                .cgColor
            a.strokeColor = nil
            
            
            let p = generateParticle()
            a.path = p.path
                .cgPath
            
            mParticles.append(
                p
            )
            layer.addSublayer(a)
        }
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    

    public func start() {
        
        DispatchQueue
            .global(qos: .background)
            .async {
                
                var prevTime = Date()
                    .timeIntervalSince1970
                
                while true {
                    
                    let current = Date()
                        .timeIntervalSince1970
                    
                    self.mElapsedTime = Float(
                        current - prevTime
                    ) * 1000
                    
                    
                    prevTime = current
                    
                    let m = self.mParticles
                    
                    for i in m.indices {
                        self.dOpacity(
                            index: i
                        )
                    }
                    
                    
                }
                
            }
        
    }
    
    private func mainThread(
        _ p: @escaping () -> Void
    ) {
        DispatchQueue
            .main
            .async(
                execute: p
            )
    }
    
    private func dOpacity(
        index: Int
    ) {
        mainThread { [self] in
            
            let par = mParticles[index]
            
            let l = layer
                .sublayers![index]
                as! CAShapeLayer
            
            l.opacity -= mElapsedTime / Float(par.lifeTime)
            
            
            if l.opacity < 0.0 {
                mParticles[index] = generateParticle()
                l.opacity = 1.0
            }
        }
    }
    
    private func generateParticle() -> Particle {
        let b = UIBezierPath()
        
        for _ in 0..<mObjs {
            let p = ranp()
            b.move(
                to: p
            )
            b.addArc(
                withCenter: p,
                radius: 3.0,
                startAngle: 0,
                endAngle: 2 * .pi,
                clockwise: true
            )
        }
        
        return Particle(
            lifeTime: Int.random(
                in: 250...500
            ),
            path: b
        )
        
    }
    
    private func ranp() -> CGPoint {
        return CGPoint(
            x: Double.random(
                in: 25...350
            ),
            y: Double.random(
                in: 25...642
            )
        )
    }
    
}

struct Particle {
    var lifeTime: Int
    var path: UIBezierPath
}
