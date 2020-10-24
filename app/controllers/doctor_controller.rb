class DoctorController < ApplicationController
  def index
    doctors = Doctor.all

    render json: doctors, status: 200
  end

  def create
    doctor = Doctor.new(doctor_params)

    if ! doctor.save
      return render json: {
        errors: doctor.errors
      }, status: 400
    end

    render json: doctor
  end

  def show
    doctor = Doctor.find(params[:id])

    render json: doctor, status: 200
  end

  def update
    doctor = Doctor.find(params[:id])

    if ! doctor.update(doctor_params)
      return render json: {
        errors: doctor.errors
      }, status: 400
    end

    render json: doctor
  end

  def destroy
    doctor = Doctor.find(params[:id])
    doctor_temp = doctor

    if ! doctor.destroy
      return render json: {
        errors: doctor.errors
      }, status: 400
    end

    render json: doctor_temp
  end

  private
    def doctor_params
      params.require(:doctor).permit(:name)
    end
end
