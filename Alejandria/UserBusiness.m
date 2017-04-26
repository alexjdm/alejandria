//
//  UserBusiness.m
//  HereApp
//
//  Created by Alex Diaz on 1/11/17.
//  Copyright © 2017 Alex Diaz. All rights reserved.
//

#import "UserBusiness.h"
#import "Libro_DAO.h"
#import "Libro_DTO.h"
#import "Helpers.h"


@implementation UserBusiness

-(User_Setup_DTO*) fakeDoLogin:(User_Setup_DTO *) user {
    
    User_Setup_DTO *userRet = [[User_Setup_DTO alloc] init];
    userRet.correo_electronico = user.correo_electronico;
    userRet.apellidos = @"Diaz";
    userRet.nombres= @"Alex";
    userRet.idUsuario = [NSNumber numberWithInt:1];
    userRet.password = user.password;
    userRet.telefono = @"+56951145392";
    userRet.genero = @"M";
    userRet.ultimo_login = [NSDate date];
    userRet.direccion = @"Canea Alta 2222, Puente Alto";
    
    return userRet;
}

-(void)doLogin:(User_Setup_DTO *) user{
    
    NSOperationQueue* operationQueue = [[NSOperationQueue alloc] init];
    [operationQueue addOperationWithBlock:^{
        // Perform long-running tasks without blocking main thread
        //User_Setup_DTO * usuarioLogin = [ClienteHTTP doLogin:user];
        User_Setup_DTO * usuarioLogin = [self fakeDoLogin:user];
        
        if (usuarioLogin.idUsuario == nil && usuarioLogin.msg_feedback_login.length > 0)
        {
            _msg_feedback_login = usuarioLogin.msg_feedback_login;
            usuarioLogin = NULL;
        }
        
        [User_Setup_DAO insert:usuarioLogin];
        
        if (usuarioLogin == NULL)
        {
            NSLog(@"LoginErroneo");
            [_delegadoLoginController loginValidado:false];
        }
        else{
            NSLog(@"LoginExitoso");
            //[UserBusiness RefreshIfNeeded];
            [_delegadoLoginController loginValidado:true];
            
            //Fake Otro Usuario
            [self fakeUsuario];
            
            //Fake Libros
            [self fakeLibros];
            
            
        }
        
    }];
    
}

-(void) fakeUsuario {
    
    User_Setup_DTO *userRet = [[User_Setup_DTO alloc] init];
    userRet.correo_electronico = @"usertest@gmail.com";
    userRet.apellidos = @"Castellon";
    userRet.nombres= @"Javier";
    userRet.password = @"1234";
    userRet.telefono = @"+56951322352";
    userRet.genero = @"M";
    userRet.ultimo_login = [NSDate date];
    userRet.direccion = @"Mariana Jan 1231, La Florida";
    
    [User_Setup_DAO insert:userRet];
}

-(void) fakeLibros {
    
    Libro_DTO *libro = [[Libro_DTO alloc] init];
    libro.idUsuario = [NSNumber numberWithInt:2];
    libro.titulo = @"El Señor de los Anillos";
    libro.isbn = @"912-121";
    //libro.url_local = [self saveImage];
    libro.isUploaded = [NSNumber numberWithInt:0];
    libro.fecha = [Helpers getCurrentTime];
    libro.descripcion = @"The future of civilization rests in the fate of the One Ring, which has been lost for centuries. Powerful forces are unrelenting in their search for it. But fate has placed it in the hands of a young Hobbit named Frodo Baggins (Elijah Wood), who inherits the Ring and steps into legend.";
    
    libro.cantidad = [NSNumber numberWithInt:1];
    
    [Libro_DAO save:libro];
    
    
    libro.titulo = @"Harry Potter";
    libro.isbn = @"222-121";
    libro.fecha = [Helpers getCurrentTime];
    libro.descripcion = @"Harry Potter is a series of fantasy novels written by British author J. K. Rowling. The novels chronicle the life of a young wizard, Harry Potter, and his friends Hermione Granger and Ron Weasley.";
    libro.url_local = [[NSBundle mainBundle] pathForResource:@"harrypotter1" ofType:@"jpg"];
    
    [Libro_DAO save:libro];
    
    libro.titulo = @"One Hundred Years of Solitude";
    libro.isbn = @"4534-123123";
    libro.fecha = [Helpers getCurrentTime];
    libro.descripcion = @"One Hundred Years of Solitude is a landmark 1967 novel by Colombian author Gabriel García Márquez that tells the multi-generational story of the Buendía family, whose patriarch, José Arcadio Buendía.";
    
    [Libro_DAO save:libro];

    
}

-(NSString*) getMsg{
    return _msg_feedback_login;
}

@end

