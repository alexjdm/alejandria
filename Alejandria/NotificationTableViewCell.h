//
//  NotificationTableViewCell.h
//  Alejandria
//
//  Created by Alex Diaz on 5/18/17.
//  Copyright © 2017 Alex Diaz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *mImage;
@property (weak, nonatomic) IBOutlet UILabel *mTitulo;
@property (weak, nonatomic) IBOutlet UILabel *mFecha;

@end
