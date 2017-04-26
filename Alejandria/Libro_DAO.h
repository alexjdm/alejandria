//
//  Libro_DAO.h
//  Alejandria
//
//  Created by Alex Diaz on 3/1/17.
//  Copyright © 2017 Alex Diaz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Libro_DTO.h"

@interface Libro_DAO : NSObject

+(bool) save:(Libro_DTO*) libro;
+(NSMutableArray*) getLibros;
+(Libro_DTO*) getLibro:(NSNumber*) idLibro;
+(bool) libro:(NSNumber*) idLibro esMio:(NSNumber*) idUsuario;

@end
