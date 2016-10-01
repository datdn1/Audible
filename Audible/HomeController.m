//
//  HomeController.m
//  Audible
//
//  Created by Doan Dat on 10/1/16.
//  Copyright (c) 2016 Doan Dat. All rights reserved.
//

#import "HomeController.h"
#import "Masonry.h"

@interface HomeController ()

@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    imageView.image = [UIImage imageNamed:@"home"];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.and.bottom.equalTo(self.view);
        make.top.equalTo(self.view).offset(64);
    }];
    
    self.navigationItem.title = @"List Music";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
