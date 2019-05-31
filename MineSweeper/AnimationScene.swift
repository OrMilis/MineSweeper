//
//  AnimationScene.swift
//  MineSweeper
//
//  Created by ormilis on 30/05/2019.
//  Copyright © 2019 Or Milis. All rights reserved.
//

import UIKit
import SpriteKit

class AnimationScene: SKScene {
    var explosionFrames: [SKTexture]?;
    var fireworksFrames: [SKTexture]?;
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    override init(size: CGSize) {
        super.init(size: size);
        self.backgroundColor = UIColor.clear;
        var explosionFrames: [SKTexture] = [];
        var fireworksFrames: [SKTexture] = [];
        
        let explosionAtlas = SKTextureAtlas(named: "explosion");
        let fireworksAtlas = SKTextureAtlas(named: "fireworks");
        
        for index in 0...23 {
            let explosionTextureName = "explosion_\(index)";
            let explosionTexture = explosionAtlas.textureNamed(explosionTextureName);
            explosionFrames.append(explosionTexture);
            
            let fireworksTextureName = "fireworks_\(index)";
            let fireworksTexture = fireworksAtlas.textureNamed(fireworksTextureName);
            fireworksFrames.append(fireworksTexture);
        }
        
        self.explosionFrames = explosionFrames;
        self.fireworksFrames = fireworksFrames;
    }
    
    func play(gameStatus: String) {
        
        let frames = gameStatus == "LOST" ? self.explosionFrames : self.fireworksFrames;
        let texture = self.explosionFrames![0];
        let animation = SKSpriteNode(texture: texture);
        
        animation.size = CGSize(width: self.frame.size.width, height: self.frame.size.width);
        animation.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2);
        
        self.addChild(animation);
        animation.run(SKAction.repeat(SKAction.animate(with: frames!, timePerFrame: 23/1000, resize: false, restore: true), count: 3));
        //animation.run(SKAction.repeatForever(SKAction.animate(with: frames!, timePerFrame: 23/1000, resize: false, restore: true)));
    }
}
