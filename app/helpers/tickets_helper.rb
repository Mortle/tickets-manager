# frozen_string_literal: true

module TicketsHelper
  def format_polygon_data(ticket)
    ticket.polygon[9...-2].split(',').map { |point| point.split.map(&:to_f) }
  end
end
