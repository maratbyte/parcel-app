ActiveAdmin.register Parcel do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :origin, :destination, :weight, :height, :length, :width, :first_name, :last_name, :phone_number, :email
  #
  # or
  #
  # permit_params do
  #   permitted = [:origin, :destination, :weight, :height, :length, :width, :first_name, :last_name, :phone_number, :email, :distance, :price]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
