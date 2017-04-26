//
//  LibroTableViewCell.m
//  Alejandria
//
//  Created by Alex Diaz on 3/1/17.
//  Copyright © 2017 Alex Diaz. All rights reserved.
//

#import "LibroTableViewCell.h"

@implementation LibroTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)openBook:(id)sender {
    
    [_sv openBook];
    
}


@end
