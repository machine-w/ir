===== 机构库系统

部署：
RAILS_ENV=production bundle exec rake websocket_rails:start_server
RAILS_ENV=production bundle exec rake assets:precompile

bundle install --deployment

服务器启动：
1） 启动redis: /etc/init.d/redis start
2) 启动websocket: 
进入项目目录运行
RAILS_ENV=production bundle exec rake websocket_rails:start_server
3） 启动nginx:
service nginx start


开发启动：

启动 mongodb redis
rake db:migrate
rake websocket_rails:start_server
rails server