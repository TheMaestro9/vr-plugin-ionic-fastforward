//
//  VrView.m
//  GoogleVrViewTest
//
//  Created by Leonardo Tonghini on 12/05/17.
//  Copyright © 2017 Leonardo Tonghini. All rights reserved.
//

#import "VrView.h"
#import "VideoVrVC.h"
#import "PanoramaVrVC.h"

@implementation VrView

- (void)playVideo:(CDVInvokedUrlCommand *)command {
    NSString *videoUrl = [command.arguments objectAtIndex:0];
    NSString *inputType = [command.arguments objectAtIndex:1];

    VideoVrVC *videoController = [[VideoVrVC alloc] init];
    videoController.videoURL = [NSURL URLWithString:videoUrl];
    if(![inputType isEqual:[NSNull null]]) {
        int videoTypeInt = inputType.intValue;
        videoController.videoType = videoTypeInt;
    }

    [self.viewController presentViewController:videoController animated:YES completion:NULL];
}

- (void)playVideoFromAppFolder:(CDVInvokedUrlCommand *)command {
    NSString *videoUrl = [command.arguments objectAtIndex:0];
    NSString *inputType = [command.arguments objectAtIndex:1];

    NSURL *localUrl = [self getLocalResourceUrl:videoUrl];
    VideoVrVC *videoController = [[VideoVrVC alloc] init];
    videoController.videoURL = localUrl;
    if(![inputType isEqual:[NSNull null]]) {
        int videoTypeInt = inputType.intValue;
        videoController.videoType = videoTypeInt;
    }

    [self.viewController presentViewController:videoController animated:YES completion:NULL];
}

-(void)showPhoto:(CDVInvokedUrlCommand *)command {
    NSString *panoUrl = [command.arguments objectAtIndex:0];
    NSString *inputType = [command.arguments objectAtIndex:1];

    PanoramaVrVC *panoController = [[PanoramaVrVC alloc] init];
    panoController.panoramaURL = [NSURL URLWithString:panoUrl];

    if(![inputType isEqual:[NSNull null]]) {
        int panoTypeInt = inputType.intValue;
        panoController.panoramaType = panoTypeInt;
    }

    [self.viewController presentViewController:panoController animated:YES completion:NULL];
}

-(void)showPhotoFromAppFolder:(CDVInvokedUrlCommand *)command {
    NSString *panoUrl = [command.arguments objectAtIndex:0];
    NSString *inputType = [command.arguments objectAtIndex:1];

    NSURL *localUrl = [self getLocalResourceUrl:panoUrl];
    PanoramaVrVC *panoController = [[PanoramaVrVC alloc] init];
    panoController.panoramaURL = localUrl;

    if(![inputType isEqual:[NSNull null]]) {
        int panoTypeInt = inputType.intValue;
        panoController.panoramaType = panoTypeInt;
    }

    [self.viewController presentViewController:panoController animated:YES completion:NULL];
}

-(void)isDeviceSupported:(CDVInvokedUrlCommand *)command {
    CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:YES];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

-(NSURL *)getLocalResourceUrl:(NSString *)stringPath {
    if (stringPath != nil && stringPath.length > 0) {
        #ifdef __CORDOVA_4_0_0
            NSURL* baseUrl = [self.webViewEngine URL];
        #else
            NSURL* baseUrl = [self.webView.request URL];
        #endif
        NSURL* absoluteURL = [[NSURL URLWithString:stringPath relativeToURL:baseUrl] absoluteURL];

        if ([[NSFileManager defaultManager] fileExistsAtPath:absoluteURL.path]) {
            return absoluteURL;
        }
    }
    return nil;
}

@end
