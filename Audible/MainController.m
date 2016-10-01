//
//  MainController.m
//  Audible
//
//  Created by Doan Dat on 10/1/16.
//  Copyright (c) 2016 Doan Dat. All rights reserved.
//

#import "MainController.h"
#import "LoginController.h"
#import "HomeController.h"

@interface MainController ()

@property (nonatomic, assign) BOOL isLoginedIn;

@end

@implementation MainController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (self.isLoginedIn) {
        HomeController *homeController = [[HomeController alloc] init];
        self.viewControllers = @[homeController];
    }
    else {
        [self performSelector:@selector(showLoginController) withObject:nil afterDelay:0.01];
    }
}

- (BOOL)isLoginedIn {
    return true;
}

- (void)showLoginController {
    LoginController *loginController = [[LoginController alloc] init];
    [self presentViewController:loginController animated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
