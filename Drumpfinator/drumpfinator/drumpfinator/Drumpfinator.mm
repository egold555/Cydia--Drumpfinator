#import <Preferences/Preferences.h>

@interface DrumpfinatorListController: PSListController {
}
@end

@implementation DrumpfinatorListController
- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Drumpfinator" target:self] retain];
	}
	return _specifiers;
}
-(void)respring {

         system("killall -9 SpringBoard");

      }
-(void)urlweb {

         system("uiopen http://eric.golde.org");

      }
-(void)urlgit {

         system("uiopen http://github.com");

      }
@end

// vim:ft=objc
