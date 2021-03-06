//
//  main.m
//  jt
//
//  Created by Johnson on 2017/5/16.
//  Copyright © 2017年 Johnson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommandTools.h"
#import "CommandManager.h"
#import "Test.h"





void config(NSArray *arrayArguments)
{
    NSString *commandPath = @"/usr/local/bin/jt";
    
    //编译时 始终复制一份 （把jt命令行复制到commandPath，并添加执行权限）
    if(![arrayArguments.firstObject isEqualToString:commandPath])
    {
        [CommandTools excuteCommandLine:@"/bin/chmod" arguments:@[@"o+rwx", @"/usr/local/bin/"]];
        [CommandTools excuteCommandLine:@"/bin/cp" arguments:@[arrayArguments.firstObject, commandPath]];
        [CommandTools excuteCommandLine:@"/bin/chmod" arguments:@[@"o+x", @"/usr/local/bin/jt"]];
    }
    
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSArray *arrayArguments = [[NSProcessInfo processInfo] arguments];
        
        config(arrayArguments);
        
        [CommandManager excuteWithArguments:arrayArguments];
        
#ifdef DEBUG
        [Test testWithArguments:arrayArguments];
#endif
        
    }
    return 0;
}
