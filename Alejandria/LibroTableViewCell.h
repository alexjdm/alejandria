//
//  LibroTableViewCell.h
//  Alejandria
//
//  Created by Alex Diaz on 3/1/17.
//  Copyright © 2017 Alex Diaz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchViewController.h"

@interface LibroTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *mImage;
@property (weak, nonatomic) IBOutlet UILabel *mTitulo;
@property (weak, nonatomic) IBOutlet UILabel *mDescripcion;
@property (weak, nonatomic) IBOutlet UILabel *mISBN;
@property (weak, nonatomic) IBOutlet UIButton *mGoButton;
@property SearchViewController *sv;

@end
