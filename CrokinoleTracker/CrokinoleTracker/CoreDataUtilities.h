//
//  CoreDataUtilities.h
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-04-19.
//  Copyright (c) 2012 KMSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreDataUtilities : NSObject

+ (NSArray *)fetchEntitiesForEntityName:(NSString *)entityName;
+ (NSManagedObject *)entityForEntityName:(NSString *)entityName
                           attributeName:(NSString *)attributeName
                          attributeValue:(NSString *)attributeValue;
+ (NSManagedObject *)createEntityForEntityName:(NSString *)entityName
                           attributeDictionary:(NSDictionary *)attributes;

@end
