//
//  AddRatingManagerBridge.m
//  Mixer
//
//  Created by Duncan Du [MIGOTP] on 2018/1/25.
//  Copyright © 2018年 Razeware LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "React/RCTBridgeModule.h"


@interface RCT_EXTERN_MODULE(AddRatingManager, NSObject)

RCT_EXTERN_METHOD(dismissPresentedViewController:(nonnull NSNumber *)reactTag)

RCT_EXTERN_METHOD(save:(nonnull NSNumber *)reactTag rating:(NSInteger *)rating forIdentifier:(NSInteger *)forIdentifier)
@end
