//
//  MasterViewController.h
//  OmarsWheterService
//
//  Created by Omar Jair Castro Arreola on 3/30/16.
//  Copyright (c) 2016 Omar Jair Castro Arreola. All rights reserved.
//

#import "BaseTableViewController.h"
#import <CoreData/CoreData.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) DetailViewController *detailViewController;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (weak, nonatomic) UITableViewController * siblingController;

@end

