# encoding: utf-8
require 'sinatra/base'

class WatirSpec::Server < ::Sinatra::Base

  set :app_file,    __FILE__
  set :root,        File.dirname(__FILE__)
  set :public,      lambda { File.join(root, 'fixtures')}
  set :static,      true
  set :run,         false
  set :environment, :production
  set :bind,        'localhost'
  set :port,        2000
  set :server,      %w[thin mongrel webrick]

  get '/' do
    self.class.name
  end

  get '/big' do
    Class.new do
      def each(&blk)
        yield "<html><head><title>Big Content</title></head><body>"
        string = "hello "*205
        300.times { yield string }
        yield "</body></html>"
      end
    end.new
  end

  post '/post_to_me' do
    "You posted the following content:\n#{ env['rack.input'].read }"
  end

  get '/plain_text' do
    content_type 'text/plain'
    'This is text/plain'
  end

  get '/ajax' do
    sleep 10
    "A slooow ajax response"
  end

  get '/charset_mismatch' do
    content_type 'text/html; charset=UTF-8'
    %{
      <html>
        <head>
          <meta http-equiv="Content-type" content="text/html; charset=iso-8859-1" />
        </head>
        <body>
          <h1>ø</h1>
        </body>
      </html>
    }
  end

  get '/octet_stream' do
    content_type 'application/octet-stream'
    'This is application/octet-stream'
  end

  get '/set_cookie' do
    content_type 'text/plain'
    headers 'Set-Cookie' => "monster=/"

    "C is for cookie, it's good enough for me"
  end

  get '/header_echo' do
    content_type 'text/plain'
    env.inspect
  end

  get '/authentication' do
    auth = Rack::Auth::Basic::Request.new(env)

    unless auth.provided? && auth.credentials == %w[foo bar]
      headers 'WWW-Authenticate' => %(Basic realm="localhost")
      halt 401, 'Authorization Required'
    end

    "ok"
  end

  get '/encodable_<stuff>' do
    'page with characters in URI that need encoding'
  end

end
