//
//  Favorito_DAO.h
//  Alejandria
//
//  Created by Alex Diaz on 3/24/17.
//  Copyright © 2017 Alex Diaz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Favorito_DTO.h"

@interface Favorito_DAO : UIViewController

+(bool) save:(Favorito_DTO*) favorito;
+(NSMutableArray*) getFavoritos;
+(bool) esFavorito:(NSNumber*) idLibro;
+(bool) remove:(NSNumber*) idLibro;

@end
