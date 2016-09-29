//
//  Page.m
//  Audible
//
//  Created by Doan Dat on 9/29/16.
//  Copyright (c) 2016 Doan Dat. All rights reserved.
//

#import "Page.h"

@implementation Page

- (instancetype)initWithTitle:(NSString*)title message:(NSString*)message imageName:(NSString*)imageName {
    if (self = [super init]) {
        _title = title;
        _message = message;
        _imageName = imageName;
    }
    return self;
}
@end
