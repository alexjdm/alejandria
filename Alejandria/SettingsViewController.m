//
//  SettingsViewController.m
//  Alejandria
//
//  Created by Alex Diaz on 2/22/17.
//  Copyright © 2017 Alex Diaz. All rights reserved.
//

#import "SettingsViewController.h"
#import "DatabaseHelper.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.hidesBackButton = YES;
}

- (IBAction)botonPublicar:(id)sender {
    
    [_controladorPrincipal mostrarPublish];
    
}

- (IBAction)botonCerrarSesion:(id)sender {
   
    [DatabaseHelper deleteAllDataBase];
    
    //self.controladorPrincipal.ESTADO_ACTUAL = Consts.SIN_LOGIN;
    
    [self.controladorPrincipal mostrarLogin];
    
}

- (IBAction)botonAccount:(id)sender {
    
    [self.controladorPrincipal mostrarAccount];
    
}

@end
