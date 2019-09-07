module Resheet
  class Router
    def initialize(google_sheet_service, spreadsheet_id)
      @google_sheet_service = google_sheet_service
      @spreadsheet_id = spreadsheet_id
    end

    def route(request)
      case request.method
      when 'GET'
        sheet = Resheet::Sheet.new(@google_sheet_service, @spreadsheet_id, request.resource)
        sheet.fetch
        if error = sheet.error
          return Resheet::ErrorResponse.new
        end

        Resheet::Response.new(sheet.records)
      else
        Resheet::ErrorResponse.new
      end
    end
  end
end

