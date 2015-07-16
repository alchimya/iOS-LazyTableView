# iOS-LazyTableView
A subclass of the UITableView with an easy lazy loading (infinite scroll) implementation.

# How to use
With this UITbaleView subclass, you can implement, in a very easy way, a table view with a lazy loading system when the table view is scrolling down.
<br/>
To do this you have to implement your UITableView, by using the L3SDKLazyTableView class.
You need just to:
- define your table view instance (by code or by IBOutlet) by using L3SDKLazyTableView class
- set the delegate and implement ```tableView:lazyLoadNextCursor:``` of L3SDKLazyTableViewDelegate

![ScreenShot](https://raw.github.com/alchimya/iOS-LazyTableView/master/screenshots/iOS-LazyTableView.gif)

<br/>
When the scroll will be at the botton, will be raised the ```tableView:lazyLoadNextCursor:``` event, and inside it you can implement
your code to load more data (eg. by adding items to an array, by requesting more data to a remote webservice and so on).
<br/>
See my example for more detail.

```objectivec

....
....
....

@property (weak, nonatomic) IBOutlet L3SDKLazyTableView *lazyTableView;
@property (nonatomic,strong)NSMutableArray*dataSource;

....
....
....

- (void)tableView:(UITableView *)tableView lazyLoadNextCursor:(int)cursor{
    //for instance here you can execute webservice request lo load more data
    [self fetchNewItems];
    [self.lazyTableView reloadData];
}

-(void)fetchNewItems{
    
    //add items to datasource
    NSUInteger count=self.dataSource.count;
    for (int i=0; i<LAZY_LOAD_PAGE_SIZE; i++) {
        [self.dataSource addObject:[NSString stringWithFormat:@"Item - %lu", count+1]];
        count++;
    }
}
```

<br/>
Within this project you will can focus around two classes:

- <b>L3SDKLazyTableView</b>

<h5>properties</h5>

  name                        |     type                    |   description    
------------------------------| ----------------------------|--------------------------------------------------------
lazyLoadEnabled               | BOOL                        | it allows to enable/disble lazye load
lazyLoadPageSize              | int                         | gets or sets lazy load page size
currentCursor                 | int                         | gets last lazy load cursor
delegate                      | L3SDKLazyTableViewDelegate  | gets or sets class delegate

<h5>protocols</h5>

```objectivec
//UITableViewDelegate extension
@protocol L3SDKLazyTableViewDelegate<UITableViewDelegate>
@optional
//it will be raised when scroll will be at the bottom
- (void)tableView:(UITableView *)tableView lazyLoadNextCursor:(int)cursor;
@end
```

- <b>L3SDKLazyLoadUtility</b>
This class allows to track last item index (cursor) loaded by defining a pagse size (quantity of data to load for each request)

<h5>properties</h5>

  name                        |     type                    |   description    
------------------------------| ----------------------------|--------------------------------------------------------
isEnabled                     | BOOL                        | it allows to enable/disble lazye load
pageSize                      | int                         | gets or sets lazy load page size
currentCursor                 | int                         | gets last lazy load cursor

<h5>methods</h5>
  name                  |     type        |   description    
--------------          | ----------------|-------------------------------------------------------------------
initWithPageSize        | id              | factory initialization
nextCursor              | int             | asks to move to next cursor
resetCursor             | void            | reset cursor to -1
