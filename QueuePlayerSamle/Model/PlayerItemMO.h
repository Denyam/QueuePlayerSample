//
//  PlayerItemMO.h
//  QueuePlayerSamle
//
//  Created by Denis on 01/12/2015.
//  Copyright © 2015 Denis Melenevsky. Some rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@import MediaPlayer;

NS_ASSUME_NONNULL_BEGIN

extern NSString *const kPlayerItemEntityName;
extern NSString *const kTitleKey;
extern NSString *const kArtistKey;

@interface PlayerItemMO : NSManagedObject

- (void)setMediaItem:(MPMediaItem *)mediaItem;

@end

NS_ASSUME_NONNULL_END

#import "PlayerItemMO+CoreDataProperties.h"
