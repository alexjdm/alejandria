//
//  Request_DTO.h
//  Alejandria
//
//  Created by Alex Diaz on 3/26/17.
//  Copyright © 2017 Alex Diaz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Request_DTO : NSObject

@property NSNumber * idSolicitud;
@property NSNumber * idLibro;
@property NSNumber * idUsuarioSolicitante;
@property NSDate * fecha;
@property NSNumber * idLibroCambio;
@property NSNumber * idUsuarioCambio;
@property NSString *estado;

@end
