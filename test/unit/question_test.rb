require 'test_helper'

class QuestionTest < ActiveSupport::TestCase

 # in order to make this work, the test server has to be running:
	# export RAILS_ENV=test && ./script/server 4000

  should "be valid with factories" do
    q = Question.new(Factory.attributes_for(:question)) # we'll probably have to use this method for active resource objects
    assert_valid q
  end
  
  should "validate urls correctly" do
    ['contains aspace', "", "bals@bla", "test/this", "askdf|", "=sdkjfs", ' '].each do |url|
    	q = Question.new(Factory.attributes_for(:question, :url => url)) 
    	assert !q.valid?
    end

  end
  
  should "validate names correctly" do
      q = Question.new(Factory.attributes_for(:question, :name  => "")) 
      assert !q.valid?
  end
  
  should "not have a url of an existing question" do
    e = Factory.create(:earl)
    q = Question.new(Factory.attributes_for(:question, :url => e.name))
    assert !q.valid?
  end

end

