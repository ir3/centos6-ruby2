centos6-ruby2
=============

CentOS minimal + Ruby 2.0.0 + RubyGems 2.0.6 with epel, rpmforge, remi repositories

## How to setup

    curl https://raw.github.com/ir3/centos6-ruby2/master/setup.sh | sudo sh -

## ruby

    # ruby=ruby-2.0.0-p247;/opt/${ruby}/bin/ruby -v
    ruby 2.0.0p247 (2013-06-27 revision 41675) [i686-linux]
    # echo "puts 'hello ruby'" | /opt/${ruby}/bin/ruby
    hello ruby
