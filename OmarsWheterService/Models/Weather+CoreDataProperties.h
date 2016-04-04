//
//  Weather+CoreDataProperties.h
//  OmarsWheterService
//
//  Created by Omar Jair Castro Arreola on 4/2/16.
//  Copyright © 2016 Omar Jair Castro Arreola. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Weather.h"

NS_ASSUME_NONNULL_BEGIN

@interface Weather (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *main;
@property (nonatomic) int64_t id;
@property (nullable, nonatomic, retain) NSString *desc;
@property (nullable, nonatomic, retain) NSString *icon;
@property (nullable, nonatomic, retain) WeatherZone *weatherZone;

@end

NS_ASSUME_NONNULL_END
