//
//  PageCell.m
//  Audible
//
//  Created by Doan Dat on 9/29/16.
//  Copyright (c) 2016 Doan Dat. All rights reserved.
//

#import "PageCell.h"
#import "Masonry.h"
#import "Page.h"

@interface PageCell ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIView *lineSeperatorView;

@end
@implementation PageCell

- (UIImageView*)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
        _imageView.clipsToBounds = YES;
        _imageView.image = [UIImage imageNamed:@"page1"];
        _imageView.backgroundColor = [UIColor yellowColor];
    }
    return _imageView;
}

- (UITextView*)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] initWithFrame:CGRectZero];
        _textView.translatesAutoresizingMaskIntoConstraints = NO;
        _textView.text = @"SAMPLE TEXT";
        _textView.editable = NO;
        _textView.textAlignment = NSTextAlignmentCenter;
        _textView.contentInset = UIEdgeInsetsMake(24, 0, 0, 0);
    }
    return _textView;
}

- (UIView*)lineSeperatorView {
    if (!_lineSeperatorView) {
        _lineSeperatorView = [[UIView alloc] initWithFrame:CGRectZero];
        _lineSeperatorView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
        _lineSeperatorView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _lineSeperatorView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    [self addSubview:self.imageView];
    [self addSubview:self.textView];
    [self addSubview:self.lineSeperatorView];
    
    // add constraints
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.and.top.equalTo(self);
        make.bottom.equalTo(self.textView.mas_top);
    }];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self).insets(UIEdgeInsetsMake(0, 12, 0, 12));
        make.bottom.equalTo(self);
        make.height.equalTo(self.mas_height).multipliedBy(0.3);
    }];
    
    [self.lineSeperatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textView);
        make.left.and.right.equalTo(self);
        make.height.equalTo(@(1));
    }];
}

- (void)setPage:(Page *)page {
    _page = page;
    self.imageView.image = [UIImage imageNamed:page.imageName];
    
    UIColor *titleColor = [UIColor colorWithWhite:0.2 alpha:1.0];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:page.title attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20 weight:UIFontWeightMedium], NSForegroundColorAttributeName : titleColor}];
    
    NSString *message = [NSString stringWithFormat:@"\n\n%@", page.message];
    NSAttributedString *messageAttribute = [[NSAttributedString alloc] initWithString:message attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14], NSForegroundColorAttributeName : titleColor}];
    [attributeString appendAttributedString:messageAttribute];
    
    NSMutableParagraphStyle *pageStyle = [[NSMutableParagraphStyle alloc] init];
    pageStyle.alignment = NSTextAlignmentCenter;
    
    [attributeString addAttribute:NSParagraphStyleAttributeName value:pageStyle range:NSMakeRange(0, attributeString.length)];
    self.textView.attributedText = attributeString;
}

@end
