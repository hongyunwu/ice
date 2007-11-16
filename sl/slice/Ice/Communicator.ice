// **********************************************************************
//
// Copyright (c) 2003-2007 ZeroC, Inc. All rights reserved.
//
// This copy of Ice is licensed to you under the terms described in the
// ICE_LICENSE file included in this distribution.
//
// **********************************************************************

#ifndef ICE_COMMUNICATOR_ICE
#define ICE_COMMUNICATOR_ICE

#include <Ice/LoggerF.ice>
#include <Ice/StatsF.ice>
#include <Ice/PropertiesF.ice>
#include <Ice/ObjectFactoryF.ice>
#include <Ice/ImplicitContextF.ice>
#include <Ice/Identity.ice>
#include <Ice/Context.ice>

/**
 *
 * The Ice core library. Among many other features, the Ice core
 * library manages all the communication tasks using an efficient
 * protocol (including protocol compression and support for both TCP
 * and UDP), provides a thread pool for multi-threaded servers, and
 * additional functionality that supports high scalability.
 *
 **/
module Ice
{

    
/**
 *
 * The central object in Ice. One or more communicators can be
 * instantiated for an Ice application. Communicator instantiation
 * is language-specific, and not specified in Slice code.
 *
 * @see Logger
 * @see Stats
 * @see ObjectAdapter
 * @see Properties
 * @see ObjectFactory
 *
 **/
local interface Communicator
{
    /**
     *
     * Destroy the communicator. This operation calls [shutdown]
     * implicitly.  Calling [destroy] cleans up memory, and shuts down
     * this communicator's client functionality and destroys all object
     * adapters. Subsequent calls to [destroy] are ignored.
     *
     * @see shutdown
     * @see ObjectAdapter::destroy
     *
     **/
    void destroy();

    /**
     *
     * Convert a string into a proxy. For example,
     * <tt>MyCategory/MyObject:tcp -h some_host -p
     * 10000</tt> creates a proxy that refers to the Ice object
     * having an identity with a name "MyObject" and a category
     * "MyCategory", with the server running on host "some_host", port
     * 10000. If the string does not parse correctly, the operation
     * throws [ProxyParseException].
     *
     * @param str The string to convert into a proxy.
     *
     * @return The proxy.
     *
     * @see proxyToString
     *
     **/
    ["cpp:const"] Object* stringToProxy(string str);

    /**
     *
     * Convert a proxy into a string.
     *
     * @param obj The proxy to convert into a string.
     *
     * @return The "stringified" proxy.
     *
     * @see stringToProxy
     *
     **/
    ["cpp:const"] string proxyToString(Object* obj);


    /**
     * 
     * Convert a set of proxy properties into a proxy.
     *
     * @param property The base property name.
     * 
     * @return The proxy.
     *
     **/
    ["cpp:const"] Object* propertyToProxy(string property);

    /**
     *
     * Convert a string into an identity.
     *
     * @param str The string to convert into an identity.
     *
     * @return The identity.
     *
     * @see identityToString
     *
     **/
    ["cpp:const"] Identity stringToIdentity(string str);

    /**
     *
     * Convert an identity into a string.
     *
     * @param ident The identity to convert into a string.
     *
     * @return The "stringified" identity.
     *
     * @see stringToIdentity
     *
     **/
    ["cpp:const"] string identityToString(Identity ident);

    /**
     *
     * Add a servant factory to this communicator. Installing a
     * factory with an id for which a factory is already registered
     * throws [AlreadyRegisteredException].</p>
     *
     * <p>When unmarshaling an Ice object, the Ice run-time reads the
     * most-derived type id off the wire and attempts to create an
     * instance of the type using a factory. If no instance is created,
     * either because no factory was found, or because all factories
     * returned nil, the object is sliced to the next most-derived type
     * and the process repeats. If no factory is found that can create an
     * instance, the Ice run-time throws [NoObjectFactoryException].</p>
     *
     * <p>The following order is used to locate a factory for a type:</p>
     *
     * <ol>
     *
     * <li>The Ice run-time looks for a factory registered
     * specifically for the type.</li>
     *
     * <li>If no instance has been created, the Ice run-time looks
     * for the default factory, which is registered with an emtpy type id.
     * </li>
     *
     * <li>If no instance has been created by any of the preceding
     * steps, the Ice run-time looks for a factory that may have been
     * statically generated by the language mapping for non-abstract classes.
     * </li>
     *
     * </ol>
     * <p>
     *
     * @param factory The factory to add.
     *
     * @param id The type id for which the factory can create instances, or
     * an empty string for the default factory.
     *
     * @see findObjectFactory
     * @see ObjectFactory
     *
     **/
    void addObjectFactory(ObjectFactory factory, string id);

    /**
     *
     * Find a servant factory registered with this communicator.
     *
     * @param id The type id for which the factory can create instances,
     * or an empty string for the default factory.
     *
     * @return The servant factory, or null if no servant factory was
     * found for the given id.
     *
     * @see addObjectFactory
     * @see ObjectFactory
     *
     **/
    ["cpp:const"] ObjectFactory findObjectFactory(string id);


    /**
     *
     * Get the currently-set default context.
     *
     * <p class="Deprecated">This operation is deprecated as of version 3.2.
     *
     * @return The currently established default context. If no
     * default context is currently set, [getDefaultContext]
     * returns an empty context.
     *
     * @see setDefaultContext
     **/
    ["cpp:const", "deprecate:getDefaultContext is deprecated, use per-proxy contexts or implicit contexts (if applicable) instead."]
    Context getDefaultContext();

    /**
     *
     * Set a default context on this communicator. All newly
     * created proxies will use this default context. This operation 
     * has no effect on existing proxies.
     *
     * <p class="Note"> You can also set a context for an individual proxy
     * by calling the operation [ice_context] on the proxy.</p>
     *
     * <p class="Deprecated">This operation is deprecated as of version 3.2.
     *
     * @param ctx The default context to be set.
     * @see getDefaultContext
     **/
    ["deprecate:setDefaultContext is deprecated, use per-proxy contexts or implicit contexts (if applicable) instead."]
    void setDefaultContext(Context ctx);
    
    /**
     * Get the implicit context associated with this communicator.
     *
     * @return The implicit context associated with this communicator; 
     * returns null when the property Ice.ImplicitContext is not set 
     * or is set to None.
     *
     **/
    ["cpp:const"] ImplicitContext getImplicitContext();
    
    /**
     *
     * Get the properties for this communicator.
     *
     * @return This communicator's properties.
     *
     * @see Properties
     *
     **/
    ["cpp:const"] Properties getProperties();

    /**
     *
     * Get the logger for this communicator.
     *
     * @return This communicator's logger.
     *
     * @see Logger
     *
     **/
    ["cpp:const"] Logger getLogger();

    /**
     *
     * Get the statistics callback object for this communicator.
     *
     * @return This communicator's statistics callback object.
     *
     * @see Stats
     *
     **/
    ["cpp:const"] Stats getStats();
};

};

#endif
