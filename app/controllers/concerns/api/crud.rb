module Api
  module CRUD
    include ::Reflections

    def index
      render :index, locals: { model_name_low_plural.to_sym => records_collection }
    end

    def show
      respond_with(target_record)
    end

    def create
      created_record = model_class.new(permitted_params)
      save_and_respond(created_record)
    end

    def update
      target_record.assign_attributes(permitted_params)
      save_and_respond(target_record)
    end

    def destroy
      target_record.destroy and respond_with(target_record)
    end

    private

    def target_record
      @target_record ||= records_collection.find(params[:id])
    end

    def records_collection
      @records_collection ||= model_class.all
    end

    def save_and_respond(record)
      if record.save
        respond_with(record)
      else
        render json: record.errors.messages, status: 400
      end
    end

    def respond_with(record)
      render partial: model_name_low_singular, locals: { model_name_low_singular.to_sym => record }
    end
  end
end
