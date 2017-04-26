//
//  WishListViewController.m
//  Alejandria
//
//  Created by Alex Diaz on 2/22/17.
//  Copyright © 2017 Alex Diaz. All rights reserved.
//

#import "WishListViewController.h"
#import "Favorito_DAO.h"
#import "Libro_DAO.h"
#import "LibroTableViewCell.h"
#import "BookViewController.h"

@interface WishListViewController () <UITableViewDelegate,UITableViewDataSource>

@end

@implementation WishListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.hidesBackButton = YES;
    
    _mTableView.delegate = self;
    _mTableView.dataSource=self;
    _mTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
}

-(void) viewWillAppear:(BOOL)animated {
    
    [self loadSourceDataFavoritos];
    
}

-(void) loadSourceDataFavoritos {
    
    _sourceDataFavoritos = [[NSMutableArray alloc] init];
    NSMutableArray * source = [Favorito_DAO getFavoritos];
    
    for (Favorito_DTO *f_dto in source) {
        [_sourceDataFavoritos addObject:f_dto];
    }
    
    [_mTableView reloadData];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_sourceDataFavoritos count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LibroTableViewCell"];
    NSObject *mObject;
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"LibroTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    mObject = _sourceDataFavoritos[indexPath.row];
    Favorito_DTO *fav = (Favorito_DTO *)mObject;
    Libro_DTO *lib = [Libro_DAO getLibro:fav.idLibro];
        
    
    return [self cellWithLibro:lib forTable:tableView:indexPath.row];
    
}

-(UITableViewCell *) cellWithLibro:(Libro_DTO *) libro forTable:(UITableView *)table :(NSInteger) identificador{
    
    static NSString *simpleTableIdentifier = @"LibroTableViewCell";
    LibroTableViewCell *cell = (LibroTableViewCell *)[table dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"LibroTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    
    if([libro.titulo  isEqual: @"El Señor de los Anillos"])
    {
        UIImage *img = [[UIImage imageNamed:@"elsenor1.jpg"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        cell.mImage.image = img;
    }
    else if ([libro.titulo  isEqual: @"Harry Potter"])
    {
        UIImage *img = [[UIImage imageNamed:@"harrypotter1.jpg"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        cell.mImage.image = img;
    }
    else if ([libro.titulo  isEqual: @"One Hundred Years of Solitude"])
    {
        UIImage *img = [[UIImage imageNamed:@"cien1.jpg"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        cell.mImage.image = img;
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
        cell.mImage.image = image;
    }
    
    //cell.sv = self;
    cell.mTitulo.text = libro.titulo;
    cell.mISBN.text = [NSString stringWithFormat:@"ISBN: %@", libro.isbn];
    cell.mDescripcion.text = libro.descripcion;
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *mObject = [_sourceDataFavoritos objectAtIndex:indexPath.row];
    Favorito_DTO *fav = (Favorito_DTO *)mObject;
    Libro_DTO *libro = [Libro_DAO getLibro:fav.idLibro];
    
    BookViewController *bv = [[BookViewController alloc]init];
    bv.libro = libro;
    
    [self.navigationController pushViewController:bv animated:true];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger numOfSections = 0;
    if (_sourceDataFavoritos.count > 0)
    {
        _mTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        numOfSections                = 1;
        _mTableView.backgroundView = nil;
    }
    else
    {
        UILabel *noDataLabel         = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _mTableView.bounds.size.width, _mTableView.bounds.size.height)];
        noDataLabel.text             = @"No tienes favoritos";
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
