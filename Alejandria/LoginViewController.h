//
//  LoginViewController.h
//  Alejandria
//
//  Created by Alex Diaz on 2/11/17.
//  Copyright © 2017 Alex Diaz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrincipalController.h"
#import "UserBusiness.h"

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *useremail;
@property (weak, nonatomic) IBOutlet UITextField *userPassword;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property bool ajustado;
@property bool arriba_actual;
@property bool arriba_anterior;

@property PrincipalController *controladorPrincipal;
@property UserBusiness *uBusiness;

@end
