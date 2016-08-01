//
//  Generated by the J2ObjC translator.  DO NOT EDIT!
//  source: /Users/northropo/Projects/paco/Shared/src/com/pacoapp/paco/shared/comm/Outcome.java
//

#include "J2ObjC_source.h"
#include "Outcome.h"

@interface PAOutcome () {
 @public
  jlong eventId_;
  jboolean status_;
  NSString *errorMessage_;
}

@end

J2OBJC_FIELD_SETTER(PAOutcome, errorMessage_, NSString *)

@implementation PAOutcome

- (instancetype)initWithLong:(jlong)eventId {
  PAOutcome_initWithLong_(self, eventId);
  return self;
}

J2OBJC_IGNORE_DESIGNATED_BEGIN
- (instancetype)init {
  PAOutcome_init(self);
  return self;
}
J2OBJC_IGNORE_DESIGNATED_END

- (instancetype)initWithLong:(jlong)eventId
                withNSString:(NSString *)errorMessage {
  PAOutcome_initWithLong_withNSString_(self, eventId, errorMessage);
  return self;
}

- (jlong)getEventId {
  return eventId_;
}

- (void)setEventIdWithLong:(jlong)eventId {
  self->eventId_ = eventId;
}

- (jboolean)succeeded {
  return status_;
}

- (void)setStatusWithBoolean:(jboolean)status {
  self->status_ = status;
}

- (NSString *)getErrorMessage {
  return errorMessage_;
}

- (void)setErrorMessageWithNSString:(NSString *)errorMessage {
  self->errorMessage_ = errorMessage;
}

- (void)setErrorWithNSString:(NSString *)errorMessage {
  self->status_ = false;
  self->errorMessage_ = errorMessage;
}

- (jboolean)getStatus {
  return status_;
}

+ (const J2ObjcClassInfo *)__metadata {
  static const J2ObjcMethodInfo methods[] = {
    { "initWithLong:", "Outcome", NULL, 0x1, NULL, NULL },
    { "init", "Outcome", NULL, 0x1, NULL, NULL },
    { "initWithLong:withNSString:", "Outcome", NULL, 0x1, NULL, NULL },
    { "getEventId", NULL, "J", 0x1, NULL, NULL },
    { "setEventIdWithLong:", "setEventId", "V", 0x1, NULL, NULL },
    { "succeeded", NULL, "Z", 0x1, NULL, NULL },
    { "setStatusWithBoolean:", "setStatus", "V", 0x1, NULL, NULL },
    { "getErrorMessage", NULL, "Ljava.lang.String;", 0x1, NULL, NULL },
    { "setErrorMessageWithNSString:", "setErrorMessage", "V", 0x1, NULL, NULL },
    { "setErrorWithNSString:", "setError", "V", 0x1, NULL, NULL },
    { "getStatus", NULL, "Z", 0x1, NULL, NULL },
  };
  static const J2ObjcFieldInfo fields[] = {
    { "eventId_", NULL, 0x2, "J", NULL, NULL, .constantValue.asLong = 0 },
    { "status_", NULL, 0x2, "Z", NULL, NULL, .constantValue.asLong = 0 },
    { "errorMessage_", NULL, 0x2, "Ljava.lang.String;", NULL, NULL, .constantValue.asLong = 0 },
  };
  static const J2ObjcClassInfo _PAOutcome = { 2, "Outcome", "com.pacoapp.paco.shared.comm", NULL, 0x1, 11, methods, 3, fields, 0, NULL, 0, NULL, NULL, NULL };
  return &_PAOutcome;
}

@end

void PAOutcome_initWithLong_(PAOutcome *self, jlong eventId) {
  PAOutcome_init(self);
  self->eventId_ = eventId;
}

PAOutcome *new_PAOutcome_initWithLong_(jlong eventId) {
  PAOutcome *self = [PAOutcome alloc];
  PAOutcome_initWithLong_(self, eventId);
  return self;
}

PAOutcome *create_PAOutcome_initWithLong_(jlong eventId) {
  return new_PAOutcome_initWithLong_(eventId);
}

void PAOutcome_init(PAOutcome *self) {
  NSObject_init(self);
  self->status_ = true;
}

PAOutcome *new_PAOutcome_init() {
  PAOutcome *self = [PAOutcome alloc];
  PAOutcome_init(self);
  return self;
}

PAOutcome *create_PAOutcome_init() {
  return new_PAOutcome_init();
}

void PAOutcome_initWithLong_withNSString_(PAOutcome *self, jlong eventId, NSString *errorMessage) {
  PAOutcome_initWithLong_(self, eventId);
  self->status_ = false;
  self->errorMessage_ = errorMessage;
}

PAOutcome *new_PAOutcome_initWithLong_withNSString_(jlong eventId, NSString *errorMessage) {
  PAOutcome *self = [PAOutcome alloc];
  PAOutcome_initWithLong_withNSString_(self, eventId, errorMessage);
  return self;
}

PAOutcome *create_PAOutcome_initWithLong_withNSString_(jlong eventId, NSString *errorMessage) {
  return new_PAOutcome_initWithLong_withNSString_(eventId, errorMessage);
}

J2OBJC_CLASS_TYPE_LITERAL_SOURCE(PAOutcome)