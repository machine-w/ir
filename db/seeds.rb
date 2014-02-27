# -*- coding: utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts 'INSERT INSTITUTION AND DEPARTMENT'
institution = Institution.create! :name => '天津大学'
department = Department.create! :name => '图书馆', :institution => institution
puts 'new department' << department.name
puts 'SETTING UP DEFAULT USER LOGIN'
user = User.create!  :email => 'steve2008.ma@gmail.com', :password => 'msl110918', :password_confirmation => 'msl110918',:department => department
puts 'New user created: ' << user.email
user2 = User.create! :email => 'masheng@lib.tju.edu.cn', :password => 'msl110918', :password_confirmation => 'msl110918'
puts 'New user created: ' << user2.email
