//
//  NetworkModel.m
//  TKU-WiFi
//
//  Created by Peterlee on 7/26/14.
//  Copyright (c) 2014 Peterlee. All rights reserved.
//

#import "NetworkModel.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <UIKit/UIKit.h>

#import <NetworkExtension/NEHotspotHelper.h>


@implementation NetworkModel


+(NSString *) getSSID
{
    NSString *currentSSID = @"";
    CFArrayRef myArray = CNCopySupportedInterfaces();
    if (myArray != nil){
        NSDictionary* myDict = (__bridge NSDictionary *) CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(myArray, 0));
        if (myDict!=nil){
            currentSSID=[myDict valueForKey:@"SSID"];
        } else {
            currentSSID=@"nowifi..";
        }
    } else {
        currentSSID=@"nowifi..";
    }
    return currentSSID;
}
+ (NSString *)getWiFiIPAddress
{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {

            if(temp_addr->ifa_addr->sa_family == AF_INET) {
//                NSLog(@"%@",[NSString stringWithUTF8String:temp_addr->ifa_name]);
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
    
}
+ (NSString *) getCellularIPAddress {
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
//                NSLog(@"%@",[NSString stringWithUTF8String:temp_addr->ifa_name]);
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"pdp_ip0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}

@end
