# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

def movies_pods 
  pod 'Kingfisher'
  pod 'Moya'
end

target 'Movies' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  movies_pods

  target 'MoviesTests' do
    inherit! :search_paths
        movies_pods
  end

  target 'MoviesUITests' do
    movies_pods
  end

end
