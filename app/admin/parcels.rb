ActiveAdmin.register Parcel do
  permit_params :origin, :destination, :weight, :height, :length, :width, :first_name, :last_name, :phone_number, :email
  config.per_page = [15, 50, 100]

  controller do
    def create
      @parcel = Parcel.new(permitted_params[:parcel])
      begin
        if @parcel.save
          redirect_to admin_parcel_path(@parcel), notice: "Parcel was successfully created."
        else
          render :new, status: :unprocessable_entity
        end
      rescue => e
        @parcel.errors.add(:base, :route_error, message: e.message)
        render :new, status: :unprocessable_entity
      end
    end

    def update
      @parcel = Parcel.find(permitted_params[:id])
      begin
        if @parcel.update(permitted_params[:parcel])
          redirect_to admin_parcel_path(@parcel), notice: "Parcel was successfully updated."
        else
          render :edit, status: :unprocessable_entity
        end
      rescue => e
        @parcel.errors.add(:base, :route_error, message: e.message)
        render :edit, status: :unprocessable_entity
      end
    end
  end

  index do
    selectable_column
    column :id do |parcel|
      link_to parcel.id, admin_parcel_path(parcel)
    end
    column :origin
    column :destination
    column :first_name
    column :last_name
    column :email
    column :distance do |parcel|
      "#{parcel.distance} km"
    end
    column :price do |parcel|
      "#{parcel.price} RUB"
    end
    actions
  end

  preserve_default_filters!
  remove_filter :length
  remove_filter :width
  remove_filter :height
  remove_filter :phone_number
  remove_filter :email
  
  show do
    attributes_table do
      row :origin
      row :destination
      row :weight do |parcel|
        "#{parcel.weight} kg"
      end
      row :height do |parcel|
        "#{parcel.height} cm"
      end
      row :length do |parcel|
        "#{parcel.length} cm"
      end
      row :width do |parcel|
        "#{parcel.width} cm"
      end
      row :first_name
      row :last_name
      row :phone_number
      row :email
      row :distance do |parcel|
        "#{parcel.distance} km"
      end
      row :price do |parcel|
        "#{parcel.price} RUB"
      end
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.semantic_errors
    inputs do
      input :origin
      input :destination
      input :weight
      input :height
      input :length
      input :width
      input :first_name
      input :last_name
      input :phone_number
      input :email
    end
    actions
  end
  
end
