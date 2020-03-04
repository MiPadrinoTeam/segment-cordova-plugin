#import <Analytics/SEGAnalytics.h>
#import <Cordova/CDV.h>
#import <Foundation/Foundation.h>
// #import "SEGAppsFlyerIntegrationFactory.h"
// #import "SEGUrbanAirshipIntegrationFactory.h"

@interface SegmentCordovaPlugin : CDVPlugin
{
  // Member variables go here.
}

- (void)startWithConfiguration:(CDVInvokedUrlCommand *)command;
- (void)identify:(CDVInvokedUrlCommand *)command;
- (void)track:(CDVInvokedUrlCommand *)command;
- (void)screen:(CDVInvokedUrlCommand *)command;
- (void)group:(CDVInvokedUrlCommand *)command;
- (void)alias:(CDVInvokedUrlCommand *)command;
- (void)getAnonymousId:(CDVInvokedUrlCommand *)command;
- (void)reset:(CDVInvokedUrlCommand *)command;

@end
