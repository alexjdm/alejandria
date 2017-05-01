//
//  PrincipalController.m
//  Alejandria
//
//  Created by Alex Diaz on 2/11/17.
//  Copyright © 2017 Alex Diaz. All rights reserved.
//

#import "PrincipalController.h"
#import "Consts.h"
#import "ControladorNotificaciones.h"
#import "LoginViewController.h"
#import "SearchViewController.h"
#import "WishListViewController.h"
#import "PublishViewController.h"
#import "NotificationsViewController.h"
#import "SettingsViewController.h"
#import "AccountViewController.h"

@implementation PrincipalController

//Este método es el mas importante. Hace todas las comprobaciones necesarias y llama
//a los responsables de cada funcionalidad.
-(void) IniciarApp{
    
    //Al iniciar, creamos los controladores.
    //Probablemente luego sea necesario crearlos on-demand.
    [self InstanciarControladores];
    [self recuperarEstado];
    [self refrescarPantalla];
    
}

-(void) InstanciarControladores {
    
    _ESTADO_ACTUAL = Consts.SIN_LOGIN;
    
    _ControladorNotificaciones = [[ControladorNotificaciones alloc]init];
    _ControladorNotificaciones.controladorPrincipal = self;
    
    _LoginViewController = [[LoginViewController alloc]init];
    _LoginViewController.controladorPrincipal = self;
    
    _SearchViewController = [[SearchViewController alloc]init];
    _SearchViewController.controladorPrincipal = self;
    
    _WishListViewController = [[WishListViewController alloc]init];
    _WishListViewController.controladorPrincipal = self;
    
    _PublishViewController = [[PublishViewController alloc]init];
    _PublishViewController.controladorPrincipal = self;
    
    _NotificationsViewController = [[NotificationsViewController alloc]init];
    _NotificationsViewController.controladorPrincipal = self;
    
    _SettingsViewController = [[SettingsViewController alloc] init];
    _SettingsViewController.controladorPrincipal = self;
    
    _AccountViewController = [[AccountViewController alloc] init];
    _AccountViewController.controladorPrincipal = self;
    
}

-(void) recuperarEstado{
    //Obtener estado desde base de datos.
    User_Setup_DTO * current = [User_Setup_DAO getUserSetup];
    if (current==nil) //Sino tiene usuario registrado. No existe.
        self.ESTADO_ACTUAL = Consts.SIN_LOGIN;
    else
        self.ESTADO_ACTUAL = Consts.CON_LOGIN;
}

-(void) refrescarPantalla{
    
    if (self.ESTADO_ACTUAL==Consts.SIN_LOGIN){
        [self mostrarLogin];
    }
    else {
        [self iniciaNavigationDrawer: _SearchViewController];
        [self createToolbar: _SearchViewController];
        
        return;
    }
    
}

- (void) mostrarLogin {
    
    LoginViewController *lgc = [[LoginViewController alloc]init];
    lgc.controladorPrincipal = self;
    self.ventanaPrincipal.rootViewController = lgc;
    
    [self.ventanaPrincipal makeKeyAndVisible];
}

- (void) iniciaNavigationDrawer: (UIViewController*) controller {
    
    
    UINavigationController *mNavigationController = [[UINavigationController alloc]initWithRootViewController:controller];
    
    mNavigationController.navigationBar.translucent = NO;
    mNavigationController.navigationBar.topItem.title = @"Alejandria";
    mNavigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    mNavigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.83
                                                                       green:0.18
                                                                        blue:0.30
                                                                       alpha:1.0];
    
    _navigationController = mNavigationController;
    
    [UIView transitionWithView:_navigationController.view.window
                      duration:0.5
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        self.ventanaPrincipal.rootViewController = _navigationController;
                    } completion:^(BOOL finished) {
                        // Code to run after animation
                    }];
    //self.ventanaPrincipal.rootViewController = _navigationController;
    //[self.ventanaPrincipal makeKeyAndVisible];
    
}

-(void) createToolbar: (UIViewController*) controller
{
    UIImage *search_gray = [[UIImage imageNamed:@"search_gray"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *search_black = [[UIImage imageNamed:@"search_black"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *wish_gray = [[UIImage imageNamed:@"wish_gray"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *wish_black = [[UIImage imageNamed:@"wish_black"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *publish_gray = [[UIImage imageNamed:@"publish_gray"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *publish_black = [[UIImage imageNamed:@"publish_black"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *notifi_gray = [[UIImage imageNamed:@"notifi_gray"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *notifi_black = [[UIImage imageNamed:@"notifi_black"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *settings_gray = [[UIImage imageNamed:@"settings_gray"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *settings_black = [[UIImage imageNamed:@"settings_black"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSLog(@"%@", self.navigationController.topViewController);
    
    UIBarButtonItem *button1 = [[UIBarButtonItem alloc] initWithImage:search_gray style:UIBarButtonItemStylePlain target:self action:@selector(button1Tap:)];
    button1.tag = 1;
    if([self.navigationController.topViewController isKindOfClass:[_SearchViewController class]])
        button1 = [[UIBarButtonItem alloc] initWithImage:search_black style:UIBarButtonItemStylePlain target:self action:@selector(button1Tap:)];
    
    UIBarButtonItem *button2 = [[UIBarButtonItem alloc] initWithImage:wish_gray style:UIBarButtonItemStylePlain target:self action:@selector(button2Tap:)];
    button2.tag = 2;
    if([self.navigationController.topViewController isKindOfClass:[_WishListViewController class]])
        button2 = [[UIBarButtonItem alloc] initWithImage:wish_black style:UIBarButtonItemStylePlain target:self action:@selector(button2Tap:)];
    
    UIBarButtonItem *button3 = [[UIBarButtonItem alloc] initWithImage:publish_gray style:UIBarButtonItemStylePlain target:self action:@selector(button3Tap:)];
    button3.tag = 3;
    if([self.navigationController.topViewController isKindOfClass:[_PublishViewController class]])
        button3 = [[UIBarButtonItem alloc] initWithImage:publish_black style:UIBarButtonItemStylePlain target:self action:@selector(button3Tap:)];
    
    UIBarButtonItem *button4 = [[UIBarButtonItem alloc] initWithImage:notifi_gray style:UIBarButtonItemStylePlain target:self action:@selector(button4Tap:)];
    button4.tag = 4;
    if([self.navigationController.topViewController isKindOfClass:[_NotificationsViewController class]])
        button4 = [[UIBarButtonItem alloc] initWithImage:notifi_black style:UIBarButtonItemStylePlain target:self action:@selector(button4Tap:)];
    
    UIBarButtonItem *button5 = [[UIBarButtonItem alloc] initWithImage:settings_gray style:UIBarButtonItemStylePlain target:self action:@selector(button5Tap:)];
    button5.tag = 5;
    if([self.navigationController.topViewController isKindOfClass:[_SettingsViewController class]])
        button5 = [[UIBarButtonItem alloc] initWithImage:settings_black style:UIBarButtonItemStylePlain target:self action:@selector(button5Tap:)];
    
    UIBarButtonItem *flexibleItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    [self.navigationController setToolbarHidden:NO];
    self.navigationController.toolbar.translucent = NO;
    
    controller.toolbarItems = [NSArray arrayWithObjects:button1, flexibleItem, button2, flexibleItem, button3, flexibleItem, button4, flexibleItem, button5, nil];    
}

-(void) button1Tap:(UIButton*)sender
{
    NSLog(@"you clicked on button %ld", (long)sender.tag);
    [self mostrarSearch];
    [self createToolbar: _SearchViewController];
}

-(void) button2Tap:(UIButton*)sender
{
    NSLog(@"you clicked on button %ld", (long)sender.tag);
    [self mostrarWishList];
    [self createToolbar: _WishListViewController];
}

-(void) button3Tap:(UIButton*)sender
{
    NSLog(@"you clicked on button %ld", (long)sender.tag);
    [self mostrarPublish];
    
}

-(void) button4Tap:(UIButton*)sender
{
    NSLog(@"you clicked on user button %ld", (long)sender.tag);
    
    [self mostrarNotifications];
    [self createToolbar: _NotificationsViewController];
    
}

-(void) button5Tap:(UIButton*)sender
{
    NSLog(@"you clicked on user button %ld", (long)sender.tag);
    
    [self mostrarSettings];
    [self createToolbar: _SettingsViewController];
    
}

//- (void) mostrarLogin {
//    
//    [self refrescarViewControllers];
//    
//    if(![self.navigationController.topViewController isKindOfClass:[_LoginViewController class]]) {
//        [self.navigationController pushViewController:_LoginViewController animated:true];
//    }
//    
//    [self createToolbar: _LoginViewController];
//    
//}

- (void) mostrarSearch {
    
    [self refrescarViewControllers];
    
    if(![self.navigationController.topViewController isKindOfClass:[_SearchViewController class]]) {
        [self.navigationController pushViewController:_SearchViewController animated:true];
    }
    
}

- (void) mostrarWishList {
    
    [self refrescarViewControllers];
    
    if(![self.navigationController.topViewController isKindOfClass:[_WishListViewController class]]) {
        [self.navigationController pushViewController:_WishListViewController animated:true];
    }
    
}

- (void) mostrarPublish {
    
    [self refrescarViewControllers];
    
    if(![self.navigationController.topViewController isKindOfClass:[_PublishViewController class]]) {
        [self.navigationController pushViewController:_PublishViewController animated:true];
    }
    
    [self createToolbar: _PublishViewController];
    
}

- (void) mostrarNotifications {
    
    [self refrescarViewControllers];
    
    if(![self.navigationController.topViewController isKindOfClass:[_NotificationsViewController class]]) {
        [self.navigationController pushViewController:_NotificationsViewController animated:true];
    }
    
}

- (void) mostrarSettings {
    
    [self refrescarViewControllers];
    
    if(![self.navigationController.topViewController isKindOfClass:[_SettingsViewController class]]) {
        [self.navigationController pushViewController:_SettingsViewController animated:true];
    }
    
}

- (void) mostrarAccount {
    
    [self refrescarViewControllers];
    
    if(![self.navigationController.topViewController isKindOfClass:[_AccountViewController class]]) {
        [self.navigationController pushViewController:_AccountViewController animated:true];
    }
    
}

-(void) refrescarViewControllers {
    
    NSMutableArray *allViewControllers = [NSMutableArray arrayWithArray: self.navigationController.viewControllers];
    
    NSLog(@"%@", allViewControllers);
    
    if(allViewControllers.count > 1)
        [allViewControllers removeObjectAtIndex:0];
    
    self.navigationController.viewControllers = allViewControllers;
}


@end
