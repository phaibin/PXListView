//
//  MyView.m
//  PXListView
//
//  Created by  on 11-9-30.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "MyView.h"

@implementation MyView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
}

- (void)resizeWithOldSuperviewSize:(NSSize)oldBoundsSize
{
    [super resizeWithOldSuperviewSize:oldBoundsSize];
    [[NSNotificationCenter defaultCenter] postNotificationName:LISTVIEW_RESIZED_NOTIFICATION object:nil];
}

@end
