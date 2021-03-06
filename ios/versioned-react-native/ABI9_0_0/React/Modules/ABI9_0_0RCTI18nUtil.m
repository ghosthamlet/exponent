/**
 * Copyright (c) 2015-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#import <Foundation/Foundation.h>

#import "ABI9_0_0RCTI18nUtil.h"

@implementation ABI9_0_0RCTI18nUtil

+ (id)sharedInstance {
   static ABI9_0_0RCTI18nUtil *sharedABI9_0_0RCTI18nUtilInstance = nil;
   @synchronized(self) {
     if (sharedABI9_0_0RCTI18nUtilInstance == nil)
      sharedABI9_0_0RCTI18nUtilInstance = [self new];
   }
   return sharedABI9_0_0RCTI18nUtilInstance;
}

// If current using language is RTL language and meanwhile set allowRTL on the JS side,
// the RN app will automatically have a RTL layout.
- (BOOL)isRTL
{
  if ([self allowRTL] && [self isApplicationPreferredLanguageRTL]) {
    return YES;
  }
  return NO;
}

- (BOOL)allowRTL
{
  BOOL rtlStatus = [[NSUserDefaults standardUserDefaults]
                            boolForKey:@"ABI9_0_0RCTI18nUtil_allowRTL"];
  return rtlStatus;
}

- (void)setAllowRTL:(BOOL)rtlStatus
{
  [[NSUserDefaults standardUserDefaults] setBool:rtlStatus forKey:@"ABI9_0_0RCTI18nUtil_allowRTL"];
  [[NSUserDefaults standardUserDefaults] synchronize];
}

// Check if the current device language is RTL
- (BOOL)isDevicePreferredLanguageRTL
{
  NSLocaleLanguageDirection direction = [NSLocale characterDirectionForLanguage:[[NSLocale preferredLanguages] objectAtIndex:0]];
  return direction == NSLocaleLanguageDirectionRightToLeft;
}

// Check if the current application language is RTL
- (BOOL)isApplicationPreferredLanguageRTL
{
  NSString *preferredAppLanguage = [[[NSBundle mainBundle] preferredLocalizations] objectAtIndex:0];
  NSLocaleLanguageDirection direction = [NSLocale characterDirectionForLanguage:preferredAppLanguage];
  return direction == NSLocaleLanguageDirectionRightToLeft;
}

@end
