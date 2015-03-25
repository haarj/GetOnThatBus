//
//  BusStops.h
//  GetOnThatBus
//
//  Created by Justin Haar on 3/24/15.
//  Copyright (c) 2015 Justin Haar. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BusStops <NSObject>
@required
-(void)busStops:(NSArray *)busStops;

@end

@interface BusStops : NSObject

@property id<BusStops>delegate;

@property NSNumber *latitude;
@property NSNumber *longitude;
@property NSString *name;
@property NSString *routes;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
+(NSArray *)busStopsArrayFromDictionaryArray:(NSArray *)dictArray;
-(void)pullBusStopsFromApi;

@end
