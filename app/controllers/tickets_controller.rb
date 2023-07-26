# frozen_string_literal: true

class TicketsController < ApplicationController
  def index
    @tickets = Ticket.includes(:excavator).all
  end

  def show
    @ticket = Ticket.includes(:excavator).find(params[:id])
  end
end
