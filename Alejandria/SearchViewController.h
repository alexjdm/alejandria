//
//  SearchViewController.h
//  Alejandria
//
//  Created by Alex Diaz on 2/22/17.
//  Copyright © 2017 Alex Diaz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrincipalController.h"

@interface SearchViewController : UIViewController 

@property PrincipalController * controladorPrincipal;

@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property (weak, nonatomic) IBOutlet UISearchBar *mSearchBar;
@property NSMutableArray *sourceDataLibros;
@property NSMutableArray * array_de_libros_filtrados;
@property bool buscando;
@property (strong, nonatomic) IBOutlet UISearchController *libroSearchController;

-(void)openBook;

@end
