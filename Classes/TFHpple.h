
#import <Foundation/Foundation.h>

#import "TFHppleElement.h"

@interface TFHpple : NSObject {
  NSData * data;
  BOOL isXML;
}

- (id) initWithData:(NSData *)theData isXML:(BOOL)isDataXML;
- (id) initWithHTMLData:(NSData *)theData;
- (id) initWithXMLData:(NSData *)theData;
- (NSArray *) search:(NSString *)xPathOrCSS;
- (TFHppleElement *) at:(NSString *)xPathOrCSS;

@property (retain) NSData * data;

@end
