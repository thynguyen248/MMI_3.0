//
//  FileSystemImpl.m
//  MeeMeepMobile
//
//  Created by Aydan Bedingham on 10/04/12.
//  Copyright (c) 2012 Unico Computer Systems. All rights reserved.
//

#import "FileSystemImpl.h"

@implementation FileSystemImpl


-(BOOL) saveAccessToken: (MMRestAccessToken*) accessToken{
    if (!accessToken) @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"access token was nil" userInfo:nil];
    
    //Access token exists
    NSString * path = [self pathForDataFile];
        
    NSMutableDictionary * rootObject;
    rootObject = [NSMutableDictionary dictionary];
        
    [rootObject setValue: accessToken.userId forKey:@"userId"];
    [rootObject setValue: accessToken.accessToken forKey:@"accessToken"];
        
    return [NSKeyedArchiver archiveRootObject: rootObject toFile: path];
}



-(MMRestAccessToken*) loadAccessToken{
    NSString *path = [self pathForDataFile];
    
    NSDictionary * rootObject;
    rootObject = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    if (rootObject){
        //an acccess token has been saved
        MMRestAccessToken* accessToken = [[MMRestAccessToken alloc] init];
        accessToken.userId = [rootObject valueForKey:@"userId"];
        accessToken.accessToken = [rootObject valueForKey:@"accessToken"];
        return accessToken;
    } else return nil; //No saved token
}




-(void) deleteAccessToken{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager removeItemAtPath:[self pathForDataFile] error:NULL]==false)
        [NSException exceptionWithName:@"Error" reason:@"Could not delete access token file - probably doesnt exist" userInfo:nil];
    

}



// Path to access token save data
- (NSString *) pathForDataFile {
    NSArray*	documentDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString*	path = nil;
 	
    if (documentDir) {
        path = [documentDir objectAtIndex:0];    
    }
    return [NSString stringWithFormat:@"%@/%@", path, @"Credentials.bin"];
}




@end
