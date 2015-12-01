//
//  PlayerItemMO.m
//  QueuePlayerSamle
//
//  Created by Denis on 01/12/2015.
//  Copyright © 2015 Denis Melenevsky. Some rights reserved.
//

#import "PlayerItemMO.h"

#import "QueuePlayerSamle-Swift.h"

NSString *const kPlayerItemEntityName = @"PlayerItem";
NSString *const kTitleKey = @"title";
NSString *const kArtistKey = @"artist";

@implementation PlayerItemMO

- (void)setMediaItem:(MPMediaItem *)mediaItem
{
	self.title = mediaItem.title;
	self.artist = mediaItem.artist;
	self.itemUrl = mediaItem.assetURL;
}

@end
