
#import <Foundation/Foundation.h>


@interface TFHppleElement : NSObject {
  NSDictionary * node;
}

- (id) initWithNode:(NSDictionary *) theNode;

// Returns this tag's innerHTML content.
- (NSString *) content;

// Returns the name of the current tag, such as "h3".
- (NSString *) tagName;

// Returns tag attributes with name as key and content as value.
//   href  = 'http://peepcode.com'
//   class = 'highlight'
- (NSDictionary *) attributes;

// Provides easy access to the content of a specific attribute, 
// such as 'href' or 'class'.
- (NSString *) objectForKey:(NSString *) theKey;

@property(nonatomic,retain) NSDictionary * node;

@end
