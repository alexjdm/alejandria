//
//  AppDelegate.h
//  Alejandria
//
//  Created by Alex Diaz on 2/11/17.
//  Copyright © 2017 Alex Diaz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "PrincipalController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) LoginViewController *viewController;
@property (nonatomic,strong) NSString *databaseName;
@property (nonatomic,strong) NSString *databasePath;
@property PrincipalController *principalController;


-(void) createAndCheckDatabase;

@end

