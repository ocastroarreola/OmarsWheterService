//
//  CoreDataManager.m
//  OmarsWheterService
//
//  Created by Omar Jair Castro Arreola on 4/2/16.
//  Copyright © 2016 Omar Jair Castro Arreola. All rights reserved.
//

#import "CoreDataManager.h"
#import "WeatherZone+CoreDataProperties.h"
#import "Constants.h"

@interface CoreDataManager()

@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end

@implementation CoreDataManager

+(CoreDataManager*)manager {
    static CoreDataManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

#pragma mark - Core Data Saving support

+ (WeatherZone*)weatherZoneForZip:(NSString*)zip {
    WeatherZone * wz;
    NSFetchRequest * request = [NSFetchRequest fetchRequestWithEntityName:@"WeatherZone"];
    request.predicate = [NSPredicate predicateWithFormat:@"zip = %@",zip];
    NSError * e;
    NSArray * results = [[CoreDataManager manager].managedObjectContext executeFetchRequest:request
                                                                                      error:&e];
    if (results.count) {
        wz = results.firstObject;
    }
    return wz;
}

- (void)addWeatherObjects:(NSArray*)objects {
    [objects enumerateObjectsUsingBlock:^(NSString*  _Nonnull zip, NSUInteger idx, BOOL * _Nonnull stop) {
        WeatherZone *wz = [CoreDataManager insertWeatherZoneInContext];
        wz.zip = zip;
    }];
    [[CoreDataManager manager] saveContext];
}

+(WeatherZone*)insertWeatherZoneInContext {
    return [NSEntityDescription insertNewObjectForEntityForName:@"WeatherZone"
                                         inManagedObjectContext:[CoreDataManager manager].managedObjectContext];
}

- (void)prefillData {
    NSArray*prefill = @[@{kZipKey:@"94114", kNameKey:@"San Francisco County"},
                        @{kZipKey:@"11206", kNameKey:@"Long Island City"},
                        @{kZipKey:@"32824", kNameKey:@"Meadows Woods"},];
    [prefill enumerateObjectsUsingBlock:^(NSDictionary*  _Nonnull dic, NSUInteger idx, BOOL * _Nonnull stop) {
        WeatherZone * wz = [CoreDataManager insertWeatherZoneInContext];
        wz.zip = [dic valueForKey:kZipKey];
        wz.name = [dic valueForKey:kNameKey];
    }];
    [self saveContext];
}

- (void)saveContext {
    NSError *error = nil;
    if ([self.managedObjectContext hasChanges] && ![self.managedObjectContext save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.omar.jair.OmarsWheterService" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                   inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (!_managedObjectModel) {
        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"OmarsWheterService"
                                                  withExtension:@"momd"];
        _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    }
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (!_persistentStoreCoordinator) {
        // Create the coordinator and store
        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
        NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"OmarsWheterService.sqlite"];
        NSError *error = nil;
        NSString *failureReason = @"There was an error creating or loading the application's saved data.";
        if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
            // Report any error we got.
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
            dict[NSLocalizedFailureReasonErrorKey] = failureReason;
            dict[NSUnderlyingErrorKey] = error;
            error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999
                                    userInfo:dict];
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (!_managedObjectContext) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:self.persistentStoreCoordinator];
    }
    return _managedObjectContext;
}

@end
