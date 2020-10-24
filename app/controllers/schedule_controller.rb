class ScheduleController < ApplicationController
  def index
    schedules = Schedule.all

    return render json: schedules
  end

  def create
    schedule = Schedule.new(schedule_params)

    if ! schedule.save
      return render json: {
        errors: schedule.errors
      }, status: 400
    end

    return render json: schedule
  end

  def show
    schedule = Schedule.find(params[:id])

    return render json: schedule
  end

  def update
    schedule = Schedule.find(params[:id])

    if ! schedule.update(schedule_params)
      return render json: {
        errors: schedule.errors
      }, status: 400
    end

    return render json: schedule
  end

  def destroy
    schedule = Schedule.find(params[:id])
    schedule_temp = schedule

    if schedule.destroy
      return render json: schedule_temp
    else
      return render "error"
    end
  end

  private
    def schedule_params
      params.require(:schedule).permit(:doctor_id, :hospital_id, :started_at)
    end
end
