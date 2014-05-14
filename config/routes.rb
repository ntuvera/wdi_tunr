Rails.application.routes.draw do

 root 'welcome#index'

 get 'songs/search' =>'songs#search'
end
