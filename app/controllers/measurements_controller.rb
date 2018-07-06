class MeasurementsController < ApplicationController
  def index
    render json: current_user.measurements, status: :ok
  end

  def create
    measurement = Measurement.new(measurement_params)
    if current_user.type == 'ElderlyUser'
      measurement.assign_attributes(elderly_user: current_user)
    else
      measurement.assign_attributes(elderly_user: current_user.elderly_user)
    end
    if measurement.save
      render json: measurement, status: :ok
    else
      render json: { errors: measurement.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def delete_all
    current_user.measurements.delete_all
    head :no_content
  end

  def update
    measurement = Measurement.find(params[:id])
    if measurement.update(measurement_params)
      render json: measurement, status: :ok
    else
      render json: { errors: measurement.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def measurement_params
    params.require(:measurement).permit(:measurement_type, :notes, :date, :value)
  end
end
