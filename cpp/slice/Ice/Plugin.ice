// **********************************************************************
//
// Copyright (c) 2002
// ZeroC, Inc.
// Billerica, MA, USA
//
// All Rights Reserved.
//
// Ice is free software; you can redistribute it and/or modify it under
// the terms of the GNU General Public License version 2 as published by
// the Free Software Foundation.
//
// **********************************************************************

#ifndef ICE_PLUGIN_ICE
#define ICE_PLUGIN_ICE

module Ice
{

/**
 *
 * A Communicator plug-in. A plug-in generally adds a feature to a
 * Communicator, such as support for a protocol.
 *
 **/
local interface Plugin
{
    /**
     *
     * Called when the Communicator is being destroyed.
     *
     **/
    void destroy();
};

/**
 *
 * Each Communicator has a PluginManager to administer the set of
 * plug-ins.
 *
 **/
local interface PluginManager
{
    /**
     *
     * Obtain a plug-in by name.
     *
     * @param name The plug-in's name.
     *
     * @return The plug-in.
     *
     **/
    Plugin getPlugin(string name);

    /**
     *
     * Install a new plug-in.
     *
     * @param name The plug-in's name.
     *
     * @param pi The plug-in.
     *
     **/
    void addPlugin(string name, Plugin pi);

    /**
     *
     * Called when the Communicator is being destroyed.
     *
     **/
    void destroy();
};

};

#endif
