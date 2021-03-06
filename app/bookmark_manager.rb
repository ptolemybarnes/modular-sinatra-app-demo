require 'sinatra/base'
require 'data_mapper'
require 'rack-flash'
require 'sinatra/partial'
require_relative 'models/link'
require_relative 'models/tag'
require_relative 'models/user'
require_relative 'helpers/application'
require_relative 'data_mapper_setup'

require_relative 'controllers/base'
require_relative 'controllers/users'
require_relative 'controllers/tags'
require_relative 'controllers/links'
require_relative 'controllers/sessions'
require 'byebug'

module BookmarkManager
  class Application < Sinatra::Application
    enable :sessions
    set :session_secret, 'super secret'
    use Rack::Flash
    use Rack::MethodOverride

    use Routes::Links
    use Routes::Users
    use Routes::Sessions
    use Routes::Tags


    set :partial_template_engine, :erb
    set :views, Proc.new { File.join('app', 'views') }

    get '/' do
      @links = Link.all
      erb :index
    end

    def current_user
      @current_user ||= User.get(session[:user_id]) if session[:user_id]
    end
  end
end




