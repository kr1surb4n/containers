daemonize = false;

---------- Server-wide settings ----------
-- Settings in this section apply to the whole server and are the default settings
-- for any virtual hosts

-- This is a (by default, empty) list of accounts that are admins
-- for the server. Note that you must create the accounts separately
-- (see http://prosody.im/doc/creating_accounts for info)
-- Example: admins = { "user1@example.com", "user2@example.net" }
admins = { }

-- Enable use of libevent for better performance under high load
-- For more information see: http://prosody.im/doc/libevent
--use_libevent = true;


plugin_paths = { "/usr/lib/prosody/modules-community" }

modules_enabled = {

        -- Generally required
                "roster"; -- Allow users to have a roster. Recommended ;)
                "saslauth"; -- Authentication for clients and servers. Recommended if you want to log in.
                "tls"; -- Add support for secure TLS on c2s/s2s connections
                "dialback"; -- s2s dialback support
                "disco"; -- Service discovery
                "posix"; -- POSIX functionality, sends server to background, enables syslog, etc.
                "offline";

        -- Not essential, but recommended
                "private"; -- Private XML storage (for room bookmarks, etc.)
                "vcard"; -- Allow users to set vCards

       -- These are commented by default as they have a performance impact
                --"privacy"; -- Support privacy lists
                --"compression"; -- Stream compression (requires the lua-zlib package installed)

        -- Nice to have
                --"version"; -- Replies to server version requests
                --"uptime"; -- Report how long server has been running
                "time"; -- Let others know the time here on this server
                "ping"; -- Replies to XMPP pings with pongs
                "pep"; -- Enables users to publish their mood, activity, playing music and more
                --"register"; -- Allow users to register on this server using a client and change passwords
				"carbons";
       -- Admin interfaces
                --"admin_adhoc"; -- Allows administration via an XMPP client that supports ad-hoc commands
                --"admin_telnet"; -- Opens telnet console interface on localhost port 5582

        -- HTTP modules
				"http";
                "bosh"; -- Enable BOSH clients, aka "Jabber over HTTP"
                "http_files"; -- Serve static files from a directory over HTTP
                "http_upload";

        -- Other specific functionality
                "groups"; -- Shared roster support
                --"announce"; -- Send announcement to all online users
                --"welcome"; -- Welcome users who register accounts
                --"watchregistrations"; -- Alert admins of registrations
                --"motd"; -- Send a message to users when they log in
                --"legacyauth"; -- Legacy authentication. Only used by some old clients and bots.
        -- Mine
                -- "muc";-- multiuser chat
                -- "muc_mam"; -- multichannerl archiving
                "message";};
           

-- Disable account creation by default, for security
-- For more information see http://prosody.im/doc/creating_accounts
allow_registration = false;

c2s_require_encryption = true
s2s_secure_auth = true

-- Many servers don't support encryption or have invalid or self-signed
-- certificates. You can list domains here that will not be required to
-- authenticate using certificates. They will be authenticated using DNS.

--s2s_insecure_domains = { "gmail.com" }

-- Even if you leave s2s_secure_auth disabled, you can still require valid
-- certificates for some domains by specifying a list here.

--s2s_secure_domains = { "jabber.org" }

-- Required for init scripts and prosodyctl
pidfile = "/var/run/prosody/prosody.pid"

-- Select the authentication backend to use. The 'internal' providers
-- use Prosody's configured data storage to store the authentication data.
-- To allow Prosody to offer secure authentication mechanisms to clients, the
-- default provider stores passwords in plaintext. If you do not trust your
-- server please see http://prosody.im/doc/modules/mod_auth_internal_hashed
-- for information about using the hashed backend.

authentication = "internal_hashed"

-- Select the storage backend to use. By default Prosody uses flat files
-- in its configured data directory, but it also supports more backends
-- through modules. An "sql" backend is included by default, but requires
-- additional dependencies. See http://prosody.im/doc/storage for more info.

--storage = "sql" -- Default is "internal"

-- For the "sql" backend, you can uncomment *one* of the below to configure:
--sql = { driver = "SQLite3", database = "prosody.sqlite" } -- Default. 'database' is the filename.
--sql = { driver = "MySQL", database = "prosody", username = "prosody", password = "secret", host = "localhost" }
--sql = { driver = "PostgreSQL", database = "prosody", username = "prosody", password = "secret", host = "localhost"

-- Logging configuration
-- For advanced logging see http://prosody.im/doc/logging
-- levels: debug, info, warn, error
log = {
    info  = "*console";
    debug = "/var/log/prosody/debug.log"; -- Send debug and higher here
    error = "*syslog"; -- Requires mod_posix to be loaded
}

groups_file = "/etc/prosody/sharedgroups.txt"

consider_bosh_security = true

---- Virtual hosts -----------
-- You need to add a VirtualHost entry for each domain you wish Prosody to serve.
-- Settings under each VirtualHost entry apply *only* to that host.

-- THIS IS NECCESARY HERE, it's certificate to your main domain
https_key = "/etc/prosody/certs/plumplum.space.key";
https_certificate = "/etc/prosody/certs/plumplum.space.crt";

VirtualHost "plumplum.space"
-- Certificate is set AUTOMATICALY and in the GLOBAL CONFIG SECTION

------ Components ------
-- You can specify components to add hosts that provide special services,
-- like multi-user conferences, and transports.

-- For more information on components, see http://prosody.im/doc/components
Component "u.plumplum.space" "http_upload"
-- Certificate is set AUTOMATICALY and in the GLOBAL CONFIG SECTION
        http_files_dir = "/var/www"

---Set up a MUC (multi-user chat) room server on conference.example.com:
Component "c.plumplum.space" "muc"
-- Certificate is set AUTOMATICALY and in the GLOBAL CONFIG SECTION
