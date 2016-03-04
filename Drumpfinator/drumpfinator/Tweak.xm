/* How to Hook with Logos
Hooks are written with syntax similar to that of an Objective-C @implementation.
You don't need to #include <substrate.h>, it will be done automatically, as will
the generation of a class list and an automatic constructor.

%hook ClassName

// Hooking a class method
+ (id)sharedInstance {
	return %orig;
}

// Hooking an instance method with an argument.
- (void)messageName:(int)argument {
	%log; // Write a message about this call, including its class, name and arguments, to the system log.

	%orig; // Call through to the original function with its original arguments.
	%orig(nil); // Call through to the original function with a custom argument.

	// If you use %orig(), you MUST supply all arguments (except for self and _cmd, the automatically generated ones.)
}

// Hooking an instance method with no arguments.
- (id)noArguments {
	%log;
	id awesome = %orig;
	[awesome doSomethingElse];

	return awesome;
}

// Always make sure you clean up after yourself; Not doing so could have grave consequences!
%end
*/
static BOOL kEnabled = YES;


%hook UILabel


-(void)setText:(NSString *)arg1
{
	if(kEnabled){
		arg1 = [arg1 stringByReplacingOccurrencesOfString:@"Trump" withString:@"Drumpf" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [arg1 length])];
			}
	%orig(arg1);
}
%end


%hook SBApplication
-(void)setDisplayName:(id)arg1
{
	if(kEnabled){
		arg1 = [arg1 stringByReplacingOccurrencesOfString:@"Trump" withString:@"Drumpf" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [arg1 length])];
	}
	%orig(arg1);
}
%end


%hook SBBookmarkIcon
-(void) setDisplayName:(id)arg1
{
	if(kEnabled){
		arg1 = [arg1 stringByReplacingOccurrencesOfString:@"Trump" withString:@"Drumpf" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [arg1 length])];
	}
	%orig(arg1);
}
%end


%hook SBNewsstandFolder 
-(void) setDisplayName:(id)arg1
{
	if(kEnabled){
		arg1 = [arg1 stringByReplacingOccurrencesOfString:@"Trump" withString:@"Drumpf" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [arg1 length])];
	}
	%orig(arg1);
}
%end


%hook SBFolder 
-(void) setDisplayName:(id)arg1
{
	if(kEnabled){
		arg1 = [arg1 stringByReplacingOccurrencesOfString:@"Trump" withString:@"Drumpf" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [arg1 length])];
	}
	%orig(arg1);
}
%end

%hook CKTranscriptLabelCell

-(void)setLabel:(UILabel *)arg1
{
	if(kEnabled){
		arg1.text = [arg1.text stringByReplacingOccurrencesOfString:@"Trump" withString:@"Drumpf" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [arg1.text length])];

	}
	%orig(arg1);
}

%end

%hook UITextView

-(void)setText:(NSString *)arg1
{
	if(kEnabled){
		arg1 = [arg1 stringByReplacingOccurrencesOfString:@"Trump" withString:@"Drumpf" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [arg1 length])];
	
	}
	%orig(arg1);
}

%end

static void loadPrefs() {

       NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/private/var/mobile/Library/Preferences/org.golde.cydia.drumpfinator.plist"];
    if(prefs)
    {
        kEnabled = ([prefs objectForKey:@"isEnabled"] ? [[prefs objectForKey:@"isEnabled"] boolValue] : kEnabled);
    }
    [prefs release];
}

static void settingschanged(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo){
    loadPrefs();
}

%ctor{

    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, settingschanged, CFSTR("org.golde.cydia.drumpfinator.plist/settingschanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
    loadPrefs();
}
