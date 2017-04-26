//
//  BookViewController.h
//  Alejandria
//
//  Created by Alex Diaz on 3/1/17.
//  Copyright © 2017 Alex Diaz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Libro_DTO.h"
#import "User_Setup_DTO.h"

@interface BookViewController : UIViewController

@property Libro_DTO * libro;
@property User_Setup_DTO * usuario;
@property (weak, nonatomic) IBOutlet UIImageView *mImage;
@property (weak, nonatomic) IBOutlet UILabel *mTitulo;
@property (weak, nonatomic) IBOutlet UILabel *mDescripcion;
@property (weak, nonatomic) IBOutlet UIButton *mAgregarFavoritos;
@property (weak, nonatomic) IBOutlet UILabel *mCantidad;
@property (weak, nonatomic) IBOutlet UIButton *mSolicitar;
@property (weak, nonatomic) IBOutlet UILabel *mInfoVendedor;
@property (weak, nonatomic) IBOutlet UILabel *mNombreVendedor;
@property (weak, nonatomic) IBOutlet UILabel *mUbicacionVendedor;
@property (weak, nonatomic) IBOutlet UIButton *mUbicacionMaps;
@property (weak, nonatomic) IBOutlet UIScrollView *mScrollView;



@end
