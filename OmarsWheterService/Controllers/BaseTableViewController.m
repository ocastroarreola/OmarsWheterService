//
//  BaseTableViewController.m
//  OmarsWheterService
//
//  Created by Omar Jair Castro Arreola on 3/31/16.
//  Copyright © 2016 Omar Jair Castro Arreola. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

-(void)showAckAlertContent:(NSString*)content{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:kAckAlertTitle
                                                                              message:content
                                                                       preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:kAckAlertButtonTitle
                                                       style:UIAlertActionStyleDefault
                                                     handler:nil]];
    if (!self.presentedViewController) {
        [self presentViewController:alertController
                           animated:YES
                         completion:nil];
    }
}


@end
