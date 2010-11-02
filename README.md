DynDynDong
==========

DynDynDong is a ruby written client to update dynamic dns and it supports many
services.
I know, there are inadyn and other shit, but they are totally crappy and
limitated.
Name is inspired to [Gunther - Ding Ding Dong](http://www.youtube.com/watch?v=DbYtqAWDF2U).

You can see some working examples in examples directory.

DynDynDong::Afraid has:

  * host - It accept 2 arguments, domain and hash, in order.

DynDynDong::DynDNS has:

  * username  - It accept 1 argument, the username.
  * password  - It accept 1 argument, the password.
  * host      - It accept 1 argument, the domain to update.
  * offline   - It accept 1 argument, the domain to hide, only premium.

There are, also, the functions DynDynDong.delay= and DynDynDong.delay, useful to
set and get the time to wait between two updates.

Use DynDynDong::Client.start to start all updates, DynDynDong to call
DynDynDong::Client.start\_loop every DynDynDong.delay and DynDynDong::Daemon.start
to run a DynDynDong::Client.start\_loop and daemonize itself.

That's all, enjoy :D
