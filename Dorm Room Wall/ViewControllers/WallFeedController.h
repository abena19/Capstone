//
//  WallFeedController.h
//  Dorm Room Wall
//
//  Created by Abena Ofosu on 7/6/22.
//

#import <UIKit/UIKit.h>
#import "ComposeViewController.h"
#import "Constants.h"

NS_ASSUME_NONNULL_BEGIN

@interface WallFeedController : UIViewController <UITableViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *wallArray;
@property (weak, nonatomic) IBOutlet UITableView *wallFeedTableView;
@property (nonatomic) NSInteger *didPost;


@end

NS_ASSUME_NONNULL_END
