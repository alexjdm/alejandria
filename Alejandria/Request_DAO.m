//
//  Request_DAO.m
//  Alejandria
//
//  Created by Alex Diaz on 3/26/17.
//  Copyright © 2017 Alex Diaz. All rights reserved.
//

#import "Request_DAO.h"
#import "Request_DTO.h"
#import "FMDatabase.h"
#import "Helpers.h"

@implementation Request_DAO

+(bool) save:(Request_DTO*) solicitud {
    
    FMDatabase *db = [FMDatabase databaseWithPath:[Helpers getDatabasePath]];
    
    [db open];
    
    BOOL success =  [db executeUpdate:@"INSERT INTO solicitud (idLibro, idUsuarioSolicitante, fecha, idLibroCambio, idUsuarioCambio, estado) VALUES (?,?,?,?,?,?);", solicitud.idLibro, solicitud.idUsuarioSolicitante, solicitud.fecha, solicitud.idLibroCambio, solicitud.idUsuarioCambio, solicitud.estado];
    
    [db close];
    
    return success;
    
}

+(NSMutableArray *) getSolicitudes
{
    NSMutableArray *solicituds = [[NSMutableArray alloc] init];
    
    FMDatabase *db = [FMDatabase databaseWithPath:[Helpers getDatabasePath]];
    
    [db open];
    
    FMResultSet *results = [db executeQuery:@"SELECT * FROM solicitud"];
    
    Request_DTO *solicitud;
    while([results next])
    {
        solicitud = [[Request_DTO alloc] init];
        solicitud.idSolicitud = [NSNumber numberWithInt:[results intForColumn:@"idSolicitud"]];
        solicitud.idLibro = [NSNumber numberWithInt:[results intForColumn:@"idLibro"]];
        solicitud.idUsuarioSolicitante = [NSNumber numberWithInt:[results intForColumn:@"idUsuarioSolicitante"]];
        solicitud.fecha = [results dateForColumn:@"fecha"];
        solicitud.idLibroCambio = [NSNumber numberWithInt:[results intForColumn:@"idLibroCambio"]];
        solicitud.idUsuarioCambio = [NSNumber numberWithInt:[results intForColumn:@"idUsuarioCambio"]];
        solicitud.estado = [results stringForColumn:@"estado"];
        
        [solicituds addObject:solicitud];
        
    }
    
    [db close];
    
    return solicituds;
}

+(bool) estaSolicitado:(NSNumber*) idLibro {
    
    FMDatabase *db = [FMDatabase databaseWithPath:[Helpers getDatabasePath]];
    
    [db open];
    
    FMResultSet *results = [db executeQuery:@"SELECT * FROM solicitud where idLibro = ?", idLibro];
    
    Request_DTO *solicitud;
    while([results next])
    {
        solicitud = [[Request_DTO alloc] init];
        solicitud.idSolicitud = [NSNumber numberWithInt:[results intForColumn:@"idSolicitud"]];
        solicitud.idLibro = [NSNumber numberWithInt:[results intForColumn:@"idLibro"]];
        solicitud.idUsuarioSolicitante = [NSNumber numberWithInt:[results intForColumn:@"idUsuarioSolicitante"]];
        solicitud.fecha = [results dateForColumn:@"fecha"];
        solicitud.idLibroCambio = [NSNumber numberWithInt:[results intForColumn:@"idLibroCambio"]];
        solicitud.idUsuarioCambio = [NSNumber numberWithInt:[results intForColumn:@"idUsuarioCambio"]];
        solicitud.estado = [results stringForColumn:@"estado"];
    }
    
    [db close];
    if(solicitud != nil)
        return true;
    else
        return false;
    
}

+(bool) remove:(NSNumber*) idSolicitud {
    
    FMDatabase *db = [FMDatabase databaseWithPath:[Helpers getDatabasePath]];
    
    [db open];
    
    bool success= [db executeUpdate:@"delete from solicitud where idSolicitud = ?;", idSolicitud];
    [db close];
    return success;
    
}


@end
