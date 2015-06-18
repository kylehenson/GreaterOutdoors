class EchonestService
  attr_reader :connection

  def initialize
    @connection = Hurley::Client.new("http://developer.echonest.com/api/v4")
  end

  def fetch_playlist(min_tempo, max_tempo, song_count)
    parse(connection.get("song/search?api_key=#{ENV['ECHONEST_API_KEY']}&song_min_hotttnesss=.8&min_tempo=#{min_tempo}&max_tempo=#{max_tempo}&sort=tempo-asc&results=#{song_count}"))
  end

  # def create_playlist(params)
  #   playlist_params = PlaylistParser.parse()
  # end


#   def create_school(params)
#   parse(connection.post("schools", params).body)
# end


  private

  def parse(response)
    JSON.parse(response.body)
  end

end

##Examples

#Echonest.service.tracks("&song_min_hotttnesss=.7&min_tempo=120&max_tempo=140&sort=tempo-asc&results=100")['response']['songs']



  #Echonest.service.track_by_tempo("&title=delilah&artist=Florence")['response']
   #=> {"status"=>{"version"=>"4.2", "code"=>0, "message"=>"Success"}, "songs"=>[{"artist_id"=>"ARNCHOP121318C56B8", "id"=>"SOETEOJ14D30157D02", "artist_name"=>"Florence + The Machine", "title"=>"Delilah"}]}

  #Echonest.service.track_by_tempo("&title=delilah&artist=Florence")['response']['songs'].first['artist_name']
   #=> "Florence + The Machine"

# http://developer.echonest.com/api/v4/song/search?
# api_key=FILDTEOIK2HBORODV&format=json&results=1&artist=radiohead&title=karma%20police
#
# http://developer.echonest.com/api/v4/song/search?
# api_key=FILDTEOIK2HBORODV&style=rock&min_danceability=0.65&min_tempo=140&results=5



##Example of searching for songs with a min tempo(min_tempo=140 starts with the one closest to 140 and moves up(min)) based on song hotness
#Echonest.service.tracks("&song_min_hotttnesss=.8&min_tempo=140&sort=tempo-asc&results=5")['response']
 #=> {"status"=>{"version"=>"4.2", "code"=>0, "message"=>"Success"},
      #"songs"=>[{"artist_id"=>"ARS54I31187FB46721", "id"=>"SOBKXBH147EC141A24", "artist_name"=>"Taylor Swift", "title"=>"Shake It Off"},
                #{"artist_id"=>"ARSDWSZ122ECCB706A", "id"=>"SOSACAB14A63CF325C", "artist_name"=>"Ed Sheeran", "title"=>"Thinking Out Loud"}]}



##Example of searching with min tempo, sorting by tempo, sorting by artist familiarity, and returning 5 results
#Echonest.service.tracks("&min_tempo=140&sort=tempo-desc&sort=artist_familiarity-desc&results=5")['response']['songs'].each { |track| puts track['artist_name'] }
#The Beatles
#The Beatles
#The Beatles
#The Beatles
#The Beatles
# => [{"artist_id"=>"AR6XZ861187FB4CECD", "id"=>"SOVCDNX13D62FD2AA8", "artist_name"=>"The Beatles", "title"=>"Shimmy Like Kate (Live)"},
  #{"artist_id"=>"AR6XZ861187FB4CECD", "id"=>"SOVBSNR146FED7C442", "artist_name"=>"The Beatles", "title"=>"She Loves You (Live On Easy Beat Show, October 20, 1963)"},
  #{"artist_id"=>"AR6XZ861187FB4CECD", "id"=>"SOVTVVB12C0DDBC858", "artist_name"=>"The Beatles", "title"=>"SHE'S A WOMAN (BBC)"},
  #{"artist_id"=>"AR6XZ861187FB4CECD", "id"=>"SOWHRWF12C0DCFEE18", "artist_name"=>"The Beatles", "title"=>"George Harrison"},
  #{"artist_id"=>"AR6XZ861187FB4CECD", "id"=>"SOWDRLG12C0DCFEE15", "artist_name"=>"The Beatles", "title"=>"George Harrison"}]

##Example of checking the tempo of a specific track
#Echonest.service.tracks("&artist=the+beatles&title=Shimmy+Like+Kate+(Live)&bucket=audio_summary")['response']
 #=> {"status"=>{"version"=>"4.2", "code"=>0, "message"=>"Success"},
   #"songs"=>[{"artist_id"=>"AR6XZ861187FB4CECD", "artist_name"=>"The Beatles", "id"=>"SOVCDNX13D62FD2AA8",
              #"audio_summary"=>{"key"=>2, "analysis_url"=>"http://echonest-analysis.s3.amazonaws.com/TR/rBWA8g24Wlfhpn7EJDIH5jJFj3yXMopqSANARRItJw8zdFynPxnzZ7yD45Apv_tJrdPcuP_A2abc4BGu0%3D/3/full.json?AWSAccessKeyId=AKIAJRDFEY23UEVW42BQ&Expires=1434576222&Signature=ah6JiqNx6Fbv/4qK52CnrbMpx0U%3D",
                #"energy"=>0.918329, "liveness"=>0.860531, "tempo"=>158.267, "speechiness"=>0.123071, "acousticness"=>0.568146, "instrumentalness"=>0.881825, "mode"=>1, "time_signature"=>4, "duration"=>195.33288, "loudness"=>-10.526, "audio_md5"=>"37835c12a5d9a77395ef1c1516d4381e", "valence"=>0.555744, "danceability"=>0.292342}, "title"=>"Shimmy Like Kate (Live)"}]}
