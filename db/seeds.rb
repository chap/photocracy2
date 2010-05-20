@user = User.create(:email => 'chapambrose@gmail.com', 
                    :password => 'password', 
                    :password_confirmation => 'password')
                   
@question = Question.create(:name => 'Which photo is more Philly?',
                            :url => 'philly',
                            :local_identifier => @user.id,
                            :visitory_identifier => 123,
                            :ideas => ' ')

@user.earls.create(:question_id => @question.id,
                   :name => @question.url)