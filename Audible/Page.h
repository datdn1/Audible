//
//  Page.h
//  Audible
//
//  Created by Doan Dat on 9/29/16.
//  Copyright (c) 2016 Doan Dat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Page : NSObject

@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *message;

- (instancetype)initWithTitle:(NSString*)title message:(NSString*)message imageName:(NSString*)imageName;

@end
