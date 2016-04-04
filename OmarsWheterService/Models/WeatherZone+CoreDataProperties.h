//
//  WeatherZone+CoreDataProperties.h
//  OmarsWheterService
//
//  Created by Omar Jair Castro Arreola on 4/2/16.
//  Copyright © 2016 Omar Jair Castro Arreola. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "WeatherZone.h"

NS_ASSUME_NONNULL_BEGIN

@interface WeatherZone (CoreDataProperties)

@property (nonatomic) int64_t id;
@property (nonatomic, strong) NSDate *lastUpdate;
@property (nullable, nonatomic, retain) NSString *cod;
@property (nullable, nonatomic, retain) NSString *name;
@property (nonatomic) float lon;
@property (nonatomic) float lat;
@property (nonatomic) float windDeg;
@property (nonatomic) float windSpeed;
@property (nonatomic) float pressure;
@property (nonatomic) float temp;
@property (nonatomic) float humidity;
@property (nonatomic) float temp_max;
@property (nonatomic) float temp_min;
@property (nullable, nonatomic, retain) NSString *zip;
@property (nullable, nonatomic, retain) NSSet<Weather *> *weather;

@end

@interface WeatherZone (CoreDataGeneratedAccessors)

- (void)addWeatherObject:(Weather *)value;
- (void)removeWeatherObject:(Weather *)value;
- (void)addWeather:(NSSet<Weather *> *)values;
- (void)removeWeather:(NSSet<Weather *> *)values;

@end

NS_ASSUME_NONNULL_END
