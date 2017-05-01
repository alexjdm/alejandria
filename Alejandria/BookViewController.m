//
//  BookViewController.m
//  Alejandria
//
//  Created by Alex Diaz on 3/1/17.
//  Copyright © 2017 Alex Diaz. All rights reserved.
//

#import "BookViewController.h"
#import "Favorito_DAO.h"
#import "User_Setup_DAO.h"
#import "Libro_DAO.h"
#import "Request_DAO.h"

@interface BookViewController () <UIScrollViewDelegate>

@end

@implementation BookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupScroll];
    
    self.navigationController.navigationBar.topItem.title = @"";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
}

- (void) viewWillAppear:(BOOL)animated {
    
    [self.navigationController setToolbarHidden:YES];
    
    if([_libro.titulo  isEqual: @"El Señor de los Anillos"])
    {
        UIImage *img = [[UIImage imageNamed:@"elsenor1.jpg"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        _mImage.image = img;
    }
    else if ([_libro.titulo  isEqual: @"Harry Potter"])
    {
        UIImage *img = [[UIImage imageNamed:@"harrypotter1.jpg"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        _mImage.image = img;
    }
    else if ([_libro.titulo  isEqual: @"One Hundred Years of Solitude"])
    {
        UIImage *img = [[UIImage imageNamed:@"cien1.jpg"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        _mImage.image = img;
    }
    else if(_libro.url_local != nil && ![_libro.url_local  isEqual: @""])
    {
        NSString *path = _libro.url_local;
        NSArray *namesArray = [path componentsSeparatedByString:@"/"];
        NSString *imageName = [namesArray lastObject];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory ,NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *getImagePath = [documentsDirectory stringByAppendingPathComponent:imageName];
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:getImagePath];
        _mImage.image = image;
    }
    
    _usuario = [User_Setup_DAO getUser:_libro.idUsuario];
    
    _mTitulo.text = _libro.titulo;
    _mDescripcion.text = _libro.descripcion;
    _mCantidad.text = [NSString stringWithFormat:@"Cantidad: %@", _libro.cantidad];
    _mNombreVendedor.text = [NSString stringWithFormat:@"%@ %@", _usuario.nombres, _usuario.apellidos];
    _mUbicacionVendedor.text = _usuario.direccion;
    
    //Verificar si es un libro agregado a favorito
    [self verificarFavorito];
    
    //Verificar si es un libro ha sido solicitado
    [self verificarSolicitado];
    
    //Verificar si el libro es mio
    [self verificarLibroMio];
}

- (void) viewWillDisappear:(BOOL)animated {
    
    [self.navigationController setToolbarHidden:NO];
    
}

- (void) verificarLibroMio {
    
    if(_libro.idUsuario == [User_Setup_DAO getUserSetup].idUsuario)
    {
        _mAgregarFavoritos.hidden = YES;
        _mSolicitar.hidden = YES;
    }
    else
    {
        _mAgregarFavoritos.hidden = NO;
        _mSolicitar.hidden = NO;
    }
    
}

- (void) verificarSolicitado {
    
    if([Request_DAO estaSolicitado: _libro.idLibro])
    {
        [_mSolicitar setTitle:@"Solicitado!" forState:UIControlStateNormal];
        
        _mSolicitar.alpha = 0.55;
        
        _mEstado.text = @"Este libro ha sido solicitado.";
        _mEstado.hidden = NO;
    }
    else
    {
        [_mSolicitar setTitle:@"Solicitar" forState:UIControlStateNormal];
        
        _mSolicitar.alpha = 1.0;
        
        _mEstado.text = @"Este libro se encuentra disponible.";
        _mEstado.hidden = NO;
    }
    
}


- (void) verificarFavorito {
    
    UIImage *wish_gray = [[UIImage imageNamed:@"wish_gray"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *wish_black = [[UIImage imageNamed:@"wish_black"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    if([Favorito_DAO esFavorito:_libro.idLibro])
        [_mAgregarFavoritos setImage:wish_black forState:UIControlStateNormal];
    else
        [_mAgregarFavoritos setImage:wish_gray forState:UIControlStateNormal];
}

- (IBAction)agregarFavorito:(id)sender {
    
    //Cambiar icono
    UIImage *wish_gray = [[UIImage imageNamed:@"wish_gray"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *wish_black = [[UIImage imageNamed:@"wish_black"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    if(![Favorito_DAO esFavorito:_libro.idLibro])
    {
        [sender setImage:wish_black forState:UIControlStateNormal];
        
        //Guardar favorito en base de datos
        Favorito_DTO *fav = [[Favorito_DTO alloc] init];
        fav.idLibro = _libro.idLibro;
        fav.fecha = [NSDate date];
        [Favorito_DAO save:fav];
    }
    else {
        [sender setImage:wish_gray forState:UIControlStateNormal];
        
        // Quitar favorito
        [Favorito_DAO remove:_libro.idLibro];
    }

    
}

- (IBAction)generarSolicitud:(id)sender {
    
    //Verificar si esta solicitado
    if([Request_DAO estaSolicitado: _libro.idLibro])
    {
        [sender setTitle:@"Solicitar" forState:UIControlStateNormal];
        
        _mSolicitar.alpha = 1.0;
        
        // Quitar favorito
        [Request_DAO remove:_libro.idLibro];
    }
    else{
        
        Request_DTO *solicitud = [[Request_DTO alloc] init];
        solicitud.idLibro = _libro.idLibro;
        solicitud.idUsuarioSolicitante = _usuario.idUsuario;
        solicitud.fecha = [NSDate date];
        solicitud.idLibroCambio = nil;
        solicitud.idUsuarioCambio = nil;
        solicitud.estado = @"pending";
        
        [Request_DAO save:solicitud];
        
        [sender setTitle:@"Solicitado!" forState:UIControlStateNormal];
        
        _mSolicitar.alpha = 0.55;
        
    }
    
}

-(void) setupScroll{
    //scroll
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    [_mScrollView setContentSize: CGSizeMake(screenWidth, screenHeight+100)];
    _mScrollView.delegate = self;
    [_mScrollView setScrollEnabled:YES];
    _mScrollView.directionalLockEnabled = YES;
    
    // TODO: Falta hacer que solo sea haga scroll si es necesario.
    
}


@end
