class Api::V1::TicketsController < Api::BaseController
  def create
    ticket = ExternalRequests::BuildTicket.new(
      permitted_params: ticket_params,
      raw_data: params
    ).call

    if ticket.save
      render json: ticket.attributes.except('external_data'), status: :created
    else
      render json: { errors: ticket.errors }, status: :unprocessable_entity
    end
  end

  private

  def ticket_params
    params.permit(
      :RequestNumber,
      :SequenceNumber,
      :RequestType,
      :DateTimes => [:ResponseDueDateTime],
      :ServiceArea => [
        :PrimaryServiceAreaCode => [:SACode],
        :AdditionalServiceAreaCodes => [:SACode]
      ],
      :DigsiteInfo => [:WellKnownText],
      :Excavator => [
        :CompanyName,
        :Address,
        :City,
        :State,
        :Zip,
        :CrewOnsite
      ]
    )
  end
end