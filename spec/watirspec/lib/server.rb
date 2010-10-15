# encoding: utf-8
class WatirSpec::Server < Sinatra::Base

  def self.run!
    Thread.abort_on_exception = true
    
    running = false
    thr = Thread.new do
      detect_rack_handler.run(self, :Host => host, :Port => port) do
        running = true
      end
    end
    sleep 0.1 until running
  end

  def self.free_port_starting_at(no)
    until free_port?(no)
      no += 1
    end
    no
  end
  
  def self.free_port?(no)
    s = TCPServer.new(host, no)
    s.close
    true
  rescue SocketError, Errno::EADDRINUSE
    false
  end
  
  set :public,      WatirSpec.fixture_path
  set :static,      true
  set :run,         false
  set :environment, :production
  set :host,        'localhost'
  set :port,        free_port_starting_at(2000)
  set :server,      %w[mongrel webrick]

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
