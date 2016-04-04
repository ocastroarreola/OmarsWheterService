//
//  BaseTableViewController.h
//  OmarsWheterService
//
//  Created by Omar Jair Castro Arreola on 3/31/16.
//  Copyright © 2016 Omar Jair Castro Arreola. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@interface BaseTableViewController : UITableViewController

@property (nonatomic, strong) UITableViewController * parentController;
@property (nonatomic, weak) UITableViewController * siblingController;

-(void)showAckAlertContent:(NSString*)content;

@end
