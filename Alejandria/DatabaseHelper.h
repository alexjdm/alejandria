//
//  DatabaseHelper.h
//  Alejandria
//
//  Created by Alex Diaz on 2/27/17.
//  Copyright © 2017 Alex Diaz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DatabaseHelper : NSObject

+(void) recreateDatabase;
+(void) deleteAllDataBase;

@end
