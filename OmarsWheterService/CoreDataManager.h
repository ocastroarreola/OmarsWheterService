//
//  CoreDataManager.h
//  OmarsWheterService
//
//  Created by Omar Jair Castro Arreola on 4/2/16.
//  Copyright © 2016 Omar Jair Castro Arreola. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@class WeatherZone;

@interface CoreDataManager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

+ (WeatherZone*)weatherZoneForZip:(NSString*)zip;
+ (WeatherZone*)insertWeatherZoneInContext;
- (void)addWeatherObjects:(NSArray*)objects;
+ (CoreDataManager*)manager;
- (void)saveContext;
- (void)prefillData;

@end
