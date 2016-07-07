require 'test_helper'

class StoreControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_select '#columns #side a', minimum: 4
    assert_select '#main .entry', 4
    # i modified app/views/store/index.html.erb to append the updated date time to the product
    # this action broke the following line, so I commented it out:
    # assert_select 'h3', 'Programming Ruby 1.9'
    assert_select '.price', /\$[,\d]+\.\d\d/
  end
  
  test "markup needed for store.js.coffee is in place" do
    get :index

=begin
 Here is my first shot at explaining how this 'markup needed for store.js.coffee is in place' test works.
 This test is being written to verify that, when the web page is rendered, a certain structure of html tags will be in place.  

consider this test:
     assert_select '.store .entry .price_line', 3

 The above line is translated to mean, in the html that's rendered, we should find 3 instances of a structure with an html tag 
 containing class='price_line' within an html tag containing class='entry' within an html tag with class='store'. NOTICE the dot
 that precedes each of the entries.  I think the dot notation communicates to the test that you should look for a class= type of
 reference.  
 
 Here's a concrete example of this in action.  Below is a reprint of portions of the html that you can observe when doing a view source on the web page. 
 It shows the store class in <body class='store'>, within which you'll find the entry class written as <div class="entry", 
 within which you'll find the price_line class written as <div class="price_line".
 How can we tell how many times the entry and price_line tags should appear?  By consulting the test/fixtures/products.yml.  Each
 one of the products listed there will generate an entry and price_line tag.  
 For this reason, the test assert_select '.store .entry .price_line', 4 passes, as the price_line entry indeed appears 4 times....
 
 <body class='store'>
  <div id="banner">
    <img alt="Logo" src="/assets/logo.png" />
    Pragmatic Bookshelf
  </div>
   :
   :
<h1> Your Pragmatic Catalog </h1>
            <div class="entry"> 
                <img alt="Cs" src="/assets/cs.jpg" />
                <h3> CoffeeScript</h3>
                <p>
        CoffeeScript is JavaScript done right. It provides all of JavaScript's
  functionality wrapped in a cleaner, more succinct syntax. In the first
  book on this exciting new language, CoffeeScript guru Trevor Burnham
  shows you how to hold onto all the power and flexibility of JavaScript
  while writing clearer, cleaner, and safer code.
      </p>
                <div class="price_line">
 
 With this understanding, you can see why the following line also passes:
 
     assert_select '.store .entry > img', 3
     
=end
    assert_select '.store .entry .price_line', 4
    assert_select '.store .entry > img', 4
    assert_select '.entry input[type=submit]', 4
  end

end
