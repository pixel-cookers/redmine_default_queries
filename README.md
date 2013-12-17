redmine_default_queries
=======================

This allow you to setup a default query per project.

Installation
------------

Like any redmine plugin clone this project into redmine plugin directory

```
git clone https://github.com/pixel-cookers/redmine_default_queries plugins/redmine_default_queries
```

Create a custom field for project named : `query_id` you are ready to setup a default query_id for your project.

`Warning:` you need to setup a query_id that is visible for all user in the project otherwise you will get a 404 error

TODO :
------

* allow setup custom field name
* prevent 404 issue
* prevent overriding session query
