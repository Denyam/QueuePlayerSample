//
//  PlayerItemMO+CoreDataProperties.h
//  QueuePlayerSamle
//
//  Created by Denis on 01/12/2015.
//  Copyright © 2015 Denis Melenevsky. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "PlayerItemMO.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlayerItemMO (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *artist;
@property (nullable, nonatomic, retain) NSURL *itemUrl;

@end

NS_ASSUME_NONNULL_END
