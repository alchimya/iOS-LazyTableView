//
//  L3SDKLazyTableView.h
//  iOS-LazyTableView
//
//  Created by Domenico Vacchiano on 15/07/15.
//  Copyright (c) 2015 DomenicoVacchiano. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//UITableViewDelegate extension
@protocol L3SDKLazyTableViewDelegate<UITableViewDelegate>
@optional
//it will be raised when scroll will be at the bottom
- (void)tableView:(UITableView *)tableView lazyLoadNextCursor:(int)cursor;
@end


@interface L3SDKLazyTableView : UITableView
//it allows to enable/disble lazye load
@property (nonatomic,assign)BOOL lazyLoadEnabled;
//gets/sets lazy load page size
@property (nonatomic,assign)int lazyLoadPageSize;
//gets last lazy load cursor
@property (nonatomic,assign,readonly)int currentCursor;
//class delegate
@property(nonatomic, assign) id<L3SDKLazyTableViewDelegate> delegate;
@end

