Overview
========

This is a simple Rails app which is used as a container to mount the following existing rails mountable engines:
* [KAUI](https://github.com/killbill/killbill-admin-ui), the administrative UI which also takes care of all the authentication and multi-tenancy logics
* [KANAUI](https://github.com/killbill/killbill-analytics-ui), the analytics UI (which requires the analytics plugin)

TODO: Incomplete...

Getting Started:
----------------

```
export RAILS_ENV=development
bundle install
rails server
```

Production Deployment:
-----------------------

```
rails generate symmetric_encryption:new_keys production
RAILS_ENV=production; rake assets:clean; rake assets:precompile
rails server
```
