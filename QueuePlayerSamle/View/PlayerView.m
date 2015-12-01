//
//  PlayerView.m
//  QueuePlayerSamle
//
//  Created by Denis on 01/12/2015.
//  Copyright © 2015 Denis Melenevsky. Some rights reserved.
//

#import "PlayerView.h"
@import AVFoundation;

@interface PlayerView ()
@property(nonatomic,readonly,strong) AVPlayerLayer *layer;
@end

@implementation PlayerView

@dynamic layer;

+ (Class)layerClass
{
	return [AVPlayerLayer class];
}

- (void)setPlayer:(AVPlayer *)player
{
	self.layer.player = player;
	self.layer.videoGravity = AVLayerVideoGravityResize;
}

@end
