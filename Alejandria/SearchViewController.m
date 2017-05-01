//
//  SearchViewController.m
//  Alejandria
//
//  Created by Alex Diaz on 2/22/17.
//  Copyright © 2017 Alex Diaz. All rights reserved.
//

#import "SearchViewController.h"
#import "Libro_DAO.h"
#import "Libro_DTO.h"
#import "LibroTableViewCell.h"
#import "BookViewController.h"
#import "User_Setup_DAO.h"

@interface SearchViewController () <UISearchBarDelegate,UISearchControllerDelegate,UISearchResultsUpdating,UITableViewDelegate,UITableViewDataSource,UIBarPositioningDelegate>

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.hidesBackButton = YES;
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
//                                                                          action:@selector(dismissKeyboard)];
//    
//    [self.view addGestureRecognizer:tap];
    
    
    UIToolbar* keyboardToolbar = [[UIToolbar alloc] init];
    [keyboardToolbar sizeToFit];
    UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                      target:nil action:nil];
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                      target:self action:@selector(dismissKeyboard2)];
    keyboardToolbar.items = @[flexBarButton, doneBarButton];
    _mSearchBar.inputAccessoryView = keyboardToolbar;
    
    
    //_mSearchBar.showsCancelButton = YES;
    _mSearchBar.barTintColor = [UIColor colorWithRed:0.83
                                               green:0.18
                                                blue:0.30
                                               alpha:1.0];
    [_mSearchBar setTintColor:[UIColor whiteColor]];
    
    _libroSearchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _libroSearchController.delegate = self;
    _libroSearchController.searchResultsUpdater = self;
    _libroSearchController.searchBar.delegate = self;
    _libroSearchController.dimsBackgroundDuringPresentation = NO;
    _libroSearchController.hidesNavigationBarDuringPresentation = NO;
    
    _mTableView.delegate = self;
    _mTableView.dataSource=self;
    _mTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
}

-(void) viewWillAppear:(BOOL)animated {
    
    [self loadSourceDataLibros];
    
}

-(void) loadSourceDataLibros {
    
    _sourceDataLibros = [[NSMutableArray alloc] init];
    NSMutableArray * source = [Libro_DAO getLibros];
    
    for (Libro_DTO *l_dto in source) {
        [_sourceDataLibros addObject:l_dto];
    }
    
    [_mTableView reloadData];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(_buscando == true)
        return [_array_de_libros_filtrados count];
    else
        return [_sourceDataLibros count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LibroTableViewCell"];
    NSObject *mObject;
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"LibroTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    if(_buscando)
        mObject = _array_de_libros_filtrados[indexPath.row];
    else
        mObject = _sourceDataLibros[indexPath.row];
    
    return [self cellWithLibro:(Libro_DTO *)mObject forTable:tableView:indexPath.row];
    
}


-(UITableViewCell *) cellWithLibro:(Libro_DTO *) libro forTable:(UITableView *)table :(NSInteger) identificador{
    
    static NSString *simpleTableIdentifier = @"LibroTableViewCell";
    LibroTableViewCell *cell = (LibroTableViewCell *)[table dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"LibroTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    if(libro.idUsuario != [User_Setup_DAO getUserSetup].idUsuario)
    {
        cell.mLibroPropio.hidden = YES;
    }
    else {
        cell.mLibroPropio.hidden = NO;
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
    
    cell.sv = self;
    cell.mTitulo.text = libro.titulo;
    cell.mISBN.text = [NSString stringWithFormat:@"ISBN: %@", libro.isbn];
    cell.mDescripcion.text = libro.descripcion;
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *mObject = [_sourceDataLibros objectAtIndex:indexPath.row];
    Libro_DTO * libro = (Libro_DTO *)mObject;
    
    BookViewController *bv = [[BookViewController alloc]init];
    bv.libro = libro;
    
    [self.navigationController pushViewController:bv animated:true];
    
    [_mSearchBar resignFirstResponder];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger numOfSections = 0;
    if ((_buscando && _array_de_libros_filtrados.count > 0) || ((!_buscando && _sourceDataLibros.count > 0)) )
    {
        _mTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        numOfSections                = 1;
        _mTableView.backgroundView = nil;
    }
    else
    {
        UILabel *noDataLabel         = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _mTableView.bounds.size.width, _mTableView.bounds.size.height)];
        noDataLabel.text             = @"No data available";
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


#pragma mark search bar

-(void) searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
    [searchBar resignFirstResponder];
    
    _buscando = false;
    
    [self loadSourceDataLibros];
    [_mTableView reloadData];
    _mSearchBar.text = @"";
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    _buscando = true;
    
    _array_de_libros_filtrados = [_sourceDataLibros copy];
    NSMutableArray *auxArray=[[NSMutableArray alloc]init];
    NSArray *components=[searchText componentsSeparatedByString:@" "];
    for (Libro_DTO *libro in _array_de_libros_filtrados) {
        BOOL matchesSearchText=true;
        for(NSString *string in components){
            if(string.length>0){
                NSString * capitalizedDescripcion=[libro.titulo uppercaseString];
                NSString * capitalizedString=[string uppercaseString];
                if(![capitalizedDescripcion containsString:capitalizedString]){
                    matchesSearchText=false;
                }
            }
        }
        if(matchesSearchText){
            [auxArray addObject:libro];
        }
    }
    
    _array_de_libros_filtrados=nil;
    _array_de_libros_filtrados=[[NSMutableArray alloc]initWithArray:auxArray];
    
    if([searchText length] == 0)
    {
        [self loadSourceDataLibros];
    }
    
    [_mTableView reloadData];
    
}

-(void)dismissKeyboard2 {
    [_mSearchBar resignFirstResponder];
}


@end
