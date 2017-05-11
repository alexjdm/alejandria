//
//  DatabaseHelper.m
//  Alejandria
//
//  Created by Alex Diaz on 2/27/17.
//  Copyright © 2017 Alex Diaz. All rights reserved.
//

#import "DatabaseHelper.h"
#import "FMDatabase.h"
#import "Helpers.h"

@interface DatabaseHelper()

+(void)createTable:(NSString *)table inDB:(FMDatabase *)db;
+(void)insertColumn:(NSString *)column withType: (NSString *) type inTable:(NSString *)table inDB:(FMDatabase *)db;

@end

@implementation DatabaseHelper

+(void)recreateDatabase{
    
    NSMutableDictionary *tablas=[[NSMutableDictionary alloc]init];
    
    FMDatabase *db = [FMDatabase databaseWithPath:[Helpers getDatabasePath]];
    [db open];
    
    BOOL succes1 __unused=[db executeStatements:@"CREATE TABLE user_setup ( idUsuario INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE, correo_electronico TEXT NOT NULL, nombres TEXT NOT NULL, apellidos TEXT NOT NULL, password TEXT NOT NULL, ultimo_login DATETIME NOT NULL, telefono TEXT NOT NULL, genero TEXT NOT NULL, direccion TEXT);"];
    
    BOOL succes2 __unused=[db executeStatements:@"CREATE TABLE libro ( idLibro INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE, isbn TEXT, titulo TEXT, descripcion TEXT, url_local TEXT, isUploaded INTEGER default 0, idUsuario INTEGER, fecha DATETIME, cantidad INTEGER);"];
    
    BOOL success3 __unused =[db executeStatements:@"CREATE TABLE favorito (idFavorito INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE, idLibro INTEGER, fecha datetime);"];
    
    BOOL success4 __unused =[db executeStatements:@"CREATE TABLE solicitud (idSolicitud INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE, idLibro INTEGER, idUsuarioSolicitante INTEGER, fecha datetime, idLibroCambio INTEGER, idUsuarioCambio INTEGER, estado TEXT);"];
    
    BOOL success5 __unused =[db executeStatements:@"CREATE TABLE mensaje (idMensaje INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE, idMensajePadre INTEGER, texto TEXT, fecha datetime, idLibro INTEGER, idUsuarioSender INTEGER);"];
    
    BOOL success64 __unused =[db executeStatements:@"CREATE TABLE LOG (ID_LOG INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,FECHA_LOG DATETIME,DESCRIPCION_LOG TEXT);"];
    
    
    BOOL success69 __unused = [db executeStatements:@"ALTER TABLE LOG ADD COLUMN  EVENTO TEXT;"];
    BOOL success70 __unused = [db executeStatements:@"ALTER TABLE LOG ADD COLUMN  VERSION TEXT;"];
    BOOL success71 __unused = [db executeStatements:@"ALTER TABLE LOG ADD COLUMN  BATERIA TEXT;"];
    BOOL success72 __unused = [db executeStatements:@"ALTER TABLE LOG ADD COLUMN  PERMISOUBICACION TEXT;"];
    BOOL success73 __unused = [db executeStatements:@"ALTER TABLE LOG ADD COLUMN  LATITUD TEXT;"];
    BOOL success74 __unused = [db executeStatements:@"ALTER TABLE LOG ADD COLUMN  LONGITUD TEXT;"];
    BOOL success75 __unused = [db executeStatements:@"ALTER TABLE LOG ADD COLUMN  ACCURACY TEXT;"];
    BOOL success76 __unused = [db executeStatements:@"ALTER TABLE LOG ADD COLUMN  SISTEMA TEXT;"];
    BOOL success77 __unused = [db executeStatements:@"ALTER TABLE LOG ADD COLUMN  MENSAJE TEXT;"];
    BOOL success81 __unused = [db executeStatements:@"ALTER TABLE LOG ADD COLUMN  SUBIDO INTEGER DEFAULT 0;"];
    
    for (NSString *tableName in tablas.allKeys) {
        
        [self createTable:tableName inDB:db];
        NSDictionary *columns=tablas[tableName];
        for (NSString * columnName in columns.allKeys) {
            [self insertColumn:columnName withType:columns[columnName] inTable:tableName inDB:db];
        }
        
    }
    
    [db close];
}

+(void)insertColumn:(NSString *)column withType:(NSString *)type inTable:(NSString *)table inDB:(FMDatabase *)db{
    NSString *queryString=[NSString stringWithFormat:@"ALTER TABLE %@ ADD COLUMN %@ %@;",table,column,type];
    BOOL success __unused =[db executeStatements:queryString];
}

+(void)createTable:(NSString *)table inDB:(FMDatabase *)db{
    NSString *queryString=[NSString stringWithFormat:@"CREATE TABLE %@ (aux integer);",table];
    BOOL success __unused =[db executeStatements:queryString];
}

+(void) deleteAllDataBase{
    
    FMDatabase *db = [FMDatabase databaseWithPath:[Helpers getDatabasePath]];
    [db open];
    
    bool success1 __unused = [db executeStatements:@"DELETE FROM favorito"];
    bool success2 __unused = [db executeStatements:@"DELETE FROM libro"];
    bool success3 __unused = [db executeStatements:@"DELETE FROM solicitud"];
    bool success4 __unused = [db executeStatements:@"DELETE FROM sqlite_sequence"];
    bool success5 __unused = [db executeStatements:@"DELETE FROM user_setup"];
    
    [db close];
}

@end
