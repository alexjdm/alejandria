//
//  Request_DAO.h
//  Alejandria
//
//  Created by Alex Diaz on 3/26/17.
//  Copyright © 2017 Alex Diaz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Request_DTO.h"

@interface Request_DAO : NSObject

+(bool) save:(Request_DTO*) solicitud;
+(NSMutableArray*) getSolicitudes;
+(bool) estaSolicitado:(NSNumber*) idLibro;
+(bool) remove:(NSNumber*) idSolicitud;

@end
