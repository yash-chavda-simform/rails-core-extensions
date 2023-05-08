#To "cherry-pick" a definition in Active Support Core Extensions means to selectively choose a specific extension or method definition from the module to use in your code, 
#rather than including the entire module.

# require "active_support" -> only the extensions required by the Active Support framework are loaded.
# require "active_support/core_ext/hash" -> load all hash methods
# require "active_support/core_ext" - if we want load core extention 
# require "active_support/core_ext/hash" -> load all hash methods

#When config.active_support.bare is set to true, Rails will only load a minimal subset of Active Support's functionality.
#if the value is false then it will load all extention
require "active_support/all"
require "active_support/core_ext/hash/indifferent_access" #-> load particuler method
val = {a: 1}.with_indifferent_access["a"]                 # => 1
puts val

nil.nil?  #-> true
#It returns true for nil (an instance of the class NilClass) and false for everything else.

"".empty? #-> true
##empty? is a method that can be used on strings, arrays, hashes and sets. It returns true if the instance of the object has a length of zero.

"".blank? ##blank? is a Rails method (in ActiveSupport). It operates on any object.
#it will return true for empty strings as well as strings containing only whitespace characters.
#For arrays, hashes and sets, it works just like #empty?, in that it returns true if they have no elements.
#It returns false for true and true for any falsey conditions (i.e. nil and false)

#present? is also a Rails method. It does the opposite of what #blank? does.

#presence - it will return value if present or nil if not
sum = ""
total = sum.presence || 4 
puts total

puts "foo".dup          #-> duplicate the value
puts "foo".duplicable?  #-> check that value is duplicable or not

#differnce between dup and deep_dup is in deep_dup the changes is not reflect which made on original nested array

#try - unless object is not nil. When you want to call a method on an object only if it is not nil
@number = nil
@number.try(:next)            #return nil
my_object.act_like?(MyClass) #it will check my-object is behaves like MyClass or not.

#to_param - which is meant to return something that represents them as values in a query string
[7,5].to_param #"7/5"

#to_query -  query string that associates a given key with the return value of to_param
[3.4, -45.6].to_query('sample') #"sample%5B%5D=3.4&sample%5B%5D=-45.6" 
{c: 3, b: 2, a: 1}.to_query     # => "a=1&b=2&c=3"

#with_options - provides a way to factor out common options in a series of method calls.
with_options dependent: :destroy do |assoc|
  assoc.has_many :customers
  assoc.has_many :products
  assoc.has_many :invoices
  assoc.has_many :expenses
end

#instance_variable name and value
C.new(0, 1).instance_values         # => {"x" => 0, "y" => 1}
C.new(0, 1).instance_variable_names # => ["@x", "@y"]

#in?
1.in?([1,2])        # => true
"lo".in?("hello")   # => true
25.in?(30..50)      # => false
1.in?(1)            # => ArgumentError

#module extention
#in model 
#alias_attribute :login, :email ## You can refer to the email column as "login" 

#module_parents
# M = X::Y::Z
# X::Y::Z.module_parents # => [X::Y, X, Object]
# M.module_parents       # => [X::Y, X, Object]

# X::Y::Z.module_parent_name # => "X::Y"
# M.module_parent_name       # => "X::Y"

#anonymous - we cam check whether this module has name or not
M.name          # => "M" 
Module.new.name # => nil

M.anonymous?    # => false if name is given.

Module.new.anonymous? # => true if name is not given.

#Method Delegation
delegate :name, to: :profile, prefix: :avatar #it will direct load name from profile modle to current model if we have association. here prifix : avatar_name
#if we mention private: true then we can only access that name using profile object not directly in user model.
#when private: true
user.profile.avatar_name  #work 
user.avatar_name -        #error

#Redefining Methods

#extention to classes
#The method class_attribute declares one or more inheritable class attributes that can be overridden at any level down the hierarchy.

#subclasses - the classes which come under upto on level
class C; end
C.subclasses  # => []

class B < C; end
C.subclasses  # => [B]

class A < B; end
C.subclasses  # => [B]

class D < C; end
C.subclasses  # => [B, D]

#descendants - the class which come under upto any level
lass C; end
C.descendants # => []

class B < C; end
C.descendants # => [B]

class A < B; end
C.descendants # => [B, A]

class D < C; end
C.descendants # => [B, A, D]

#Safe Strings - to check string is safe or not
s = "<p>Hello, world!</p>"  #in the view &lt;p&gt;Hello, world!&lt;/p&gt; escaped convert < > tag into html entity to avoid this
s = "".html_safe
s.html_safe                 #true by default it false but after html_safe it will give true.

#remove - remove all occurrences of the pattern
"Hello World".remove(/Hello /)  # => "World"

#squish - remove all spaces and next line in both format
" \n  foo\n\r \t bar \n".squish # => "foo bar"

#truncate - return string based on length includeing ...
"Oh dear! Oh dear! I shall be late!".truncate(20)
# => "Oh dear! Oh dear!..."

#truncate_bytes - return based on bytes
"👍👍👍👍".truncate_bytes(15)                     # => "👍👍👍…"
"👍👍👍👍".truncate_bytes(15, omission: "🖖")
# => "👍👍🖖"                                     #this omission will replace ... with given symbol

#truncate_words - return string based on word
"Oh dear! Oh dear! I shall be late!".truncate_words(4) # => "Oh dear! Oh dear!..."
#one more parameter is there "separator: '!'" which count word upto !

#inquiry - compare the strings.
"production".inquiry.production? # => true
"active".inquiry.inactive?       # => false

#starts_with? and ends_with? - work as per name
"foo".starts_with?("f") # => true
"foo".ends_with?("o")   # => true

#indent - provide space before word in new line where word is return
"foo\n\nbar".indent(2) # => "  foo\n\n  bar"
"foo\n\nbar".indent(2, nil, true) # => "  foo\n  \n  bar" here provide space before every line empty or not

#at(position) - return character based on position
"hello".at(0)  # => "h"
"hello".at(10) # => nil
"hello".at(-1) # => "o"

#from(position) - give all character form that position
"hello".from(0)  # => "hello"
"hello".from(2)  # => "llo"
"hello".from(-2) # => "lo"
"hello".from(10) # => nil

#to(position) - give all charecter before that position
"hello".to(0)  # => "h"
"hello".to(2)  # => "hel"
"hello".to(-2) # => "hell"
"hello".to(10) # => "hello"

#first(limit = 1) give first charcter based on limit
"hello".first(0) # ""
"hello".first(1) # "h"
"hello".first(2) # "he"

#last(limit = 1) give last charcter based on limit
"hello".last(0) # ""
"hello".last(1) # "o"
"hello".last(2) # "lo"

#pluralize - give pluralize form 
"table".pluralize     # => "tables"
"ruby".pluralize      # => "rubies"
"equipment".pluralize # => "equipment"
"dude".pluralize(1)   # => "dude" for 1 it will give singuler form. for other values it will give plural

#singularize - give singuler form 
"tables".singularize    # => "table"
"rubies".singularize    # => "ruby"
"equipment".singularize # => "equipment"

#camelize  - camele case
"product".camelize                # => "Product"
"admin_user".camelize             # => "AdminUser"
"backoffice/session".camelize     # => "Backoffice::Session"  
"visual_effect".camelize(:lower)  # => "visualEffect"

#underscore
"Product".underscore              # => "product"
"AdminUser".underscore            # => "admin_user"
"Backoffice::Session".underscore  # => "backoffice/session"
"visualEffect".underscore         # => "visual_effect"

#titleize - capitlize word.
"alice in wonderland".titleize    # => "Alice In Wonderland"
"fermat's enigma".titleize        # => "Fermat's Enigma"

#dahserize - replace underscore with dash
"name".dasherize         # => "name"
"contact_data".dasherize # => "contact-data"

#demodulize - remove left most part which is module
"Product".demodulize                        # => "Product"
"Backoffice::UsersController".demodulize    # => "UsersController"
"Admin::Hotel::ReservationUtils".demodulize # => "ReservationUtils"
"::Inflections".demodulize                  # => "Inflections"
"".demodulize                               # => ""

#deconstantize - remove right most part 
"Product".deconstantize                        # => ""
"Backoffice::UsersController".deconstantize    # => "Backoffice"
"Admin::Hotel::ReservationUtils".deconstantize # => "Admin::Hotel" 

#parameterize
"John Smith".parameterize # => "john-smith"
"Kurt Gödel".parameterize # => "kurt-godel"
#preserve_case means no change in string
"John Smith".parameterize(preserve_case: true) # => "John-Smith"
"Kurt Gödel".parameterize(preserve_case: true) # => "Kurt-Godel"
#separator is used for provide separator between word.
"John Smith".parameterize(separator: "_") # => "john_smith"
"Kurt Gödel".parameterize(separator: "_") # => "kurt_godel"

#tableize provide pluralize after underscore if there is.
"Person".tableize      # => "people"
"Invoice".tableize     # => "invoices"
"InvoiceLine".tableize # => "invoice_lines"

#classify inverse of tableize
"people".classify        # => "Person"
"invoices".classify      # => "Invoice"
"invoice_lines".classify # => "InvoiceLine"

#humanize - Removes a "_id" suffix if present.Replaces underscores with spaces, if any.Downcases all words except acronyms,Capitalizes the first word
"name".humanize                         # => "Name"
"author_id".humanize                    # => "Author"
"author_id".humanize(capitalize: false) # => "author"
"comments_count".humanize               # => "Comments count"
"_id".humanize                          # => "Id"

#foreign_key -  gives a foreign key column name from a class name.
"User".foreign_key           # => "user_id"
"InvoiceLine".foreign_key    # => "invoice_line_id"
"Admin::Session".foreign_key # => "session_id"

#conversions
"2010-07-27".to_date                  # => Tue, 27 Jul 2010
"2010-07-27 23:37:00".to_time         # => 2010-07-27 23:37:00 +0200
"2010-07-27 23:37:00".to_datetime     # => Tue, 27 Jul 2010 23:37:00 
"2010-07-27 23:42:00".to_time(:utc)   # => 2010-07-27 23:42:00 UTC
"2010-07-27 23:42:00".to_time(:local) # => 2010-07-27 23:42:00 

#extention to symbol
:foo.starts_with?("f") # => true
:foo.ends_with?("o")   # => true

#extention to  numeric
#byte convertion - singuler allow kilobyte
2.kilobytes   # => 2048
3.megabytes   # => 3145728
3.5.gigabytes # => 3758096384
-4.exabytes   # => -4611686018427387904  

#time
1.day.from_now              #=> give tommorow date, days or day are same 
1.week.from_now             # give date of tomorrow, week or weeks are same
(4.days + 5.weeks).from_now # give date of after 9 week

#formatting
5551234.to_fs(:phone)
# => 555-1234
1235551234.to_fs(:phone)
# => 123-555-1234
1235551234.to_fs(:phone, area_code: true)
# => (123) 555-1234
1235551234.to_fs(:phone, delimiter: " ")  #delimiter will provide content of space or only space.
# => 123 555 1234
1235551234.to_fs(:phone, area_code: true, extension: 555)
# => (123) 555-1234 x 555
1235551234.to_fs(:phone, country_code: 1) #also add country code
# => +1-123-555-1234

#currency
1234567890.50.to_fs(:currency)                  # => $1,234,567,890.50 
1234567890.506.to_fs(:currency)                 # => $1,234,567,890.51
1234567890.506.to_fs(:currency, precision: 3)   # => $1,234,567,890.506 #precision is defind by default it is 2.
100.to_fs(:percentage)
# => 100.000%
389.32314.to_fs(:rounded, precision: 0)         # => 389
111.2345.to_fs(:rounded)                        # => 111.235 

#human size will give number into bytes size 
23.to_fs(:human_size)                   # => 123 Bytes
1234.to_fs(:human_size)                 # => 1.21 KB
12345.to_fs(:human_size)                # => 12.1 KB
1234567.to_fs(:human_size)              # => 1.18 MB
1234567890.to_fs(:human_size)           # => 1.15 GB

#human give in number into currency
123.to_fs(:human)               # => "123"
1234.to_fs(:human)              # => "1.23 Thousand"
12345.to_fs(:human)             # => "12.3 Thousand"
1234567.to_fs(:human)           # => "1.23 Million"

#Extensions to Integer
#multiple_of? chack whether it is multiply with it or not.
20.multiple_of?(4) # => true

#ordinal give ordinal string of number
1.ordinal    # => "st"
2.ordinal    # => "nd"
53.ordinal   # => "rd"
2009.ordinal # => "th"

#ordinalize give number with its string  
1.ordinalize    # => "1st"
2.ordinalize    # => "2nd"
53.ordinalize   # => "53rd"

#time
1.month.from_now  #give time 1 month from now
1.year.from_now   #give time 1 year from now

#Extensions to BigDecimal
BigDecimal(5.00, 6).to_s       # => "5.0" here 6 means it allow total 6 significint digits include all digits
BigDecimal(5.00, 6).to_s("e")  # => "0.5E1"

#Extensions to Enumerable
[1, 2, 3].sum # => 6
(1..100).sum  # => 5050
[[1, 2], [2, 3], [3, 4]].sum    # => [1, 2, 2, 3, 3, 4]
%w(foo bar baz).sum             # => "foobarbaz"
{a: 1, b: 2, c: 3}.sum          # => [:a, 1, :b, 2, :c, 3]

#customize bydefault sum
[].sum    # => 0
[].sum(1) # => 1
(1..5).sum {|n| n * 2 } # => 30
[2, 4, 6, 8, 10].sum    # => 30

#many? The method many? is shorthand for collection.size > 1:
# <% if pages.many? %>
#   <%= pagination_links %>
# <% end %>

#exclude? - check whether the value is not there
[ 1, 2, 3 ].exclude?(3)                                         #false. is it not there in list
[ 1, 2, 3 ].including(4, 5)                                     # => [ 1, 2, 3, 4, 5 ]
["David", "Rafael", "Aaron", "Todd"].excluding("Aaron", "Todd") # => ["David", "Rafael"]

#pluck - give all value of that  key name
[{ name: "David" }, { name: "Rafael" }, { name: "Aaron" }].pluck(:name) # => ["David", "Rafael", "Aaron"]
[{ id: 1, name: "David" }, { id: 2, name: "Rafael" }].pluck(:id, :name) # => [[1, "David"], [2, "Rafael"]]

#pick - it just like pluck but it will give only first record data of that key.

#Extensions to Array
%w(a b c d).to(2)     # => ["a", "b", "c"] - up to index 2
%w(a b c d).from(2)   # => ["c", "d"] - from index 2

#including
[ 1, 2, 3 ].including(4, 5)          # => [ 1, 2, 3, 4, 5 ]
[ [ 0, 1 ] ].including([ [ 1, 0 ] ]) # => [ [ 0, 1 ], [ 1, 0 ] ]

#find_position  
%w(a b c d).third # => "c"
%w(a b c d).fifth # => nil

#to_sentence is create sentance of string array
%w(Earth Wind).to_sentence      # => "Earth and Wind"
%w(Earth Wind Fire).to_sentence # => "Earth, Wind, and Fire"

#to_fs here every string came from id that id will be printed.
[].to_fs(:db)            # => "null"
[user].to_fs(:db)        # => "8456"
invoice.lines.to_fs(:db) # => "23,567,556,12"

#Wrapping - return array
Array.wrap(nil)       # => []
Array.wrap([1, 2, 3]) # => [1, 2, 3]
Array.wrap(0)         # => [0]

#Grouping - divide array on group
[1, 2, 3].in_groups_of(2)         # => [[1, 2], [3, nil]]
[1, 2, 3].in_groups_of(2, 0)      # => [[1, 2], [3, 0]]
[1, 2, 3].in_groups_of(2, false)  # => [[1, 2], [3]]
%w(1 2 3 4 5 6 7).in_groups(3)    # => [["1", "2", "3"], ["4", "5", nil], ["6", "7", nil]]

#split - split in array on given value
(-5..5).to_a.split { |i| i.multiple_of?(4) } # => [[-5], [-3, -2, -1], [1, 2, 3], [5]]
[0, 1, -5, 1, 1, "foo", "bar"].split(1)      # => [[0], [-5], [], ["foo", "bar"]]

#extention to hash
#Conversions to_xml
{"foo" => 1, "bar" => 2}.to_xml #convert hash to xml.
# =>
# <?xml version="1.0" encoding="UTF-8"?>
# <hash>
#   <foo type="integer">1</foo>
#   <bar type="integer">2</bar>
# </hash>

#merging - here in merge only one will win either a=0 or a=1
{a: 1, b: 1}.merge(a: 0, c: 2)
# => {:a=>0, :b=>1, :c=>2}

#deep merging - here in deep merging both key will be accpetable
{a: {b: 1}}.deep_merge(a: {c: 2})
# => {:a=>{:b=>1, :c=>2}}

#deep duplicating won't allow you to 
hash = { a: 1, b: { c: 2, d: [3, 4] } }

dup = hash.deep_dup
dup[:b][:e] = 5
dup[:b][:d] << 5

hash[:b][:e] == nil       # => true
hash[:b][:d] == [3, 4]    # => true

#working eith keys
#except and except!
{a: 1, b: 2}.except(:a)   # => {:b=>2} except will remove key with value if present

#with inddifferent access  will mathch string or non string
{a: 1}.with_indifferent_access.except(:a)  # => {}
{a: 1}.with_indifferent_access.except("a") # => {}

#stringify_keys and stringify_keys! - return  string version of key
{nil => nil, 1 => 1, a: :a}.stringify_keys
# => {"" => nil, "1" => 1, "a" => :a}
{"a" => 1, a: 2}.stringify_keys #in case of collision
# The result will be
# => {"a"=>2}

#symbolize_keys and symbolize_keys!
{nil => nil, 1 => 1, "a" => "a"}.symbolize_keys
# => {nil=>nil, 1=>1, :a=>"a"}

#in collision it will remove one
{"a" => 1, a: 2}.symbolize_keys


#Working with Values - deep_transform_values
hash = { person: { name: 'Rob', age: '28' } }
hash.deep_transform_values{ |value| value.to_s.upcase }
# => {person: {name: "ROB", age: "28"}}

#slicing - replace the only given key in hash 
hash = {a: 1, b: 2}
rest = hash.slice!(:a)  # => {:b=>2}
hash                    # => {:a=>1}

#Extensions to Range
#with to_s
(Date.today..Date.tomorrow).to_s
# => "2009-10-25..2009-10-26"

(Date.today..Date.tomorrow).to_s(:db)
# => "BETWEEN '2009-10-25' AND '2009-10-26'"

#=== and include? -  almos same
(1..10) === (3..7)  # => true
(1..10) === (0..7)  # => false
(1..10) === (3..11) # => false
(1...9) === (3..9)  # => false

(1..10).include?(3..7)  # => true
(1..10).include?(0..7)  # => false
(1..10).include?(3..11) # => false
(1...9).include?(3..9)  # => false

#overlaps? - it will check is there any interatction between this ranges
(1..10).overlaps?(7..11)  # => true
(1..10).overlaps?(0..7)   # => true
(1..10).overlaps?(11..27) # => false

#Extensions to Date
Date.current    #today date
Date.yesterday  #yesterday date
Date.tomorrow   #tomorrow date

#Named dates here all d are depend on first d.
d = Date.new(2010, 5, 8)     # => Sat, 08 May 2010
d.beginning_of_week          # => Mon, 03 May 2010
d.beginning_of_week(:sunday) # => Sun, 02 May 2010
d.end_of_week                # => Sun, 09 May 2010
d.end_of_week(:sunday)       # => Sat, 08 May 2010
d.end_of_week(:saturday)     # => Sat, 07 May 2010  
#only sunday and monday method are there.
d = Date.new(2010, 5, 8)     # => Sat, 08 May 2010
d.monday                     # => Mon, 03 May 2010
d.sunday                     # => Sun, 09 May 2010
d.next_week               # => Mon, 10 May 2010
d.next_week(:saturday)    # => Sat, 15 May 2010
d.prev_week(:friday)      # => Fri, 30 Apr 2010
#for month
d = Date.new(2010, 5, 9)  # => Sun, 09 May 2010
d.beginning_of_month      # => Sat, 01 May 2010
d.end_of_month            # => Mon, 31 May 2010
#for the year
d = Date.new(2010, 5, 9)  # => Sun, 09 May 2010
d.beginning_of_year       # => Fri, 01 Jan 2010
d.end_of_year             # => Fri, 31 Dec 2010
date = Date.new(2010, 6, 7)
date.years_ago(10)        # => Wed, 07 Jun 2000 - before
date.years_since(10)      # => Sun, 07 Jun 2020 - after
Date.new(2010, 4, 30).months_ago(2)   # => Sun, 28 Feb 2010
Date.new(2010, 4, 30).months_since(2) # => Wed, 30 Jun 2010
Date.new(2010, 5, 24).weeks_ago(1)    # => Mon, 17 May 2010
Date.new(2010, 5, 24).weeks_ago(2)    # => Mon, 10 May 2010

#duration
d = Date.current
# => Mon, 09 Aug 2010
d + 1.year
# => Tue, 09 Aug 2011
d - 3.hours
# => Sun, 08 Aug 2010 21:00:00 UTC +00:00

#timestamps
date = Date.new(2010, 6, 7)
date.beginning_of_day     # => Mon Jun 07 00:00:00 +0200 2010
date.end_of_day           # => Mon Jun 07 23:59:59 +0200 2010
date = DateTime.new(2010, 6, 7, 19, 55, 25)
date.beginning_of_hour    # => Mon Jun 07 19:00:00 +0200 2010
date.end_of_hour          # => Mon Jun 07 19:59:59 +0200 2010
date.beginning_of_minute  # => Mon Jun 07 19:55:00 +0200 2010
date.end_of_minute        # => Mon Jun 07 19:55:00 +0200 2010

ate = Date.current  # => Fri, 11 Jun 2010
date.ago(1)         # => Thu, 10 Jun 2010 23:59:59 EDT -04:00 returns a timestamp those many seconds ago from midnight
date.since(1)       # => Fri, 11 Jun 2010 00:00:01 EDT -04:00

#utc and utc?
now = DateTime.current  # => Mon, 07 Jun 2010 19:27:52 -0400
now.utc                 # => Mon, 07 Jun 2010 23:27:52 +0000
now.utc?                # => false
now.utc.utc?            # => true

#changeing components - change date time based on argument start from 00:00:00 +0000
now.change(hour: 1) 
now.change(min: 1)

#duration - object can be add or subtracted from datetime
now = DateTime.current
# => Mon, 09 Aug 2010 23:15:17 +0000
now + 1.year
# => Tue, 09 Aug 2011 23:15:17 +0000
now - 1.week
# => Mon, 02 Aug 2010 23:15:17 +0000

#extention to time 
now = Time.current
# => Mon, 09 Aug 2010 23:20:05 UTC +00:00
now.all_week
# => Mon, 09 Aug 2010 00:00:00 UTC +00:00..Sun, 15 Aug 2010 23:59:59 UTC +00:00
now.all_week(:sunday)
# => Sun, 16 Sep 2012 00:00:00 UTC +00:00..Sat, 22 Sep 2012 23:59:59 UTC +00:00
now.all_month
# => Sat, 01 Aug 2010 00:00:00 UTC +00:00..Tue, 31 Aug 2010 23:59:59 UTC +00:00
now.all_quarter
# => Thu, 01 Jul 2010 00:00:00 UTC +00:00..Thu, 30 Sep 2010 23:59:59 UTC +00:00
now.all_year
# => Fri, 01 Jan 2010 00:00:00 UTC +00:00..Fri, 31 Dec 2010 23:59:59 UTC +00:00

#prev_day, next_day
t = Time.new(2010, 5, 8) # => 2010-05-08 00:00:00 +0900
t.prev_day               # => 2010-05-07 00:00:00 +0900
t.next_day               # => 2010-05-09 00:00:00 +0900
t.prev_month             # => 2010-04-08 00:00:00 +0900
t.next_month             # => 2010-06-08 00:00:00 +0900
t.prev_year              # => 2009-05-08 00:00:00 +0900
t.next_year              # => 2011-05-08 00:00:00 +0900
t.prev_quarter           # => 2010-02-08 00:00:00 +0200
t.next_quarter           # => 2010-08-08 00:00:00 +0300

#extention to file
#atomic_write - method that allows you to write to a file in an atomic way, which means that the write operation is guaranteed to either succeed or fail completely.

#existence
#The existence method returns the receiver if the named file exists otherwise returns +nil+. It is useful for idioms like this:

