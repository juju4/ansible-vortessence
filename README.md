[![No Maintenance Intended](http://unmaintained.tech/badge.svg)](http://unmaintained.tech/)
# DEPRECATED/LOOKING FOR MAINTAINERS -> archived

[![Build Status - Master](https://travis-ci.org/juju4/ansible-vortessence.svg?branch=master)](https://travis-ci.org/juju4/ansible-vortessence)
[![Build Status - Devel](https://travis-ci.org/juju4/ansible-vortessence.svg?branch=devel)](https://travis-ci.org/juju4/ansible-vortessence/branches)
# Vortessence ansible role

A simple ansible role to setup Vortessence
Vortessence is a tool, whose aim is to partially automate memory forensics analysis. Vortessence is a project of the Security Engineering Lab of the Bern University of Applied Sciences.
http://vortessence.org/

## Requirements & Dependencies

### Ansible
It was tested on the following versions:
 * 2.0
 * 2.2
 * 2.5

### Operating systems

Tested Ubuntu 14.04, 16.04, 18.04 and centos7

## Example Playbook

Just include this role in your list.
For example

```
- host: all
  roles:
    - juju4.vortessence
```

## Variables

Nothing specific for now.

## Continuous integration

This role has a travis basic test (for github), more advanced with kitchen and also a Vagrantfile (test/vagrant).

Once you ensured all necessary roles are present, You can test with:
```
$ cd /path/to/roles/juju4.vortessence
$ kitchen verify
$ kitchen login
```
or
```
$ cd /path/to/roles/juju4.vortessence/test/vagrant
$ vagrant up
$ vagrant ssh
```

## Troubleshooting & Known issues

* mess with ansible_ssh_user/ansible_user since 2.0.x
null, allocated to orchestrator user or remote user.
result: kitchen script executes as root, vagrant script as your orchestrator user...

* Django 1.9 update issue?
```
$ python /opt/vortessence/vortessence/manage.py runserver 0.0.0.0:8000
Performing system checks...

System check identified no issues (0 silenced).
March 16, 2016 - 02:21:25
Django version 1.9.4, using settings 'vortessence.settings'
Starting development server at http://0.0.0.0:8000/
Quit the server with CONTROL-C.
Unhandled exception in thread started by <function wrapper at 0x7f98c69dcc80>
Traceback (most recent call last):
  File "/usr/local/lib/python2.7/dist-packages/django/utils/autoreload.py", line 226, in wrapper
    fn(*args, **kwargs)
  File "/usr/local/lib/python2.7/dist-packages/django/core/management/commands/runserver.py", line 135, in inner_run
    handler = self.get_handler(*args, **options)
  File "/usr/local/lib/python2.7/dist-packages/django/contrib/staticfiles/management/commands/runserver.py", line 27, in get_handler
    return StaticFilesHandler(handler)
  File "/usr/local/lib/python2.7/dist-packages/django/contrib/staticfiles/handlers.py", line 20, in __init__
    self.base_url = urlparse(self.get_base_url())
  File "/usr/local/lib/python2.7/dist-packages/django/contrib/staticfiles/handlers.py", line 24, in get_base_url
    utils.check_settings()
  File "/usr/local/lib/python2.7/dist-packages/django/contrib/staticfiles/utils.py", line 52, in check_settings
    "You're using the staticfiles app "
django.core.exceptions.ImproperlyConfigured: You're using the staticfiles app without having set the required STATIC_URL setting.
```
= commented "    'django.contrib.staticfiles'," in settings.py. Solved :)

## License

BSD 2-clause

