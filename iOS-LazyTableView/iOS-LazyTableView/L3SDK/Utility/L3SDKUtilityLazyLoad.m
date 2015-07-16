//
//  L3SDKUtilityLazyLoad.m
//  iOS-LazyTableView
//
//  Created by Domenico Vacchiano on 15/07/15.
//  Copyright (c) 2015 DomenicoVacchiano. All rights reserved.
//

#import "L3SDKUtilityLazyLoad.h"


@implementation L3SDKUtilityLazyLoad
@synthesize currentCursor;
@synthesize isEnabled;
@synthesize pageSize;

-(id)initWithPageSize:(int)pSize andIsEnabled:(BOOL)enabled{
    
    self=[super init];
    if (self) {
        self.pageSize=pSize;
        self.isEnabled=enabled;
    }
    return self;
    
}
-(int)nextCursor{
    
    if (!self.isEnabled) {
        return -1;
    }
    
    if (self.currentCursor==-1) {
        currentCursor= 0;
    }
    else if (self.currentCursor==0) {
        currentCursor=self.pageSize;
    }else{
        currentCursor+=self.pageSize;
    }
    return self.currentCursor;

}

-(void)resetCursor{
    currentCursor=-1;
}

@end
