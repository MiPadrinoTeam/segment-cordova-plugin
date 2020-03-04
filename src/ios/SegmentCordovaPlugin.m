#import "SegmentCordovaPlugin.h"

@implementation SegmentCordovaPlugin

- (void)pluginInitialize {
}

- (void)startWithConfiguration:(CDVInvokedUrlCommand *)command {
  CDVPluginResult *pluginResult = nil;
  NSString *key = nil;

  if ([command.arguments count] > 0) {
    key = [command.arguments objectAtIndex:0];
  }

  if (key != nil && [key length] > 0) {
    SEGAnalyticsConfiguration *config =
        [SEGAnalyticsConfiguration configurationWithWriteKey:key];

    [config use:[SEGAppsFlyerIntegrationFactory instance]];
    [config use:[SEGUrbanAirshipIntegrationFactory instance]];

    config.enableAdvertisingTracking = YES;
    config.trackApplicationLifecycleEvents = YES;
    config.trackDeepLinks = YES;
    config.trackPushNotifications = YES;
    config.trackAttributionData = YES;

    [SEGAnalytics debug:YES];

    [SEGAnalytics setupWithConfiguration:config];

    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
  } else {
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR
                                     messageAsString:@"Key is required."];
  }

  [self.commandDelegate sendPluginResult:pluginResult
                              callbackId:command.callbackId];
}

- (void)identify:(CDVInvokedUrlCommand *)command {
  CDVPluginResult *pluginResult = nil;

  NSDictionary *inputs = nil;
  NSString *userId = nil;
  NSDictionary *traits = nil;
  NSDictionary *options = nil;

  if ([command.arguments count] > 0) {
    inputs = [command.arguments objectAtIndex:0];
    if (![inputs isEqual:[NSNull null]]) {
      userId = [inputs objectForKey:@"userId"];
      traits = [inputs objectForKey:@"traits"];
      options = [inputs objectForKey:@"options"];
    }
  }

  [[SEGAnalytics sharedAnalytics] identify:userId
                                    traits:traits
                                   options:options];

  pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];

  [self.commandDelegate sendPluginResult:pluginResult
                              callbackId:command.callbackId];
}

- (void)track:(CDVInvokedUrlCommand *)command {
  CDVPluginResult *pluginResult = nil;

  NSDictionary *inputs = nil;
  NSString *event = nil;
  NSDictionary *properties = nil;
  NSDictionary *options = nil;

  if ([command.arguments count] > 0) {
    inputs = [command.arguments objectAtIndex:0];
    if (![inputs isEqual:[NSNull null]]) {
      event = [inputs objectForKey:@"event"];
      properties = [inputs objectForKey:@"properties"];
      options = [inputs objectForKey:@"options"];
    }
  }

  if (event != nil) {

    [[SEGAnalytics sharedAnalytics] track:event
                               properties:properties
                                  options:options];

    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
  } else {
    pluginResult = [CDVPluginResult
        resultWithStatus:CDVCommandStatus_ERROR
         messageAsString:@"The name of the event is required."];
  }

  [self.commandDelegate sendPluginResult:pluginResult
                              callbackId:command.callbackId];
}

- (void)screen:(CDVInvokedUrlCommand *)command {
  CDVPluginResult *pluginResult = nil;

  NSDictionary *inputs = nil;
  NSString *name = nil;
  NSDictionary *properties = nil;
  NSDictionary *options = nil;

  if ([command.arguments count] > 0) {
    inputs = [command.arguments objectAtIndex:0];
    if (![inputs isEqual:[NSNull null]]) {
      name = [inputs objectForKey:@"name"];
      properties = [inputs objectForKey:@"properties"];
      options = [inputs objectForKey:@"options"];
    }
  }

  if (name != nil) {
    [[SEGAnalytics sharedAnalytics] screen:name
                                properties:properties
                                   options:options];

    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
  } else {
    pluginResult = [CDVPluginResult
        resultWithStatus:CDVCommandStatus_ERROR
         messageAsString:@"The name of the screen is required."];
  }

  [self.commandDelegate sendPluginResult:pluginResult
                              callbackId:command.callbackId];
}

- (void)group:(CDVInvokedUrlCommand *)command {
  CDVPluginResult *pluginResult = nil;

  NSDictionary *inputs = nil;
  NSString *groupId = nil;
  NSDictionary *traits = nil;
  NSDictionary *options = nil;

  if ([command.arguments count] > 0) {
    inputs = [command.arguments objectAtIndex:0];
    if (![inputs isEqual:[NSNull null]]) {
      groupId = [inputs objectForKey:@"groupId"];
      traits = [inputs objectForKey:@"traits"];
      options = [inputs objectForKey:@"options"];
    }
  }

  if (groupId != nil) {
    [[SEGAnalytics sharedAnalytics] group:groupId
                                   traits:traits
                                  options:options];

    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
  } else {
    pluginResult = [CDVPluginResult
        resultWithStatus:CDVCommandStatus_ERROR
         messageAsString:@"The database ID for this group is required."];
  }

  [self.commandDelegate sendPluginResult:pluginResult
                              callbackId:command.callbackId];
}

- (void)alias:(CDVInvokedUrlCommand *)command {
  CDVPluginResult *pluginResult = nil;

  NSDictionary *inputs = nil;
  NSString *newId = nil;
  NSDictionary *options = nil;

  if ([command.arguments count] > 0) {
    inputs = [command.arguments objectAtIndex:0];
    if (![inputs isEqual:[NSNull null]]) {
      newId = [inputs objectForKey:@"newId"];
      options = [inputs objectForKey:@"options"];
    }
  }

  if (newId != nil) {
    [[SEGAnalytics sharedAnalytics] alias:newId options:options];

    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
  } else {
    pluginResult = [CDVPluginResult
        resultWithStatus:CDVCommandStatus_ERROR
         messageAsString:@"The newId of the user to alias is required."];
  }

  [self.commandDelegate sendPluginResult:pluginResult
                              callbackId:command.callbackId];
}

- (void)getAnonymousId:(CDVInvokedUrlCommand *)command {
  CDVPluginResult *pluginResult = nil;

  NSString *anonymousId = [[SEGAnalytics sharedAnalytics] getAnonymousId];

  pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK
                                   messageAsString:anonymousId];

  [self.commandDelegate sendPluginResult:pluginResult
                              callbackId:command.callbackId];
}

- (void)reset:(CDVInvokedUrlCommand *)command {
  CDVPluginResult *pluginResult = nil;

  [[SEGAnalytics sharedAnalytics] reset];

  pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];

  [self.commandDelegate sendPluginResult:pluginResult
                              callbackId:command.callbackId];
}

@end
