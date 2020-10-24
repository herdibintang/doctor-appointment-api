class AppointmentController < ApplicationController
  def index
    appointments = Appointment.all

    render json: appointments.to_json(
      include: [
        :user,
        :schedule => { include: [
          :doctor,
          :hospital
        ]}
      ]
    )
  end

  def create
    schedule = Schedule.find(params[:schedule_id])

    started_at = schedule.started_at
    now = Time.zone.now
    minutes = (started_at - now) / 1.minutes
    
    if minutes < 30
      return render json: {
        message: "Can't book less than 30 minutes before schedule"
      }, status: 400
    end


    count = Appointment.where(schedule_id: params[:schedule_id]).count

    puts count

    if count >= 10
      return render json: {
        message: "Booking is full"
      }, status: 400
    end


    appointment = Appointment.new(appointment_params)

    if appointment.save
      return render json: appointment, status: 200
    else
      return render "error"
    end
  end

  def show
    appointment = Appointment.find(params[:id])

    render json: appointment, status: 200
  end

  def update
    appointment = Appointment.find(params[:id])

    if appointment.update(appointment_params)
      render json: appointment, status: 200
    else
      render "error"
    end
  end

  def destroy
    appointment = Appointment.find(params[:id])
    appointment_temp = appointment

    if appointment.destroy
      render json: appointment_temp, status: 200
    else
      render "error"
    end
  end

  private
    def appointment_params
      params.require(:appointment).permit(:schedule_id, :user_id)
    end
end
