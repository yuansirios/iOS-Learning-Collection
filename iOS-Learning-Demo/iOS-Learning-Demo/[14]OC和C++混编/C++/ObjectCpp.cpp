//
//  CPPHello.cpp
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/9/16.
//  Copyright © 2019 yuan. All rights reserved.
//

#include "ObjectCpp.hpp"

ObjectCpp::ObjectCpp(void* oc, interface call) {
    this->myOC = oc;
    this->myCall = call;
}
void ObjectCpp::function(void* parameter) {
    this->myCall(this->myOC,parameter);
}

ObjectCpp::~ObjectCpp(){
    std::cout<< "CPP Object released"<< std::endl;
}
