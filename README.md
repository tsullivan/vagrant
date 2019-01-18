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

We want to be able to use some boxes that are not published on Vagrant cloud. To install those boxes, do:
  ```
  vagrant box add --name oraclelinux/6.10 https://yum.oracle.com/boxes/oraclelinux/ol610/ol610.box
  ```
