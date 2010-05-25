class PromptsController < ActionController::Base
  def vote
    voted_prompt = Prompt.find(params[:id], :params => {:question_id => params[:question_id]})
    
    if params[:direction] &&
      vote = voted_prompt.post("vote_#{params[:direction]}".to_sym,
        :question_id => params[:question_id],
        :params => {
          :auto => request.session_options[:id],
          :time_viewed => params[:time_viewed],
          :appearance_lookup => params[:appearance_lookup]
        }
      )

      next_prompt = Crack::XML.parse(vote.body)['prompt']
      logger.info(next_prompt.inspect)
      render :json => {
        :right_choice_text => next_prompt['right_choice_text'],
        :left_choice_text  => next_prompt['left_choice_text'],
        :right_choice_id   => next_prompt['right_choice_id'],
        :left_choice_id    => next_prompt['left_choice_id'],
        :visitor_votes     => next_prompt['visitor_votes'],
        :appearance_lookup => next_prompt['appearance_id'],
        :prompt_id         => next_prompt['id'],
        :question_id       => params[:question_id],
        :show_prompt_path  => question_prompt_path(params[:question_id], next_prompt['id'])
      }.to_json
    else
      render :text => 'Vote unsuccessful.', :status => :unprocessable_entity
    end
  end

  def show
    respond_to do |format|
      format.js {
        @right_choice_photo = Photo.find(params['right_choice_text'])
        @left_choice_photo = Photo.find(params['left_choice_text'])
        @left_choice_id = params['left_choice_id']
        @right_choice_id = params['left_choice_id']

        @prompt = Prompt.find(params['id'], :params => {:question_id => params[:question_id]})
        @question = Question.find(params[:question_id])

        render :partial => 'questions/prompt'
      }
    end
  end
end
