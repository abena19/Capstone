//
//  ParseQueryManager.h
//  Dorm Room Wall
//
//  Created by Abena Ofosu on 7/20/22.
//

#import <Foundation/Foundation.h>
#import "Wall.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ParseQueryManagerDelegate

- (void) outOfLikes;

@end

@interface ParseQueryManager : NSObject

@property (nonatomic, weak) id<ParseQueryManagerDelegate> delegate;

+ (instancetype)shared;

- (void) fetchWalls:(NSInteger)fetchMethod withCompletion:(void(^)(NSArray *feedWalls, NSError *error))completion;
- (void)updateLike:(Wall *)wall withCompletion:(void (^)(Wall *wall, NSError *error))completion;

typedef NS_ENUM(NSInteger , cacheState) {
    QueryDefaultState = 1,
    QueryNetworkState = 2,
};

@end

NS_ASSUME_NONNULL_END
