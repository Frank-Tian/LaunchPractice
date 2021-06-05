//
//  ViewController.m
//  Tracker
//
//  Created by Tian on 2021/6/5.
//

#import "ViewController.h"
#include <stdint.h>
#include <stdio.h>
#include <sanitizer/coverage_interface.h>
#import <dlfcn.h>
#import <libkern/OSAtomic.h>
#import <Tracker-Swift.h>

static OSQueueHead symbolList = OS_ATOMIC_QUEUE_INIT;

typedef struct{
    void *pc;
    void *next;
} TCNode;

@interface ViewController ()

@end

@implementation ViewController

void (^myBlock)(void) = ^(void) {
    NSLog(@"-------------Hello ~");
};

void testCFunc(void) {
    myBlock();
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    testCFunc();
    [UserSDK login];
}

void __sanitizer_cov_trace_pc_guard_init(uint32_t *start, uint32_t *stop) {
//    static uint64_t N;                      // Counter for the guards.
//    if (start == stop || *start) return;    // Initialize only once.
//    printf("INIT: %p %p\n", start, stop);
//    for (uint32_t *x = start; x < stop; x++)
//        *x = ++N;
}

void __sanitizer_cov_trace_pc_guard(uint32_t *guard) {
    void *PC = __builtin_return_address(0);
    
    TCNode * node = malloc(sizeof(TCNode));
    *node = (TCNode){PC,NULL};

    OSAtomicEnqueue(&symbolList, node, offsetof(TCNode, next));
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self getTrackPath];
}

- (void)getTrackPath {
    
    NSMutableArray<NSString *> * symbolNames = [NSMutableArray array];
    while (YES) {
        TCNode * node = OSAtomicDequeue(&symbolList, offsetof(TCNode, next));
        if (node == NULL) {
            break;
        }
        Dl_info info = {0};
        dladdr(node->pc, &info);
        printf("%s \n",info.dli_sname);
        NSString * name = @(info.dli_sname);
        free(node);
        
        BOOL isObjc = [name hasPrefix:@"+["]||[name hasPrefix:@"-["];
        NSString * symbolName = isObjc ? name : [@"_" stringByAppendingString:name];

        [symbolNames addObject:symbolName];
    }

    NSEnumerator * enumerator = [symbolNames reverseObjectEnumerator];
    NSMutableArray * funcs = [NSMutableArray arrayWithCapacity:symbolNames.count];
    NSString * name;

    while (name = [enumerator nextObject]) {
        if (![funcs containsObject:name]) {
            [funcs addObject:name];
        }
    }
    [funcs removeObject:[NSString stringWithFormat:@"%s",__FUNCTION__]];

    NSString * funcStr = [funcs componentsJoinedByString:@"\n"];
    NSString * filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"tracker.order"];
    NSData * fileContents = [funcStr dataUsingEncoding:NSUTF8StringEncoding];
    [[NSFileManager defaultManager] createFileAtPath:filePath contents:fileContents attributes:nil];
}


@end
