//
//  Log_DAO.h
//  Alejandria
//
//  Created by Alex Diaz on 2/27/17.
//  Copyright © 2017 Alex Diaz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Log_DTO.h"
#import <CoreLocation/CoreLocation.h>

@interface Log_DAO : NSObject

+(void) insert:(Log_DTO *)log;
+(NSMutableArray *) getLogs;
+(BOOL) setLogAsUploaded:(NSMutableArray *) logs;

@end

