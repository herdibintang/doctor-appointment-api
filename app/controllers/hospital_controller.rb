class HospitalController < ApplicationController
  def index
    hospitals = Hospital.all

    render json: hospitals, status: 200
  end

  def create
    hospital = Hospital.new(hospital_params)

    if ! hospital.save
      return render json: {
        errors: hospital.errors
      }, status: 400
    end

    render json: hospital
  end

  def show
    hospital = Hospital.find(params[:id])

    render json: hospital, status: 200
  end

  def update
    hospital = Hospital.find(params[:id])

    if ! hospital.update(hospital_params)
      return render json: {
        errors: hospital.errors
      }, status: 400
    end

    render json: hospital
  end

  def destroy
    hospital = Hospital.find(params[:id])
    hospital_temp = hospital

    if ! hospital.destroy
      return render json: {
        errors: hospital.errors
      }, status: 400
    end

    render json: hospital_temp
  end

  private
    def hospital_params
      params.require(:hospital).permit(:name)
    end
end
