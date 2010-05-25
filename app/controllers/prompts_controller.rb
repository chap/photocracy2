class PromptsController < ActionController::Base
  def vote
    @prompt = Prompt.find(params[:id], :params => {:question_id => params[:question_id]})
    
    if params[:direction] &&
       vote = @prompt.post("vote_#{params[:direction]}".to_sym,
                           :question_id => params[:question_id],
                           :format => :json,
                           # have to nest this because of 
                           # prompts#vote_direction in pairwise
                           :params => {
                             :auto => request.session_options[:id], 
                             :time_viewed => "5936", 
                             :appearance_lookup => "0e0d7325aadff0110725fa46c91129be"
                           }
                          )
		  puts vote
		  # "params"=>{"appearance_lookup"=>"0e0d7325aadff0110725fa46c91129be", "time_viewed"=>"5936", "auto"=>"6ad13dbd516c3256b3dcc185dc76a4a6"}
      # newprompt = Crack::XML.parse(p.body)['prompt']
      # 
      # leveling_message = Visitor.leveling_message(:votes => newprompt['visitor_votes'].to_i,
      # :ideas => newprompt['visitor_ideas'].to_i)
      # 
      # logger.info "newprompt is #{newprompt.inspect}"
      # render :json => {:votes => 20, :newleft => truncate((newprompt['left_choice_text']), :length => 137), 
      # :newright => truncate((newprompt['right_choice_text']), :length => 137), 
      # :leveling_message => leveling_message,
      # :prompt_id => newprompt['id'],
      # :appearance_lookup => newprompt['appearance_id']
      # }.to_json
      render :text => "it worked"
    else
      #render :json => vote.errors, :status => :unprocessable_entity
      render :text => 'error', :status => :unprocessable_entity
    end
  end
end
