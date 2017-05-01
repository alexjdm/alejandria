//
//  PrincipalController.h
//  Alejandria
//
//  Created by Alex Diaz on 2/11/17.
//  Copyright © 2017 Alex Diaz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@class NavigationViewController;
@class ControladorNotificaciones;
@class LoginViewController;
@class SearchViewController;
@class SearchBookViewController;
@class WishListViewController;
@class PublishViewController;
@class NotificationsViewController;
@class SettingsViewController;
@class AccountViewController;


@interface PrincipalController : UIViewController

typedef enum{
    SIN_LOGIN,
    CON_LOGIN,
    PANTALLA_MAPA
} APPLICATION_STATE;
@property APPLICATION_STATE  ESTADO_ACTUAL;

typedef enum{
    MAPA,
    USER_ACCOUNT,
    PUBLICAR_INFO,
    GALLERY
}SCREEN;

@property UIWindow *ventanaPrincipal;
@property UINavigationController *navigationController;
@property NavigationViewController * navToolBarController;
@property ControladorNotificaciones * ControladorNotificaciones;
@property LoginViewController * LoginViewController;
@property SearchViewController * SearchViewController;
@property SearchBookViewController * SearchBookViewController;
@property WishListViewController * WishListViewController;
@property PublishViewController * PublishViewController;
@property NotificationsViewController * NotificationsViewController;
@property SettingsViewController * SettingsViewController;
@property AccountViewController * AccountViewController;

@property NSNumber * idUsuario;
@property SCREEN PANTALLA_ACTUAL;
@property SCREEN PANTALLA_ANTERIOR;

-(void) IniciarApp; //Funcion Principal de la APP.
-(void) refrescarPantalla;

- (void) mostrarLogin;
- (void) mostrarPublish;
- (void) mostrarAccount;

@end
