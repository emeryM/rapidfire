Rapidfire::Engine.routes.draw do

  get 'send_share_email', to: 'question_groups#send_share_email'

  resources :question_groups do
    get 'results', on: :member

    resources :questions
    resources :answer_groups, only: [:new, :create]
  end

  root :to => "question_groups#index"
end
