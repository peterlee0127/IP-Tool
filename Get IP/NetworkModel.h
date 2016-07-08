//
//  NetworkModel.h
//  TKU-WiFi
//
//  Created by Peterlee on 7/26/14.
//  Copyright (c) 2014 Peterlee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkModel : NSObject


+(NSString *) getSSID;
+ (NSString *)getWiFiIPAddress;
+ (NSString *)getCellularIPAddress;

@end
