//
//  FSData.h
//  FSCoreData
//
//  Created by Hari Krishna Palempati on 3/07/15.
//  Copyright (c) 2015 Hari Krishna Palempati. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface FSData : NSManagedObject

@property (nonatomic, retain) NSString * userName;
@property (nonatomic, retain) NSString * userID;
@property (nonatomic, retain) NSData * pictureData;
@property (nonatomic, retain) NSString * imageUrl;

@end
