//
//  Generated by the J2ObjC translator.  DO NOT EDIT!
//  source: joda-time/src/main/java/org/joda/time/tz/FixedDateTimeZone.java
//

#include "J2ObjC_source.h"
#include "java/util/SimpleTimeZone.h"
#include "java/util/TimeZone.h"
#include "org/joda/time/DateTimeZone.h"
#include "org/joda/time/tz/FixedDateTimeZone.h"

@interface OrgJodaTimeTzFixedDateTimeZone () {
 @public
  NSString *iNameKey_;
  jint iWallOffset_;
  jint iStandardOffset_;
}

@end

J2OBJC_FIELD_SETTER(OrgJodaTimeTzFixedDateTimeZone, iNameKey_, NSString *)

inline jlong OrgJodaTimeTzFixedDateTimeZone_get_serialVersionUID();
#define OrgJodaTimeTzFixedDateTimeZone_serialVersionUID -3513011772763289092LL
J2OBJC_STATIC_FIELD_CONSTANT(OrgJodaTimeTzFixedDateTimeZone, serialVersionUID, jlong)

@implementation OrgJodaTimeTzFixedDateTimeZone

- (instancetype)initWithNSString:(NSString *)id_
                    withNSString:(NSString *)nameKey
                         withInt:(jint)wallOffset
                         withInt:(jint)standardOffset {
  OrgJodaTimeTzFixedDateTimeZone_initWithNSString_withNSString_withInt_withInt_(self, id_, nameKey, wallOffset, standardOffset);
  return self;
}

- (NSString *)getNameKeyWithLong:(jlong)instant {
  return iNameKey_;
}

- (jint)getOffsetWithLong:(jlong)instant {
  return iWallOffset_;
}

- (jint)getStandardOffsetWithLong:(jlong)instant {
  return iStandardOffset_;
}

- (jint)getOffsetFromLocalWithLong:(jlong)instantLocal {
  return iWallOffset_;
}

- (jboolean)isFixed {
  return true;
}

- (jlong)nextTransitionWithLong:(jlong)instant {
  return instant;
}

- (jlong)previousTransitionWithLong:(jlong)instant {
  return instant;
}

- (JavaUtilTimeZone *)toTimeZone {
  NSString *id_ = [self getID];
  if (((jint) [((NSString *) nil_chk(id_)) length]) == 6 && ([id_ hasPrefix:@"+"] || [id_ hasPrefix:@"-"])) {
    return JavaUtilTimeZone_getTimeZoneWithNSString_(JreStrcat("$$", @"GMT", [self getID]));
  }
  return create_JavaUtilSimpleTimeZone_initWithInt_withNSString_(iWallOffset_, [self getID]);
}

- (jboolean)isEqual:(id)obj {
  if (self == obj) {
    return true;
  }
  if ([obj isKindOfClass:[OrgJodaTimeTzFixedDateTimeZone class]]) {
    OrgJodaTimeTzFixedDateTimeZone *other = (OrgJodaTimeTzFixedDateTimeZone *) cast_chk(obj, [OrgJodaTimeTzFixedDateTimeZone class]);
    return [((NSString *) nil_chk([self getID])) isEqual:[((OrgJodaTimeTzFixedDateTimeZone *) nil_chk(other)) getID]] && iStandardOffset_ == other->iStandardOffset_ && iWallOffset_ == other->iWallOffset_;
  }
  return false;
}

- (NSUInteger)hash {
  return ((jint) [((NSString *) nil_chk([self getID])) hash]) + 37 * iStandardOffset_ + 31 * iWallOffset_;
}

- (void)dealloc {
  RELEASE_(iNameKey_);
  [super dealloc];
}

+ (const J2ObjcClassInfo *)__metadata {
  static const J2ObjcMethodInfo methods[] = {
    { "initWithNSString:withNSString:withInt:withInt:", "FixedDateTimeZone", NULL, 0x1, NULL, NULL },
    { "getNameKeyWithLong:", "getNameKey", "Ljava.lang.String;", 0x1, NULL, NULL },
    { "getOffsetWithLong:", "getOffset", "I", 0x1, NULL, NULL },
    { "getStandardOffsetWithLong:", "getStandardOffset", "I", 0x1, NULL, NULL },
    { "getOffsetFromLocalWithLong:", "getOffsetFromLocal", "I", 0x1, NULL, NULL },
    { "isFixed", NULL, "Z", 0x1, NULL, NULL },
    { "nextTransitionWithLong:", "nextTransition", "J", 0x1, NULL, NULL },
    { "previousTransitionWithLong:", "previousTransition", "J", 0x1, NULL, NULL },
    { "toTimeZone", NULL, "Ljava.util.TimeZone;", 0x1, NULL, NULL },
    { "isEqual:", "equals", "Z", 0x1, NULL, NULL },
    { "hash", "hashCode", "I", 0x1, NULL, NULL },
  };
  static const J2ObjcFieldInfo fields[] = {
    { "serialVersionUID", "serialVersionUID", 0x1a, "J", NULL, NULL, .constantValue.asLong = OrgJodaTimeTzFixedDateTimeZone_serialVersionUID },
    { "iNameKey_", NULL, 0x12, "Ljava.lang.String;", NULL, NULL, .constantValue.asLong = 0 },
    { "iWallOffset_", NULL, 0x12, "I", NULL, NULL, .constantValue.asLong = 0 },
    { "iStandardOffset_", NULL, 0x12, "I", NULL, NULL, .constantValue.asLong = 0 },
  };
  static const J2ObjcClassInfo _OrgJodaTimeTzFixedDateTimeZone = { 2, "FixedDateTimeZone", "org.joda.time.tz", NULL, 0x11, 11, methods, 4, fields, 0, NULL, 0, NULL, NULL, NULL };
  return &_OrgJodaTimeTzFixedDateTimeZone;
}

@end

void OrgJodaTimeTzFixedDateTimeZone_initWithNSString_withNSString_withInt_withInt_(OrgJodaTimeTzFixedDateTimeZone *self, NSString *id_, NSString *nameKey, jint wallOffset, jint standardOffset) {
  OrgJodaTimeDateTimeZone_initWithNSString_(self, id_);
  JreStrongAssign(&self->iNameKey_, nameKey);
  self->iWallOffset_ = wallOffset;
  self->iStandardOffset_ = standardOffset;
}

OrgJodaTimeTzFixedDateTimeZone *new_OrgJodaTimeTzFixedDateTimeZone_initWithNSString_withNSString_withInt_withInt_(NSString *id_, NSString *nameKey, jint wallOffset, jint standardOffset) {
  OrgJodaTimeTzFixedDateTimeZone *self = [OrgJodaTimeTzFixedDateTimeZone alloc];
  OrgJodaTimeTzFixedDateTimeZone_initWithNSString_withNSString_withInt_withInt_(self, id_, nameKey, wallOffset, standardOffset);
  return self;
}

OrgJodaTimeTzFixedDateTimeZone *create_OrgJodaTimeTzFixedDateTimeZone_initWithNSString_withNSString_withInt_withInt_(NSString *id_, NSString *nameKey, jint wallOffset, jint standardOffset) {
  OrgJodaTimeTzFixedDateTimeZone *self = [[OrgJodaTimeTzFixedDateTimeZone alloc] autorelease];
  OrgJodaTimeTzFixedDateTimeZone_initWithNSString_withNSString_withInt_withInt_(self, id_, nameKey, wallOffset, standardOffset);
  return self;
}

J2OBJC_CLASS_TYPE_LITERAL_SOURCE(OrgJodaTimeTzFixedDateTimeZone)