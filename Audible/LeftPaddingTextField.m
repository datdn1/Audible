//
//  LeftPaddingTextField.m
//  Audible
//
//  Created by Doan Dat on 9/30/16.
//  Copyright (c) 2016 Doan Dat. All rights reserved.
//

#import "LeftPaddingTextField.h"

#define padding 10
@implementation LeftPaddingTextField

- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectMake(bounds.origin.x + padding, bounds.origin.y, bounds.size.width + padding, bounds.size.height);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectMake(bounds.origin.x + padding, bounds.origin.y, bounds.size.width + padding, bounds.size.height);
}

@end
