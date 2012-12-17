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
:database => "shankar",
:username => "root",
:password => "bhabani123",
:host => "127.0.0.1",
:port=>3306

)

class Recipe < ActiveRecord::Base  
end

i=0
		while(i<=4) do 
begin
		r = Recipe.new(:recipe_name => $arr1[i].to_s , :recipe_link => $arr2[i].to_s)
                r.save
rescue Exception => e
puts "==============================#{e.message}"
end
		end
		i = i+1


