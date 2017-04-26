//
//  PublishViewController.h
//  Alejandria
//
//  Created by Alex Diaz on 2/22/17.
//  Copyright © 2017 Alex Diaz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrincipalController.h"

@interface PublishViewController : UIViewController

@property PrincipalController * controladorPrincipal;
@property (weak, nonatomic) IBOutlet UIScrollView *mScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *mImage;
@property (weak, nonatomic) IBOutlet UITextField *mNombre;
@property (weak, nonatomic) IBOutlet UITextField *mISBN;
@property (weak, nonatomic) IBOutlet UILabel *mNombreCuenta;
@property (weak, nonatomic) IBOutlet UITextField *mDescripcion;
@property (weak, nonatomic) IBOutlet UIView *mUploadOk;
@property (weak, nonatomic) IBOutlet UITextField *mCantidad;

@property bool ajustado;
@property bool arriba_actual;
@property bool arriba_anterior;

@end
