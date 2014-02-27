# -*- coding: utf-8 -*-
FactoryGirl.define do
  factory :institution do
    name "天津大学"
    description ""
  end
  
  factory :department do
    name     "图书馆"
    description ""
    association :institution
  end
end
