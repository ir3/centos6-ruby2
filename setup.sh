#! /bin/sh
epelRpm=epel-release-6-8.noarch.rpm
rpmforgeRpm=rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm
remiRpm=remi-release-6.rpm
ruby=ruby-2.0.0-p247
rubygems=rubygems-2.0.6

# base update 
yum -y update

# regist repository
if [ ! -e "/etc/yum.repos.d/epel.repo" ]; then
  curl -O http://ftp.riken.jp/Linux/fedora/epel/6/x86_64/${epelRpm}
  rpm -ivh ${epelRpm}
fi
if [ ! -e "/etc/yum.repos.d/rpmforge.repo" ]; then
  rpm -ivh http://apt.sw.be/redhat/el6/en/x86_64/rpmforge/RPMS/${rpmforgeRpm}
fi
if [ ! -e "/etc/yum.repos.d/remi.repo" ]; then
  rpm -ivh http://rpms.famillecollet.com/enterprise/${remiRpm}
  sed -i '5s/enabled=0/enabled=1/' /etc/yum.repos.d/remi.repo
fi
 
# scp
yum -y install openssh-clients

# make ruby
yum -y install \
 gcc \
 gcc-c++ \
 g++ \
 make \
 automake \
 autoconf \
 curl-devel \
 httpd-devel \
 apr-devel \
 apr-util-devel \
 sqlite \
 sqlite-devel
yum -y install openssl-devel zlib-devel readline-devel
yum -y install libyaml libyaml-devel

# ruby
if [ ! -e "/usr/local/src/${ruby}.tar.bz2" ]; then
  cd /usr/local/src
  curl -O ftp://ftp.ruby-lang.org/pub/ruby/2.0/${ruby}.tar.bz2
  tar xf ${ruby}.tar.bz2
  cd ${ruby}
  ./configure --prefix=/opt/${ruby} --enable-shared
  make
  make test
  make install
fi

# rubygems
if [ ! -e "/usr/local/src/${rubygems}.tgz" ]; then
  cd /usr/local/src
  curl -O http://production.cf.rubygems.org/rubygems/${rubygems}.tgz
  tar xf ${rubygems}.tgz
  cd ${rubygems}
  /opt/${ruby}/bin/ruby setup.rb
fi
