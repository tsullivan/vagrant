# Vagrant configurations

## Example usage:

Bring machine 'centos-7' up with 'virtualbox' provider:
  ```
  vagrant up centos-7
  ```

Bring machine 'centos-7' up with 'virtualbox' provider:
  ```
  vagrant ssh centos-7
  ```

## Add additional boxes:

Some boxes are not available on Vagrant Cloud. To install those boxes, do:
  ```
  vagrant box add --name oraclelinux/6.10 https://yum.oracle.com/boxes/oraclelinux/ol610/ol610.box
  ```

## What is in the boxes

At provision time, .tar.gz artifacts of Elasticsearch and Kibana get downloaded
into the ~vagrant directory. The download script exists in /vagrant/scripts for
you to re-run if needed. If you want to use the script to download a different
version:
  ```
  STACK_VERSION=5.6.14 sh /vagrant/scripts/get_stack.sh
  ```
