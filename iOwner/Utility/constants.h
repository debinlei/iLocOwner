//
//  constants.h
//  iOwner
//
//  Created by ldb on 4/18/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#ifndef iOwner_constants_h
#define iOwner_constants_h
//#define LOCALTEST
#ifdef LOCALTEST
    #define REST_SERVER @"http://9.123.139.41:9000/"
#else
    #define REST_SERVER @"http://mysquare.jelastic.servint.net/"
#endif
//the api for user registation 
//parameter is
//email, password, name all are needed
#define REST_API_REGISTER   @"Application/Jregister?email=%@&password=%@&name=%@"

#define REST_API_LOGIN   @"Application/Jlogin?email=%@&password=%@"

#define REST_API_ONETAKE   @"Users/JOneTake?x=%d&y=%d"
#define REST_API_ONETAKE_PLACEMACK   @"Users/JOneTake?x=%d&y=%d&pmark=%@"

#define MAP_UNIT_SERVER(n)  n*1000000
#define MAP_UNIT_LOCAL(n)  ((double)(n))/1000000

#define JSON_DOMAIN_NEW @"new_domain"
#define JSON_DOMAIN_DATA_LEFT @"left"
#define JSON_DOMAIN_DATA_TOP @"top"
#define JSON_DOMAIN_DATA_RIGHT @"right"
#define JSON_DOMAIN_DATA_BOTTOM @"bottom"


#endif
