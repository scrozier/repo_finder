require 'httparty'

token = ''
response = HTTParty.get('https://api.github.com/repositories',
                        :headers => {
                          'User-Agent' => 'RepoFinder'
                        }
                       )
puts response
