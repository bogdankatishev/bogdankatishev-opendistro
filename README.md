#Installs Open Distro for Elasticsearch
**Description:** this puppet module installs a basic installation of **elasticsearch-oss** and **Open Distro for Elasticsearch** (package: opendistroforelasticsearch).

##Usage

###Hiera

Default values (can be overridden)
```
---
opendistro::java_package: 'java-1.8.0-openjdk-devel'
opendistro::package_name: 'opendistroforelasticsearch'
opendistro::java_tools_dir: '/usr/lib/jvm/java-1.8.0/lib/tools.jar'
```

###Params
java_package   -> Defines which version of java needs to be installed (default: java-1.8.0-openjdk-devel)
package_name   -> Defines the package name that needs to be installed (default: opendistroforelasticsearch)
**Optional:** java_tools_dir -> Defines the location where to find the "tools.jar" in java the directory which is needed for Open Distro. **Only if you are using java version 8**
package_ensure -> Defines the state of the package (default: installed)
service_name   -> Defines the service name for starting (default: elasticsearch)
ensure         -> (default: present)
manage_repo    -> Defines if the module should manage the repo (default: true)
service_ensure -> Defines the state of the service (default: enabled)

###Includes
- [x] Basic installation of ES and OpenDistro for ES
- [x] Java installation
- [x] Needed symlinks (for java 8)
