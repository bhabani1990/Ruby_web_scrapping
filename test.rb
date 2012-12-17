require 'rubygems'
require 'open-uri'
require 'nokogiri'
require 'active_record'
require 'mysql'

doc = Nokogiri::HTML(open('http://www.simplyrecipes.com/index/'))
$arr2 = Array.new
doc.xpath('//*[contains(concat( " ", @class, " " ), concat( " ", "entry-content", " " ))]//p/a/@href').each_with_index do |node, i|
   $arr2 << node.text
  break if i == 5;
 end
$arr1 = Array.new
doc.xpath('//*[contains(concat( " ", @class, " " ), concat( " ", "entry-content", " " ))]//p/a').each_with_index do |node, i|
   $arr1 << node.text
  break if i == 5;
 end


$arr1.each do |a1|
puts a1
end


$arr2.each do |a2|
puts a2
end
ActiveRecord::Base.establish_connection(
:adapter => "mysql",
:database => "blog",
:username => "root",
:password => "bhabani123",
:host => "127.0.0.1"
)
ActiveRecord::Schema.define do

create_table :recipes do |b|
b.string:recipe_name
b.string:recipe_link
end

end

class Recipe < ActiveRecord::Base  
end  
i=0
while(i<=4) do 
Recipe.create(:recipe_name => $arr1[i] , :recipe_link => $arr2[i])
i = i+1
end
