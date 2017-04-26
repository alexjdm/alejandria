//
//  NotificationsViewController.h
//  Alejandria
//
//  Created by Alex Diaz on 2/27/17.
//  Copyright © 2017 Alex Diaz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrincipalController.h"

@interface NotificationsViewController : UIViewController

@property PrincipalController * controladorPrincipal;

@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property NSMutableArray *sourceDataSolicitudes;

@end
