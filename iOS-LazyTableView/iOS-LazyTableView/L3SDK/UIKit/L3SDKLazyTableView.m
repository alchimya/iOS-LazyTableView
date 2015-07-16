//
//  L3SDKLazyTableView.m
//  iOS-LazyTableView
//
//  Created by Domenico Vacchiano on 15/07/15.
//  Copyright (c) 2015 DomenicoVacchiano. All rights reserved.
//

#import "L3SDKLazyTableView.h"
#import "L3SDKUtilityLazyLoad.h"
@interface L3SDKLazyTableView ()
@property (nonatomic,strong)L3SDKUtilityLazyLoad*lazyLoad;
@property(nonatomic, assign) id<L3SDKLazyTableViewDelegate>  senderDelegate;
-(void)inititialize;
@end

@implementation L3SDKLazyTableView
@synthesize lazyLoadEnabled;
@synthesize lazyLoadPageSize;
@synthesize currentCursor;
@dynamic delegate;


#pragma mark init
-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self=[super initWithCoder:aDecoder];
    if (self) {
        [self inititialize];
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self inititialize];
    }
    return self;
}
-(id)init{
    self=[super init];
    if (self) {
        [self inititialize];
    }
    return self;
}
-(void)inititialize{
    [super setDelegate:(id)self];
    self.lazyLoad=[[L3SDKUtilityLazyLoad alloc] init];
}
#pragma mark custom setter properties
-(void)setLazyLoadEnabled:(BOOL)isEnabled{
    self.lazyLoad.isEnabled=isEnabled;
}
-(void)setLazyLoadPageSize:(int)pageSize{
    self.lazyLoad.pageSize=pageSize;
}

#pragma mark delegation
- (void)setDelegate:(id)newDelegate {
    //wraps and set super.delegate
    [super setDelegate:nil];
    _senderDelegate = newDelegate;
    [super setDelegate:(id)self];
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    //returns proper delegate/selector
    if ([_senderDelegate respondsToSelector:aSelector]) { return _senderDelegate; }
    return [super forwardingTargetForSelector:aSelector];
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    return [super respondsToSelector:aSelector] || [_senderDelegate respondsToSelector:aSelector];
}

#pragma mark table scroll view override
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    float endScrolling = scrollView.contentOffset.y + scrollView.frame.size.height;
    
    if (endScrolling >= scrollView.contentSize.height){
        //send event with next lazy load cursor if scroll is at the bottom
        if (self.senderDelegate!= NULL && [self.senderDelegate respondsToSelector:@selector(tableView:lazyLoadNextCursor:)]) {
            [self.senderDelegate  tableView:self lazyLoadNextCursor:self.lazyLoad.nextCursor];
            currentCursor=self.lazyLoad.currentCursor;
        }
    }
}


@end
