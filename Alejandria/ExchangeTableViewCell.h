//
//  ExchangeTableViewCell.h
//  Alejandria
//
//  Created by Alex Diaz on 5/6/17.
//  Copyright © 2017 Alex Diaz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExchangeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *mFecha;
@property (weak, nonatomic) IBOutlet UILabel *mUsuario;
@property (weak, nonatomic) IBOutlet UIImageView *mImagen;
@property (weak, nonatomic) IBOutlet UILabel *mTitulo;

@end
