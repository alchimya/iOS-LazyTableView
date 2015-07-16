//
//  L3SDKUtilityLazyLoad.h
//  iOS-LazyTableView
//
//  Created by Domenico Vacchiano on 15/07/15.
//  Copyright (c) 2015 DomenicoVacchiano. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface L3SDKUtilityLazyLoad : NSObject

//gets the current cursor value
@property (nonatomic,assign, readonly)int currentCursor;
//gets/sets the enable statusof lazy loading
@property (nonatomic,assign)BOOL isEnabled;
//gets/sets the page size, this number will be added to the currentCursot at each nextCursor invocation
@property (nonatomic,assign)int pageSize;
//factory initialization
-(id)initWithPageSize:(int)pSize andIsEnabled:(BOOL)enabled;
//asks to move to next cursor
-(int)nextCursor;
//reset cursor to -1
-(void)resetCursor;

@end
