//
//  WishListViewController.h
//  Alejandria
//
//  Created by Alex Diaz on 2/22/17.
//  Copyright © 2017 Alex Diaz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrincipalController.h"

@interface WishListViewController : UIViewController

@property PrincipalController * controladorPrincipal;

@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property NSMutableArray *sourceDataFavoritos;

@end
