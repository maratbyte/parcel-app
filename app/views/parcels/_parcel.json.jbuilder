json.extract! parcel, :id, :origin, :destination, :weight, :height, :length, :width, :first_name, :last_name, :phone_number, :email, :distance, :price, :created_at, :updated_at
json.url parcel_url(parcel, format: :json)
