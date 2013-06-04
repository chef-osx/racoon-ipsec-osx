#
# Cookbook:: racoon-ipsec-osx
# Resource:: default
# Author:: Joshua Timberman <joshua@opscode.com>
# Copyright 2013, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

actions :create, :delete
default_action :create

attribute :ipaddress, :name_attribute => true
attribute :source, :default => 'racoon-remote.conf.erb'
attribute :cookbook, :default => nil
attribute :my_identifier, :kind_of => String, :required => true
attribute :shared_secret, :kind_of => String, :required => true
attribute :xauth_login, :kind_of => String, :required => true
attribute :encryption_algorithms, :kind_of => Hash, :default => {
  "sha1" => ["aes 256", "aes", "3des", "des"],
  "md5" => ["aes 256", "aes", "des"]
}
