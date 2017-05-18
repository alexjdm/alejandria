//
//  Libro_DAO.m
//  Alejandria
//
//  Created by Alex Diaz on 3/1/17.
//  Copyright © 2017 Alex Diaz. All rights reserved.
//

#import "Libro_DAO.h"
#import "Libro_DTO.h"
#import "FMDatabase.h"
#import "Helpers.h"

@implementation Libro_DAO

+(bool) save:(Libro_DTO*) libro {
    
    FMDatabase *db = [FMDatabase databaseWithPath:[Helpers getDatabasePath]];
    
    [db open];
    
    BOOL success =  [db executeUpdate:@"INSERT INTO libro (isbn, titulo, descripcion, url_local, isUploaded, idUsuario, fecha, cantidad) VALUES (?,?,?,?,?,?,?,?);", libro.isbn, libro.titulo, libro.descripcion, libro.url_local, libro.isUploaded, libro.idUsuario, libro.fecha, libro.cantidad];
    
    long long lastId = [db lastInsertRowId];
    
    libro.idLibro = [NSNumber numberWithLongLong:lastId];
    
    [db close];
    
    return success;
    
}

+(NSMutableArray *) getLibros
{
    NSMutableArray *libros = [[NSMutableArray alloc] init];
    
    FMDatabase *db = [FMDatabase databaseWithPath:[Helpers getDatabasePath]];
    
    [db open];
    
    FMResultSet *results = [db executeQuery:@"SELECT * FROM libro"];
    
    Libro_DTO *libro;
    while([results next])
    {
        libro = [[Libro_DTO alloc] init];
        libro.idLibro = [NSNumber numberWithInt:[results intForColumn:@"idLibro"]];
        libro.isbn = [results stringForColumn:@"isbn"];
        libro.titulo = [results stringForColumn:@"titulo"];
        libro.url_local = [results stringForColumn:@"url_local"];
        libro.descripcion = [results stringForColumn:@"descripcion"];
        libro.idUsuario = [NSNumber numberWithInt:[results intForColumn:@"idUsuario"]];
        libro.isUploaded = [NSNumber numberWithInt:[results intForColumn:@"isUploaded"]];
        libro.cantidad = [NSNumber numberWithInt:[results intForColumn:@"cantidad"]];
        libro.fecha = [results dateForColumn:@"fecha"];
        
        [libros addObject:libro];
        
    }
    
    [db close];
    
    return libros;
}

+(Libro_DTO*) getLibro:(NSNumber*) idLibro {
    
    FMDatabase *db = [FMDatabase databaseWithPath:[Helpers getDatabasePath]];
    
    [db open];
    
    FMResultSet *results = [db executeQuery:@"SELECT * FROM libro where idLibro = ?", idLibro];
    
    Libro_DTO *libro;
    while([results next])
    {
        libro = [[Libro_DTO alloc] init];
        libro.idLibro = [NSNumber numberWithInt:[results intForColumn:@"idLibro"]];
        libro.isbn = [results stringForColumn:@"isbn"];
        libro.titulo = [results stringForColumn:@"titulo"];
        libro.url_local = [results stringForColumn:@"url_local"];
        libro.descripcion = [results stringForColumn:@"descripcion"];
        libro.idUsuario = [NSNumber numberWithInt:[results intForColumn:@"idUsuario"]];
        libro.isUploaded = [NSNumber numberWithInt:[results intForColumn:@"isUploaded"]];
        libro.cantidad = [NSNumber numberWithInt:[results intForColumn:@"cantidad"]];
        libro.fecha = [results dateForColumn:@"fecha"];
    }
    
    [db close];
    
    return libro;
    
}

+(bool) libro:(NSNumber*) idLibro esMio:(NSNumber*) idUsuario {
    
    Libro_DTO* libro = [self getLibro:idLibro];
    if(libro.idUsuario == idUsuario)
        return true;
    else
        return false;
    
}

+(NSNumber*) getRandomIdFromUserId: (NSNumber*) idUsuario; {
    
    FMDatabase *db = [FMDatabase databaseWithPath:[Helpers getDatabasePath]];
    
    [db open];
    
    FMResultSet *results = [db executeQuery:@"SELECT * FROM libro WHERE idUsuario = ? ORDER BY RANDOM() LIMIT 1;", idUsuario];
    
    Libro_DTO *libro;
    while([results next])
    {
        libro = [[Libro_DTO alloc] init];
        libro.idLibro = [NSNumber numberWithInt:[results intForColumn:@"idLibro"]];
    }
    
    [db close];
    
    return libro.idLibro;
    
}

@end
