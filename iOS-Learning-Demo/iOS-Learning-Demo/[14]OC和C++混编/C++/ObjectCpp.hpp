//
//  CPPHello.hpp
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/9/16.
//  Copyright © 2019 yuan. All rights reserved.
//

#ifndef CPPHello_hpp
#define CPPHello_hpp

#include <stdio.h>
#include <iostream>
#include "ObjectInterface.h"

class ObjectCpp {
    void* myOC;
    interface myCall;
public:
    ObjectCpp();
    ObjectCpp(void* oc ,interface call);
    ~ObjectCpp();
    void function(void* parameter);
};

#endif /* CPPHello_hpp */
