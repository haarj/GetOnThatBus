//
//  BusStops.m
//  GetOnThatBus
//
//  Created by Justin Haar on 3/24/15.
//  Copyright (c) 2015 Justin Haar. All rights reserved.
//

#import "BusStops.h"

@implementation BusStops

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    self.latitude = [dictionary objectForKey:@"latitude"];
    self.longitude = [dictionary objectForKey:@"longitude"];
    self.name = [dictionary objectForKey:@"cta_stop_name"];
    self.routes = [dictionary objectForKey:@"routes"];
    NSLog(@"The bus stop is %@", self.name);

    return self;
}


+(NSArray *)busStopsArrayFromDictionaryArray:(NSArray *)dictArray
{
    NSMutableArray *muteArray = [NSMutableArray new];
    for (NSDictionary *dict in dictArray)
    {
        BusStops *busStop = [[BusStops alloc]initWithDictionary:dict];
        [muteArray addObject:busStop];
    }
    return [NSArray arrayWithArray:muteArray];
}


-(void)pullBusStopsFromApi
{
    NSURL *url = [NSURL URLWithString:@"https://s3.amazonaws.com/mobile-makers-lib/bus.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSDictionary *row = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];

        NSArray *results = [BusStops busStopsArrayFromDictionaryArray:row[@"row"]];
        [self.delegate busStops:results];
    }];
}
@end
