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

- (void)viewWillAppear:(BOOL)animated {
    
    self.navigationItem.title = @"Configuraciones";
    
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

- (IBAction)botonIntercambios:(id)sender {
    
    [self.controladorPrincipal mostrarExchanges];
    
}

- (IBAction)botonPreguntas:(id)sender {
    
    [self.controladorPrincipal mostrarQuestions];
    
}

- (IBAction)botonSolicitudRandom:(id)sender {
    
    [self.controladorPrincipal fakeMatch];
    
}



@end
