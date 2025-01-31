//
//  Wall.m
//  Dorm Room Wall
//
//  Created by Abena Ofosu on 7/6/22.
//

#import "Wall.h"
#import <Parse/Parse.h>


@implementation Wall

@dynamic wallID;
@dynamic userID;
@dynamic author;
@dynamic caption;
@dynamic dormAddress;
@dynamic locationImage;
@dynamic lectureImage;
@dynamic mealImage;
@dynamic usersLikeDictionary;


+ (nonnull NSString *)parseClassName {
    return wallString;
}


+ (Wall *)  postWallImage: (NSMutableArray *)imageArray withAddress:( NSString * _Nullable )dormLocation withCaption: ( NSString * _Nullable )caption withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    Wall *newWall = [Wall new];
    newWall.locationImage = [self getPFFileFromImage:imageArray[0]];
    newWall.lectureImage = [self getPFFileFromImage:imageArray[1]];
    newWall.mealImage = [self getPFFileFromImage:imageArray[2]];
    newWall.author = [PFUser currentUser];
    newWall.caption = caption;
    newWall.dormAddress = dormLocation;
    newWall.usersLikeDictionary = [[NSMutableDictionary<NSString*, NSString*> alloc] init];
    [newWall saveInBackgroundWithBlock: completion];
    return newWall;
}

+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image {
    // check if image is not nil
    if (!image) {
        return nil;
    }
    NSData *imageData = UIImagePNGRepresentation(image);
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }
    return [PFFileObject fileObjectWithName:imageString data:imageData];
}



- (void) likeObjectWithCompletion:(void (^)(BOOL succeeded, NSError *error))completion {
    [[ParseQueryManager shared] updateLike:self withObjectClass:self.class withCompletion:completion];
}


- (BOOL) canLikeObject {
    NSString *authorId = [[PFUser currentUser] valueForKey:objectIdString];
    return ![self.author.objectId isEqual:authorId];
}


@end
