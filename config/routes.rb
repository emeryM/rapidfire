Rapidfire::Engine.routes.draw do
  resources :question_groups do
    get 'results', on: :member

    resources :questions
    resources :answer_groups, only: [:new, :create]
  end

  get 'send_share_mail', to: 'question_groups#send_share_mail'

  root :to => "question_groups#index"
end
