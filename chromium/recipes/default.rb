remote_file "/home/#{node['chromium']['user']}/archive.zip" do
  source node['chromium']['location']
end

execute "remove target directory in preparation" do
  command "rm -rf ~#{node['chromium']['user']}/#{node['chromium']['expand']}"
end

execute "unzip chromium" do
  command "unzip -d ~#{node['chromium']['user']}/expandtemp ~#{node['chromium']['user']}/archive.zip && mv ~#{node['chromium']['user']}/expandtemp/* ~#{node['chromium']['user']}/#{node['chromium']['expand']} && rm ~#{node['chromium']['user']}/archive.zip && rm -rf ~#{node['chromium']['user']}/expandtemp"
end

execute "symlink chromium" do
  command "rm -f /usr/bin/#{node['chromium']['symlink']} && ln -s ~#{node['chromium']['user']}/#{node['chromium']['expand']}/#{node['chromium']['chrome']} /usr/bin/#{node['chromium']['symlink']}"
end

execute "chown/chmod chromium" do
  command "chown -R #{node['chromium']['user']} ~#{node['chromium']['user']}/#{node['chromium']['expand']}"
end

execute "chown/chmod chrome_sandbox" do
  command "chown root:root ~#{node['chromium']['user']}/#{node['chromium']['expand']}/#{node['chromium']['chrome_sandbox']} && chmod 4755 ~#{node['chromium']['user']}/#{node['chromium']['expand']}/#{node['chromium']['chrome_sandbox']}"
end
