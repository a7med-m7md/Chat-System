Rails.application.routes.draw do
  resources :applications do
    resources :chats do
      get "/messages/search", to: 'messages#search'
      resources :messages
    end
  end
end

# Rails.application.routes.draw do  
#   post "/messages/:application_id/:number" => "messages#create"
#   # get "/messages/:application_id/:number" => "messages#show"
#   get "/messages/:chat_id/:content" => "messages#search"
#   # resources :messages
#   get "/chats/:application_id/:number" => "chats#show"
#   get "/chats/:application_id/" => "chats#index"
#   post "/chats/:application_id" => "chats#create"
#   #resources :chats
#   resources :applications
#   # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
#   root "applications#index"
# end
