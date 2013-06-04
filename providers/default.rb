#
# Cookbook:: racoon-ipsec-osx
# Provider:: default
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

use_inline_resources if defined?(use_inline_resources)

def action_create
  racoon_service
  template "/etc/racoon/racoon.d/#{new_resource.ipaddress}.conf" do
    source new_resource.source
    cookbook new_resource.cookbook if new_resource.cookbook
    variables(
      :ipaddress => new_resource.ipaddress,
      :my_identifier => new_resource.my_identifier,
      :shared_secret => new_resource.shared_secret,
      :xauth_login => new_resource.xauth_login,
      :encryption_algorithms => new_resource.encryption_algorithms
    )
    notifies :restart, 'service[racoon_notifier]'
  end
end

def action_delete
  racoon_service
  file "/etc/racoon/racoon.d/#{new_resource.ipaddress}" do
    action :delete
    notifies :restart, 'service[racoon_notifier]'
  end
end

def action_add
  action_create
end

def action_remove
  action_delete
end

private
def racoon_service
  service 'racoon_notifier' do
    service_name 'com.apple.racoon'
    action :nothing
  end
end
