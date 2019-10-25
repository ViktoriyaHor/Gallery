ActiveAdmin.register User do
  menu priority: 7
  actions :all, except: [:update, :edit]
  permit_params :email, :password, :password_confirmation, :username
end
