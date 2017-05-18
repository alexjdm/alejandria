//
//  ExchangesViewController.m
//  Alejandria
//
//  Created by Alex Diaz on 5/1/17.
//  Copyright © 2017 Alex Diaz. All rights reserved.
//

#import "ExchangesViewController.h"
#import "Request_DAO.h"
#import "Request_DTO.h"
#import "Libro_DAO.h"
#import "Libro_DTO.h"
#import "ExchangeTableViewCell.h"
#import "BookViewController.h"
#import "User_Setup_DAO.h"

@interface ExchangesViewController () <UITableViewDelegate,UITableViewDataSource>

@end

@implementation ExchangesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationBar.topItem.title = @"";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.title = @"Intercambios";
    
    _mTableView.delegate = self;
    _mTableView.dataSource=self;
    _mTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _mTableView.allowsSelection = NO;
}

-(void) viewWillAppear:(BOOL)animated {
    
    [self.navigationController setToolbarHidden:YES];
    
    [self loadSourceDataSolicitudes];
    
}

-(void) viewWillDisappear:(BOOL)animated {
    
    [self.navigationController setToolbarHidden:NO];
    
}

-(void) loadSourceDataSolicitudes {
    
    _sourceDataSolicitudes = [[NSMutableArray alloc] init];
    NSMutableArray * source = [Request_DAO getSolicitudes];
    
    for (Request_DTO *f_dto in source) {
        [_sourceDataSolicitudes addObject:f_dto];
    }
    
    [_mTableView reloadData];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_sourceDataSolicitudes count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ExchangeTableViewCell"];
    NSObject *mObject;
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ExchangeTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    mObject = _sourceDataSolicitudes[indexPath.row];
    Request_DTO *fav = (Request_DTO *)mObject;
    Libro_DTO *lib = [Libro_DAO getLibro:fav.idLibro];
    
    
    return [self cellWithLibro:lib forTable:tableView:indexPath.row];
    
}

-(UITableViewCell *) cellWithLibro:(Libro_DTO *) libro forTable:(UITableView *)table :(NSInteger) identificador{
    
    static NSString *simpleTableIdentifier = @"ExchangeTableViewCell";
    ExchangeTableViewCell *cell = (ExchangeTableViewCell *)[table dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ExchangeTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    if([libro.titulo  isEqual: @"El Señor de los Anillos"])
    {
        UIImage *img = [[UIImage imageNamed:@"elsenor1.jpg"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        cell.mImagen.image = img;
    }
    else if ([libro.titulo  isEqual: @"Harry Potter"])
    {
        UIImage *img = [[UIImage imageNamed:@"harrypotter1.jpg"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        cell.mImagen.image = img;
    }
    else if ([libro.titulo  isEqual: @"One Hundred Years of Solitude"])
    {
        UIImage *img = [[UIImage imageNamed:@"cien1.jpg"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        cell.mImagen.image = img;
    }
    else if(libro.url_local != nil && ![libro.url_local  isEqual: @""])
    {
        NSString *path = libro.url_local;
        NSArray *namesArray = [path componentsSeparatedByString:@"/"];
        NSString *imageName = [namesArray lastObject];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory ,NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *getImagePath = [documentsDirectory stringByAppendingPathComponent:imageName];
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:getImagePath];
        cell.mImagen.image = image;
    }
    
    //cell.sv = self;
    cell.mTitulo.text = libro.titulo;
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"dd-MM-yyyy HH:mm:ss";
    
    cell.mFecha.text = [NSString stringWithFormat:@"Intercambio realizado el %@", [format stringFromDate:libro.fecha]];
    
    User_Setup_DTO*userAnterior = [User_Setup_DAO getUser:libro.idUsuario];
    cell.mUsuario.text = [NSString stringWithFormat:@"%@ era el dueño anterior", userAnterior.nombres];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    NSDictionary *mObject = [_sourceDataSolicitudes objectAtIndex:indexPath.row];
//    Request_DTO *fav = (Request_DTO *)mObject;
//    Libro_DTO *libro = [Libro_DAO getLibro:fav.idLibro];
//    
//    BookViewController *bv = [[BookViewController alloc]init];
//    bv.libro = libro;
//    
//    [self.navigationController pushViewController:bv animated:true];
//    
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger numOfSections = 0;
    if (_sourceDataSolicitudes.count > 0)
    {
        _mTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        numOfSections                = 1;
        _mTableView.backgroundView = nil;
    }
    else
    {
        UILabel *noDataLabel         = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _mTableView.bounds.size.width, _mTableView.bounds.size.height)];
        noDataLabel.text             = @"No has realizado intercambios";
        noDataLabel.textColor        = [UIColor blackColor];
        noDataLabel.textAlignment    = NSTextAlignmentCenter;
        _mTableView.backgroundView = noDataLabel;
        _mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return numOfSections;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}




@end
