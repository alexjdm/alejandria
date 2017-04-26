//
//  Favorito_DAO.m
//  Alejandria
//
//  Created by Alex Diaz on 3/24/17.
//  Copyright © 2017 Alex Diaz. All rights reserved.
//

#import "Favorito_DAO.h"
#import "Favorito_DTO.h"
#import "FMDatabase.h"
#import "Helpers.h"

@implementation Favorito_DAO

+(bool) save:(Favorito_DTO*) favorito {
    
    FMDatabase *db = [FMDatabase databaseWithPath:[Helpers getDatabasePath]];
    
    [db open];
    
    BOOL success =  [db executeUpdate:@"INSERT INTO favorito (idLibro, fecha) VALUES (?,?);", favorito.idLibro, favorito.fecha];
    
    [db close];
    
    return success;
    
}

+(NSMutableArray *) getFavoritos
{
    NSMutableArray *favoritos = [[NSMutableArray alloc] init];
    
    FMDatabase *db = [FMDatabase databaseWithPath:[Helpers getDatabasePath]];
    
    [db open];
    
    FMResultSet *results = [db executeQuery:@"SELECT * FROM favorito"];
    
    Favorito_DTO *favorito;
    while([results next])
    {
        favorito = [[Favorito_DTO alloc] init];
        favorito.idFavorito = [NSNumber numberWithInt:[results intForColumn:@"idFavorito"]];
        favorito.idLibro = [NSNumber numberWithInt:[results intForColumn:@"idLibro"]];
        favorito.fecha = [results dateForColumn:@"fecha"];
        
        [favoritos addObject:favorito];
        
    }
    
    [db close];
    
    return favoritos;
}

+(bool) esFavorito:(NSNumber*) idLibro
{
    FMDatabase *db = [FMDatabase databaseWithPath:[Helpers getDatabasePath]];
    
    [db open];
    
    FMResultSet *results = [db executeQuery:@"SELECT * FROM favorito where idLibro = ?", idLibro];
    
    Favorito_DTO *favorito;
    while([results next])
    {
        favorito = [[Favorito_DTO alloc] init];
        favorito.idFavorito = [NSNumber numberWithInt:[results intForColumn:@"idFavorito"]];
        favorito.idLibro = [NSNumber numberWithInt:[results intForColumn:@"idLibro"]];
        favorito.fecha = [results dateForColumn:@"fecha"];
    }
    
    [db close];
    if(favorito != nil)
        return true;
    else
        return false;
}

+(bool) remove:(NSNumber*) idLibro {
    
    FMDatabase *db = [FMDatabase databaseWithPath:[Helpers getDatabasePath]];
    
    [db open];
    
    bool success= [db executeUpdate:@"delete from favorito where idLibro = ?;", idLibro];
    [db close];
    return success;
    
}

@end
