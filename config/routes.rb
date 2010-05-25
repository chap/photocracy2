ActionController::Routing::Routes.draw do |map|
  map.resource :session, :controller => "clearance/sessions", :only => [:new, :create, :destroy]
  map.signin '/sign_in', :controller => "clearance/sessions", :action => :new
  map.signout '/sign_out', :controller => "clearance/sessions", :action => :destroy
  map.resource :passwords, :controller => "clearance/passwords"

  map.resources :questions, 
                :member => {
                  :skip => :post, 
                  :add_idea => :post, 
                  :toggle => :post, 
                  :toggle_autoactivate => :post, 
			            :delete_logo => :delete
			            }  do |questions|
			          questions.resources :prompts,
			            :member => {
			              :vote => :post
			            }
	end
  map.resources :earls, :only => [:export_list], :collection => {:export_list=> :get}
  map.resources :clicks, :collection => {:export=> :get}
  #map.connect '/questions/:question_id/choices/:id', :controller => 'choices', :action => 'show'
  map.activate_choice '/:question_id/choices/:id/activate', :controller => 'choices', :action => 'activate'
  map.deactivate_choice '/:question_id/choices/:id/deactivate', :controller => 'choices', :action => 'deactivate'
  map.toggle_choice_status '/questions/:earl_id/choices/:id/toggle.:format', :controller => 'choices', :action => 'toggle', :conditions => { :method => :post }
  
  map.about '/about', :controller => 'home', :action => 'about'
  map.admin '/admin', :controller => 'home', :action => 'admin'
  map.privacy '/privacy', :controller => 'home', :action => 'privacy'
  map.tour '/tour', :controller => 'home', :action => 'tour'
  map.example '/example', :controller => 'home', :action => 'example'
  map.connect '/signup', :controller => 'users', :action => 'new'
  map.root :controller => 'home', :action => 'index'
  #map.toggle_question '/questions/:id/toggle', :controller => 'questions'
  map.abingoTest "/abingo/:action/:id", :controller=> :abingo_dashboard
  map.googletracking "/no_google_tracking", :controller=> :home, :action => :no_google_tracking
   
  
  map.connect '/:id', :controller => 'earls', :action => 'show'
  map.connect '/:id/:action', :controller => 'questions'
  map.connect '/:question_id/choices/:id', :controller => 'choices', :action => 'show'
  

  # rake routes
  # http://guides.rubyonrails.org/routing.html
end
