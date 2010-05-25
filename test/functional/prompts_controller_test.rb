require 'test_helper'

class PromptsControllerTest < ActionController::TestCase
  def setup
    @question = Question.find(1)
    @prompt = Prompt.find(1, :params => {:question_id => 1})
  end
  
  test "should return success if posting to prompts#vote with prompt, question, and direction" do
    post :vote, :id => @prompt.id, :question_id => @question.id, :direction => :right
    assert_response :success
  end
  
  test "should return errors if posting to prompts#vote with prompt, question, but without direction" do
    post :vote, :id => @prompt.id, :question_id => @question.id
    assert_response 422 # ActiveResource::ResourceInvalid (rescued by save as validation errors)
  end
end