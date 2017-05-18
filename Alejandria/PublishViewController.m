//
//  PublishViewController.m
//  Alejandria
//
//  Created by Alex Diaz on 2/22/17.
//  Copyright © 2017 Alex Diaz. All rights reserved.
//

#import "PublishViewController.h"
#import "Libro_DAO.h"
#import "Libro_DTO.h"
#import "Helpers.h"
#import "User_Setup_DAO.h"


@interface PublishViewController () <UIScrollViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@end

@implementation PublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //NSLog(@"inico1 %f", self.view.frame.origin.y);
    [self setupScroll];
    //NSLog(@"inico2 %f", self.view.frame.origin.y);
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.title = @"Publicar";
    
    // Boton "Ok"
    UIButton *buttonPublish = [[UIButton alloc] initWithFrame:CGRectMake(55, 0, 63, 40)];
    
    [buttonPublish.titleLabel setFont: [UIFont fontWithName:@"System" size:5]];
    [buttonPublish.titleLabel setTextAlignment:NSTextAlignmentRight];
    [buttonPublish addTarget:self action:@selector(publicar) forControlEvents:UIControlEventTouchUpInside]; //adding action
    [buttonPublish setImage:[UIImage imageNamed:@"upload_white"] forState:UIControlStateNormal];
    [buttonPublish setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttonPublish setTintColor:[UIColor whiteColor]];
    [buttonPublish setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem *checkItem =[[UIBarButtonItem alloc] initWithCustomView:buttonPublish];
    
    NSArray *rightBarButtons = [[NSArray alloc] initWithObjects:checkItem, nil];
    
    self.navigationItem.rightBarButtonItems = rightBarButtons;
    
    
    
    UIToolbar* keyboardToolbar = [[UIToolbar alloc] init];
    [keyboardToolbar sizeToFit];
    UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                      target:nil action:nil];
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                      target:self action:@selector(dismissKeyboard2)];
    keyboardToolbar.items = @[flexBarButton, doneBarButton];
    _mCantidad.keyboardType = UIKeyboardTypeNumberPad;
    _mCantidad.inputAccessoryView = keyboardToolbar;
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    _mUploadOk.hidden = YES;
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

-(void) publicar {
    
    //Validar que nombre no esta vacio
    if([self validacion])
    {
        [self.view endEditing:YES];
        
        Libro_DTO *libro = [[Libro_DTO alloc] init];
        libro.idUsuario = [User_Setup_DAO getUserSetup].idUsuario;
        libro.titulo = _mNombre.text;
        libro.isbn = _mISBN.text;
        libro.url_local = [self saveImage];
        libro.isUploaded = [NSNumber numberWithInt:0];
        libro.fecha = [Helpers getCurrentTime];
        libro.descripcion = _mDescripcion.text;
        if(![_mCantidad.text  isEqual: @""])
        {
            NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
            f.numberStyle = NSNumberFormatterDecimalStyle;
            NSNumber *myNumber = [f numberFromString:_mCantidad.text];
            
            libro.cantidad = myNumber;
        }
        else
            libro.cantidad = [NSNumber numberWithInt:1];
        
        
        [Libro_DAO save:libro];
        
        _mUploadOk.hidden = NO;
        
        [self performSelector:@selector(closeView) withObject:self afterDelay:2.0 ];
        
    }
    else
    {
        // Mensaje de falta de informacion
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Faltan datos"
                                                        message:@"Debes ingresar al menos el nombre y el ISBN del libro."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
    }
}

-(bool) validacion {
    
    if(![_mNombre.text  isEqual: @""] && ![_mISBN.text  isEqual: @""])
        return true;
    
    return false;
    
}

-(void) closeView {
    
    //Resetear vista
    _mNombre.text = @"";
    _mDescripcion.text = @"";
    _mISBN.text = @"";
    _mImage.image = [UIImage imageNamed:@"camera-512.png"];
    _mCantidad.text = @"";
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)getPhoto{
    
    UIImagePickerController *mImagePicker = [[UIImagePickerController alloc]init];
    mImagePicker.delegate = self;
    mImagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:mImagePicker animated:true completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
    if(!img)
        img = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    _mImage.image = img;
    
    /*
     NSInteger nPixels = img.size.height*img.size.width;
     if(nPixels>MAX_RESOLUTION){
     float scale=((float)MAX_RESOLUTION)/nPixels;
     img=[Report_bussiness resizeImage:img toSize:CGSizeMake(img.size.width*scale, img.size.height*scale)];
     }
     */
    
    
    [picker dismissViewControllerAnimated:true completion:nil];
}

- (NSString *) saveImage {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"Alejandria-%f.%@", CACurrentMediaTime(),@"jpg"]];
    NSData *imageData = UIImagePNGRepresentation(_mImage.image);
    [imageData writeToFile:savedImagePath atomically:NO];
    
    return savedImagePath;
    
}

- (IBAction)addPhotoButtonAction:(id)sender {
    
    [self getPhoto];
}

- (IBAction)editandoNombre:(id)sender {
    
    _ajustado = false;
    [self ajustar:YES];
    
    if(_mNombre.text.length > 60)
        _mNombre.text = [_mNombre.text substringToIndex:60];
    
    _mNombreCuenta.text = [NSString stringWithFormat:@"%u de 60", _mNombre.text.length, nil];
    
}

- (IBAction)finEditarNombre:(id)sender {
    
    _ajustado = false;
    [self ajustar:NO];
    
}

- (IBAction)editandoDescripcion:(id)sender {
    
    _ajustado = false;
    [self ajustar:YES];
    
    if(_mNombre.text.length > 140)
        _mNombre.text = [_mNombre.text substringToIndex:140];
    
}

- (IBAction)finEditarDescripcion:(id)sender {
    
    _ajustado = false;
    [self ajustar:NO];
    
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    // Prevent crashing undo bug – see note below.
//    if(range.length + range.location > textField.text.length)
//    {
//        return NO;
//    }
//    
//    NSUInteger newLength = [textField.text length] + [string length] - range.length;
//    return newLength <= 25;
//}

//Metodo que ajusta la visualización al escribir datos en pantalla.
//Esto es para que teclado no tape datos en pantalla.
-(void) ajustar:(BOOL) valor
{
    //NSLog(@"antes %f", self.view.frame.origin.y);
    
    if(valor)
    {
        if(_ajustado==false)
        {
            // Arriba
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.3];
            self.view.frame = CGRectMake(self.view.frame.origin.x,-40, self.view.frame.size.width, self.view.frame.size.height);
            [UIView commitAnimations];
            _ajustado = true;
            _arriba_anterior = _arriba_actual;
            _arriba_actual = true;
        }
    }
    else
    {
        if(_ajustado==false)
        {
            // Abajo o normal
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.3];
            self.view.frame = CGRectMake(self.view.frame.origin.x, self.navigationController.navigationBar.frame.size.height+20, self.view.frame.size.width, self.view.frame.size.height);
            [UIView commitAnimations];
            _ajustado = true;
            _arriba_anterior = _arriba_actual;
            _arriba_actual = false;
        }
        
    }
    
    //NSLog(@"despues %f", self.view.frame.origin.y);
    
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

-(void)dismissKeyboard2 {
    [_mCantidad resignFirstResponder];
}

@end
