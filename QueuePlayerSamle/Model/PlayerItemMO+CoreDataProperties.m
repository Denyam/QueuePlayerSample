//
//  PlayerItemMO+CoreDataProperties.m
//  QueuePlayerSamle
//
//  Created by Denis on 01/12/2015.
//  Copyright © 2015 Denis Melenevsky. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "PlayerItemMO+CoreDataProperties.h"

static NSString *const kItemPathKey = @"itemPath";

@implementation PlayerItemMO (CoreDataProperties)

@dynamic title;
@dynamic artist;

- (NSURL *)itemUrl
{
	NSURL *result = nil;
	NSString *urlString = [self valueForKey:kItemPathKey];
	if (urlString) {
		result = [NSURL URLWithString:urlString];
	}
	return result;
}

- (void)setItemUrl:(NSURL *)itemUrl
{
	[self setValue:itemUrl.absoluteString forKey:kItemPathKey];
}

@end
