//
//  LoginCell.m
//  Audible
//
//  Created by Doan Dat on 9/30/16.
//  Copyright (c) 2016 Doan Dat. All rights reserved.
//

#import "LoginCell.h"
#import "Masonry.h"
#import "LeftPaddingTextField.h"

@interface LoginCell ()

@property (nonatomic, strong) UIImageView *loginImageView;
@property (nonatomic, strong) LeftPaddingTextField *emailTextField;
@property (nonatomic, strong) LeftPaddingTextField *passwordTextField;
@property (nonatomic, strong) UIButton *loginButton;

@end

@implementation LoginCell

- (UIImageView*)loginImageView {
    if (!_loginImageView) {
        _loginImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _loginImageView.translatesAutoresizingMaskIntoConstraints = NO;
        _loginImageView.contentMode = UIViewContentModeScaleAspectFill;
        _loginImageView.image = [UIImage imageNamed:@"logo"];
    }
    return _loginImageView;
}

- (LeftPaddingTextField*)emailTextField {
    if (!_emailTextField) {
        _emailTextField = [[LeftPaddingTextField alloc] initWithFrame:CGRectZero];
        _emailTextField.translatesAutoresizingMaskIntoConstraints = NO;
        _emailTextField.borderStyle = UITextBorderStyleNone;
        _emailTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _emailTextField.layer.borderWidth = 1.f;
        _emailTextField.placeholder = @"Email";
        _emailTextField.keyboardType = UIKeyboardTypeEmailAddress;
    }
    return _emailTextField;
}

- (LeftPaddingTextField*)passwordTextField {
    if (!_passwordTextField) {
        _passwordTextField = [[LeftPaddingTextField alloc] initWithFrame:CGRectZero];
        _passwordTextField.translatesAutoresizingMaskIntoConstraints = NO;
        _passwordTextField.borderStyle = UITextBorderStyleNone;
        _passwordTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _passwordTextField.layer.borderWidth = 1.f;
        _passwordTextField.placeholder = @"Password";
        _passwordTextField.secureTextEntry = YES;
    }
    return _passwordTextField;
}

- (UIButton*)loginButton {
    if (!_loginButton) {
        _loginButton = [[UIButton alloc] initWithFrame:CGRectZero];
        _loginButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_loginButton setTitle:@"Login" forState:UIControlStateNormal];
        [_loginButton setBackgroundColor:[UIColor colorWithRed:247/255.0 green:154/255.0 blue:27/255.0 alpha:1.0]];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    // add subviews
    [self addSubview:self.loginImageView];
    [self addSubview:self.emailTextField];
    [self addSubview:self.passwordTextField];
    [self addSubview:self.loginButton];
    
    // add constraints
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self).insets(UIEdgeInsetsMake(0, 16, 0, 16));
        make.centerY.equalTo(self);
        make.height.equalTo(@40);
    }];
    
    [self.emailTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.passwordTextField.mas_top).offset(-15);
        make.height.equalTo(@40);
        make.left.and.right.equalTo(self).insets(UIEdgeInsetsMake(0, 16, 0, 16));
    }];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordTextField.mas_bottom).offset(15);
        make.height.equalTo(@40);
        make.left.and.right.equalTo(self).insets(UIEdgeInsetsMake(0, 16, 0, 16));
    }];
    
    [self.loginImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@150);
        make.height.equalTo(@100);
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.emailTextField.mas_top).offset(-15);
    }];
}

- (void)login {
    
}

@end
