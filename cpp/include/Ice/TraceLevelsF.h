// **********************************************************************
//
// Copyright (c) 2002
// MutableRealms, Inc.
// Huntsville, AL, USA
//
// All Rights Reserved
//
// **********************************************************************

#ifndef ICE_TRACE_LEVELS_F_H
#define ICE_TRACE_LEVELS_F_H

#include <Ice/Handle.h>

namespace __Ice
{

class TraceLevels;
void incRef(TraceLevels*);
void decRef(TraceLevels*);
typedef __Ice::Handle<TraceLevels> TraceLevels_ptr;

}

#endif
