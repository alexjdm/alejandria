//
//  User_Setup_DTO.h
//  Alejandria
//
//  Created by Alex Diaz on 2/22/17.
//  Copyright © 2017 Alex Diaz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface User_Setup_DTO : NSObject

@property NSNumber * idUsuario;
@property NSString * correo_electronico;
@property NSString * nombres;
@property NSString * apellidos;
@property NSString * password;
@property UIColor * navigation_drawer_color;
@property UIColor * topbar_color;
@property NSDate * ultimo_login;
@property NSString * telefono;
@property NSString * genero;
@property NSString * direccion;

@property NSString * msg_feedback_login;

@end
