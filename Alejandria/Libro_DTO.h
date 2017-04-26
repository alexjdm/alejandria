//
//  Libros_DTO.h
//  Alejandria
//
//  Created by Alex Diaz on 2/28/17.
//  Copyright © 2017 Alex Diaz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Libro_DTO : NSObject

@property NSNumber * idLibro;
@property NSString * isbn;
@property NSString * titulo;
@property NSString * descripcion;
@property NSString * url_local;
@property NSNumber * isUploaded;
@property NSNumber * idUsuario;
@property NSDate * fecha;
@property NSNumber * cantidad;

@end
