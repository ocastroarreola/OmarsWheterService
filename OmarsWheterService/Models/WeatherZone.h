//
//  WeatherZone.h
//  OmarsWheterService
//
//  Created by Omar Jair Castro Arreola on 4/2/16.
//  Copyright © 2016 Omar Jair Castro Arreola. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <EasyMapping.h>

@class Weather;

NS_ASSUME_NONNULL_BEGIN

@interface WeatherZone : EKManagedObjectModel

// Insert code here to declare functionality of your managed object subclass

@end

NS_ASSUME_NONNULL_END

#import "WeatherZone+CoreDataProperties.h"
